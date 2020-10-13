/// @func ScriptExpression
/// @param expression
/// @wiki Scripting-Index
function ScriptExpression( _string ) : DsWalkable() constructor {
	static validate	= function( _script, _statement ) {
		var _header	= _script.source + "(line " + string( _statement.line + _script.isFunction ) + ") ";
		var _last	= undefined;
		var _next;
		
		start();
		
		while ( has_next() ) {
			_next	= next();
			
			switch ( instanceof( _next ) ) {
				case "ScriptEngine_Operator" :
					if ( _last == undefined ) {
						if ( _next.rao == false ) { _script.errors += 1;
							ScriptManager().log( _header, "Statement expression starts with a left-hand operator: ", _next.value ); }
						
					} else if ( instanceof( _last ) == "ScriptEngine_Operator" && _next.rao == false ) { _script.errors += 1;
						ScriptManager().log( _header, "Statement expression illegal operator use: ", _last.value, " ", _next.value );
						
					} else if ( has_next() == false ) { _script.errors += 1;
						ScriptManager().log( _header, "Statement expression is incomplete." );
						
					}
					break;
					
				case "ScriptEngine_Value" :
					if ( _last != undefined && instanceof( _last ) != "ScriptEngine_Operator" ) { _script.errors += 1;
						ScriptManager().log( _header, "Statement expression missing operator: ", _last.value, " ", _next.value ); }
						
					if ( ScriptManager().is_reserved( _next.value ) > -1 ) { _script.errors += 1;
						ScriptManager().system.write( _header + "Statement uses reserved keyword, " + string( _next.value ) + ", as variable name." ); }
						
					break;
					
				case "ScriptEngine_Function" :
					if ( _last != undefined && instanceof( _last ) != "ScriptEngine_Operator" ) { _script.errors += 1;
						ScriptManager().system.write( _header + "Statement expression missing operator: " + _last.value + _next.func ); }
					
					//if ( ScriptManager().is_reserved( _next.func ) > -1 ) {
					//	ScriptManager().system.write( _header + "Statement expression function name is reserved keyword: " + _next.func ); }
					
					break;
					
			}
			_last	= _next;
			
		}
		
	}
	static get	= function( _engine, _package ) {
		return script_evaluate_expression( _engine, _package, self );
		
	}
	var _manager= ScriptManager();
	var _parser	= _manager.parser;
	var _next, _char, _len;
	
	_parser.parse( _string );
	
	while ( _parser.has_next() ) {
		_next	= _parser.next();
		
		_char	= string_char_at( _next, 1 );
		_len	= string_length( _next );
		
		if ( _char == "\"" ) { // string
			add( new ScriptEngine_Value(
				string_copy( _next, 2, _len - 2 ),
				SCRIPT_EXPRESSION_TYPE_STRING
			));
			
		} else if ( _char == "(" ) { // expression
			var _last	= _parser.last;
			
			add( new ScriptExpression( string_copy( _next, 2, _len - 2 ) ) );
			
			_parser.parse( _string );
			_parser.last	= _last;
			
		} else if ( string_pos( "->", _next ) > 0 && string_pos( "->", _next ) == _len - 1 ) { // cast
			var _op	= add( new ScriptEngine_Operator( "cast", 10 ) ).value;
			
			_op.execute	= _manager.casts[? string_copy( _next, 1, _len - 2 ) ];
			_op.rao		= true;
			
		} else if ( string_pos( _char, "/*+-" ) > 0 ) { // operator
			var _last	= ( final == undefined ? undefined : final.value );
			var _op		= add( new ScriptEngine_Operator( _char, 4 ) ).value;
			
			switch ( _next ) {
				case "/" : _op.execute	= method( _op, function( _a, _b ) { return _a / _b; } ); _op.prec = 5; break;
				case "*" : _op.execute	= method( _op, function( _a, _b ) { return _a * _b; } ); _op.prec = 5; break;
				case "+" : _op.execute	= method( _op, function( _a, _b ) { return _a + _b; } ); break;
				case "-" :
					if ( _last == undefined || instanceof( _last ) == "ScriptEngine_Operator" ) {
						_op.execute	= method( _op, function( _a ) { return -_a; } );
						_op.rao		= true;
						
					} else {
						_op.execute	= method( _op, function( _a, _b ) { return _a - _b; } );
						
					}
					break;
				
			}
			
		} else if ( string_find_first( "!=<>&|", _char, 0 ) > 0) { // comparison
			var _op	= add( new ScriptEngine_Operator( _next, 0 ) ).value;
			
			switch ( _next ) {
				case ">" : _op.execute	= function( _a, _b ) { return _a > _b; }; break;
				case ">=" : _op.execute	= function( _a, _b ) { return _a >= _b; }; break;
				case "<" : _op.execute	= function( _a, _b ) { return _a < _b; }; break;
				case "<=" : _op.execute	= function( _a, _b ) { return _a <= _b; }; break;
				case "==" : _op.execute	= function( _a, _b ) { return _a == _b; }; break;
				case "!=" : _op.execute	= function( _a, _b ) { return _a != _b; }; break;
				case "&" : _op.execute	= function( _a, _b ) { return _a & _b; }; _op.prec = 1; break;
				case "&&" : _op.execute	= function( _a, _b ) { return _a && _b; }; break;
				case "|" : _op.execute	= function( _a, _b ) { return _a | _b; }; _op.prec = 1; break;
				case "||" : _op.execute	= function( _a, _b ) { return _a || _b; }; break;
				
			}
		
		} else if ( string_pos( "(", _next ) > 0 ) { // function
			var _last	= _parser.last;
			
			add( new ScriptEngine_Function( _next ) );
						
			_parser.parse( _string );
			_parser.last	= _last;
			
		} else if ( _next == "null" ) { // undefined
			add( new ScriptEngine_Value( undefined, SCRIPT_EXPRESSION_TYPE_OTHER ) );
			
		} else if ( _next == "true" ) {
			add( new ScriptEngine_Value( 1, SCRIPT_EXPRESSION_TYPE_NUMBER ) );
			
		} else if ( _next == "false" ) {
			add( new ScriptEngine_Value( 0, SCRIPT_EXPRESSION_TYPE_NUMBER ) );
			
		} else if ( _next == "or" ) {
			var _op	= add( new ScriptEngine_Operator( "||", 4 ) ).value;
			
			_op.execute	= function( _a, _b ) { return _a || _b; };
			
		} else if ( _next == "and" ) {
			var _op	= add( new ScriptEngine_Operator( "&&", 4 ) ).value;
			
			_op.execute	= function( _a, _b ) { return _a && _b; };
			
			
		} else if ( _next == "is" || _next == "equals" ) {
			var _op	= add( new ScriptEngine_Operator( "==", 4 ) ).value;
			
			_op.execute	= function( _a, _b ) { return _a == _b; };
			
		} else if ( _next == "not" ) { // not
			var _op	= add( new ScriptEngine_Operator( _next, 7 ) ).value;
			
			_op.execute	= function( _a ) { return not _a };
			_op.rao		= true;
			
		} else if ( ord( _char ) >= 0x41 ) { // variable
			add( new ScriptEngine_Value( _next, SCRIPT_EXPRESSION_TYPE_VARIABLE ) );
			
		} else { // number
			add( new ScriptEngine_Value( string_to_real( _next ), SCRIPT_EXPRESSION_TYPE_NUMBER ) );
			
		}
		
	}
	
}
