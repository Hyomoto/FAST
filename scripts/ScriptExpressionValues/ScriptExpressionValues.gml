function ScriptEngine_Value( _value, _type ) constructor {
	get		= function( _engine, _package ) {
		if ( type == SCRIPT_EXPRESSION_TYPE_VARIABLE ) {
			if ( value == "{}" ) {
				return {};
				
			}
			return script_evaluate_traverse( _engine, _package, value );
			
		}
		return value;
		
	}
	toString	= function() {
		return "SE::Value -> " + string( value );
		
	}
	value	= _value;
	type	= _type;
	
}
function ScriptEngine_Operator( _value, _precedence ) constructor {
	toString	= function() {
		return "SE::Operator -> " + string( value );
		
	}
	value	= _value;
	prec	= _precedence;						// the operator precedence, higher is higher
	type	= SCRIPT_EXPRESSION_TYPE_OPERAND;	// the value type, is OPERAND
	rao		= false;							// right-associated operation, applies only to right-side
	
}
function ScriptEngine_Function( _value ) constructor {
	static get	= function( _engine, _package ) {
		if ( value == "pop" ) { return _engine.stack.pop(); }
		
		var _args	= array_create( array_length( args ) );
		
		var _i = 0; repeat( array_length( args ) ) {
			_args[ _i ]	= script_evaluate_expression( _engine, _package, args[ _i ] );
			
			++_i;
			
		}
		var _ref, _func;
		
		if ( traverse == "" ) {
			_func	= _engine.scripts[? value ];
			_ref	= _engine;
			
		} else {
			_ref	= script_evaluate_traverse( _engine, _package, traverse );
			
			if ( _ref == undefined ) {
				_engine.log( "ScriptEngine_Function", "Function at \"" + traverse + "\" not defined. Failed." );
				
				return;
				
			}
			if ( is_struct( _ref ) ) { _func	= variable_struct_get( _ref, value ); }
			else { _func	= variable_instance_get( _ref, value ); }
			
		}
		var _result	= undefined;
		
		if ( _func == undefined ) {
			_engine.log( "ScriptEngine_Function", "Function \"" + value + "\" not defined. Failed." );
			
			return;
			
		}
		with( _ref ) {
			if ( is_struct( _func ) ) {
				var _local	= {};
				
				if( _func.isFunction ) {
					var _i = 0; repeat( array_length( _func.args ) ) {
						variable_struct_set( _local, _func.args[ _i ], _args[ _i ] );
						
						++_i;
						
					}
					
				} else {
					var _i = 0; repeat( array_length( _args ) ) {
						_engine.stack.push( _args[ _i ] );
						
						++_i;
						
					}
					
				}
				_engine.executionStack.push( { script : _func, statement : undefined, local : _local, last : undefined, depth : -1 } );
				_result	= _func.execute( _engine );
				
			} else {
				switch ( array_length( _args ) ) {
					case 0 : _result	= _func(); break;
					case 1 : _result	= _func( _args[ 0 ] ); break;
					case 2 : _result	= _func( _args[ 0 ], _args[ 1 ] ); break;
					case 3 : _result	= _func( _args[ 0 ], _args[ 1 ], _args[ 2 ] ); break;
					case 4 : _result	= _func( _args[ 0 ], _args[ 1 ], _args[ 2 ], _args[ 3 ] ); break;
					case 5 : _result	= _func( _args[ 0 ], _args[ 1 ], _args[ 2 ], _args[ 3 ], _args[ 4 ] ); break;
					case 6 : _result	= _func( _args[ 0 ], _args[ 1 ], _args[ 2 ], _args[ 3 ], _args[ 4 ], _args[ 5 ] ); break;
					case 7 : _result	= _func( _args[ 0 ], _args[ 1 ], _args[ 2 ], _args[ 3 ], _args[ 4 ], _args[ 5 ], _args[ 6 ] ); break;
					case 8 : _result	= _func( _args[ 0 ], _args[ 1 ], _args[ 2 ], _args[ 3 ], _args[ 4 ], _args[ 5 ], _args[ 6 ], _args[ 7 ] ); break;
					default: _result	= _func( _args[ 0 ], _args[ 1 ], _args[ 2 ], _args[ 3 ], _args[ 4 ], _args[ 5 ], _args[ 6 ], _args[ 7 ], _args[ 8 ] ); break;
					
				}
				
			}
			return _result;
			
		}
		
	}
	static toString	= function() {
		var _string	= "SE::Func -> " + ( traverse != "" ? traverse + "." + string( value ) : string( value ) ) + "(";
		
		var _i = 0; repeat( array_length( args ) ) {
			if ( _i > 0 ) { _string	+= ", "; }
			
			_string	+= string( args[ _i++ ] );
			
		}
		return _string + ")";
		
	}
	var _len	= string_length( _value );
	var _open	= string_pos( "(", _value );
	var _args	= string_copy( _value, _open + 1, _len - _open - 1 );
	var _l		= 0;
	var _i		= 0; 
	var _x, _t;
	
	queue	= new DsQueue();
	value	= string_copy( _value, 1, _open - 1 );
	traverse= "";
	type	= SCRIPT_EXPRESSION_TYPE_FUNCTION;
	
	while ( string_pos( ".", value ) > 0 ) {
		if ( traverse != "" ) { traverse += "."; }
		
		var _point	= string_pos( ".", value );
		
		traverse	+= string_copy( value, 1, _point - 1 );
		value		= string_delete( value, 1, _point );
		
	}
	while( _l < string_length( _args ) ) {
		_x = string_find_first( "\",(", _args, _l );
		
		if ( _x == 0 ) { break; }
		
		switch ( string_char_at( _args, _x ) ) {
			case "\"" : case "(" :
				//_l = string_pos_ext( "\"", _args, _x + 1 );
				var _seek	= string_char_at( _args, _x );
				var _alts	= [ "\"", ")" ];
				var _test	= _alts[ string_pos( _seek, "\"(" ) - 1 ];
				var _close	= 0;
				var _t;
				
				var _z = _x + 1; repeat( string_length( _args ) - _x ) {
					_t	= string_char_at( _args, _z );
					
					if ( _t == _seek && _test != "\"" ) { ++_close; }
					
					if ( _t == _test && --_close < 0 ) {
						break;
						
					}
					++_z;
					
				}
				_l	= _z;
				
				continue;
				
			case ","	: 
				_t	= string_trim( string_copy( _args, _i + 1, _x - _i - 1 ) );
				
				if ( _t != "" ) {
					queue.enqueue( _t );
					
				}
				_i	= _x;
				_l	= _x;
				
				continue;
				
		}
		break;
		
	}
	_t	= string_trim( string_delete( _args, 1, _i ) );
	
	if ( _t != "" ) {
		queue.enqueue( _t );
		
	}
	args	= array_create( queue.size() );
	
	var _i = 0; repeat( array_length( args ) ) {
		args[ _i++ ]	= new ScriptExpression( queue.dequeue() );
		
	}
	
}