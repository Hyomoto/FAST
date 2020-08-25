function ScriptEngine_Value( _value, _type ) constructor {
	get		= function( _engine, _local ) {
		if ( type == SCRIPT_EXPRESSION_TYPE_VARIABLE ) {
			if ( variable_struct_exists( _local, value ) ) {
				return variable_struct_get( _local, value );
				
			}
			return _engine.get_value( value )
			
		}
		return value;
		
	}
	toString	= function() {
		return "SE::Value -> " + string( value );
		
	}
	value	= _value;
	type	= _type;
	
}
function ScriptEngine_Operator( _precedence ) constructor {
	toString	= function() {
		return "SE::Operator -> " + string( prec );
		
	}
	prec	= _precedence;						// the operator precedence, higher is higher
	type	= SCRIPT_EXPRESSION_TYPE_OPERAND;	// the value type, is OPERAND
	rao		= false;							// right-associated operation, applies only to right-side
	
}
function ScriptEngine_Function( _value ) constructor {
	static get	= function( _engine, _local ) {
		var _i = 0; repeat( array_length( args ) ) {
			queue.enqueue( script_evaluate_expression( _engine, _local, args[ _i++ ] ) );
			
		}
		var _func	= _engine.funcs[? func ];
		var _result	= undefined;
		
		if ( is_struct( _func ) ) {
			var _args	= {};
			var _arg;
			
			//_func.file.reset();
			
			var _i = 0; repeat( array_length( _func.args ) ) {
				_arg	= ( queue.empty() ? undefined : queue.dequeue() );
				
				variable_struct_set( _args, _func.args[ _i++ ], _arg );
				
			}
			//_func.file.local	= _args;
			_result	= _func.target.execute( _engine, _args );
			
		} else {
			switch ( queue.size() ) {
				case 0 : _result	= _func(); break;
				case 1 : _result	= _func( queue.dequeue() ); break;
				case 2 : _result	= _func( queue.dequeue(), queue.dequeue() ); break;
				case 3 : _result	= _func( queue.dequeue(), queue.dequeue(), queue.dequeue() ); break;
				case 4 : _result	= _func( queue.dequeue(), queue.dequeue(), queue.dequeue(), queue.dequeue() ); break;
				case 5 : _result	= _func( queue.dequeue(), queue.dequeue(), queue.dequeue(), queue.dequeue(), queue.dequeue() ); break;
				case 6 : _result	= _func( queue.dequeue(), queue.dequeue(), queue.dequeue(), queue.dequeue(), queue.dequeue(), queue.dequeue() ); break;
				case 7 : _result	= _func( queue.dequeue(), queue.dequeue(), queue.dequeue(), queue.dequeue(), queue.dequeue(), queue.dequeue(), queue.dequeue() ); break;
				case 8 : _result	= _func( queue.dequeue(), queue.dequeue(), queue.dequeue(), queue.dequeue(), queue.dequeue(), queue.dequeue(), queue.dequeue(), queue.dequeue() ); break;
				default: _result	= _func( queue.dequeue(), queue.dequeue(), queue.dequeue(), queue.dequeue(), queue.dequeue(), queue.dequeue(), queue.dequeue(), queue.dequeue(), queue.dequeue() ); break;
				
			}
			
		}
		queue.clear();
		
		return _result;
		
	}
	toString	= function() {
		var _string	= "SE::Func -> " + string( func ) + "(";
		
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
	func	= string_copy( _value, 1, _open - 1 );
	type	= SCRIPT_EXPRESSION_TYPE_FUNCTION;
	
	while( true ) {
		_x = string_find_first( "\",", _args, _l );
		
		switch ( string_char_at( _args, _x ) ) {
			case "\""	:
				_l = string_pos_ext( "\"", _args, _x + 1 );
				
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
		_t	= string_trim( string_delete( _args, 1, _i ) );
		
		if ( _t != "" ) {
			queue.enqueue( _t );
			
		}
		break;
		
	}
	args	= array_create( queue.size() );
	
	var _i = 0; repeat( array_length( args ) ) {
		args[ _i++ ]	= new ScriptExpression( queue.dequeue() );
		
	}
	
}