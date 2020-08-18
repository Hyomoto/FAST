/// @func script_get_value
/// @param expression
/// @param local
/// @param engine
function script_get_value( _expression, _local, _engine ){
	var _value	= _expression.next();
	
	switch ( _value.code ) {
		case SCRIPT_CAST		: 
			script_get_value( _expression, _local, _engine );
			
			try {
				switch ( _value.value ) {
					case "string" : _engine.stack.push( string( _engine.stack.pop() ) ); break;
					case "number" : _engine.stack.push( real( _engine.stack.pop() ) ); break;
				
				}
				
			} catch ( _ ) {
				_engine.log( "script_get_value", "Cast ", _expression.last().value, " to ", _value.value, " failed." );
				_engine.error	= 1;
				
				return -1;
				
			}
			break;
			
		case SCRIPT_VALUE		: _engine.stack.push( _value.value ); break;
		case SCRIPT_EXPRESSION	: script_evaluate( _value.value, _local, _engine ); break;
		case SCRIPT_VARIABLE	:
			if ( variable_struct_exists( _local, _value.value ) ) {
				_engine.stack.push( variable_struct_get( _local, _value.value ) );
				
				break;
				
			}
			_engine.stack.push( _engine.get_value( _value.value ) );
			
			break;
			
		case SCRIPT_FUNCTION	:
			var _command	= ScriptManager().commands[? _value.value ];
			
			if ( _command == undefined ) {
				_engine.log( "script_get_value", "Command ", _value.value, " was not registered in ScriptManager()." );
				
				return -1;
				
			}
			var _i = array_length( _value.args ); repeat( _i ) {
				script_evaluate( _value.args[ --_i ], _local, _engine );
				
			}
			_command.execute( _engine );
			
			break;
			
	}
	return 0;
	
}
