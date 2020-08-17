/// @func script_get_value
/// @param value
/// @param local
/// @param engine
function script_get_value( _value, _local, _engine ){
	switch ( _value.code ) {
		case SCRIPT_VALUE		: _engine.stack.push( _value.value ); break;
		case SCRIPT_EXPRESSION	: script_evaluate( _value.value, _local, _engine ); break;
		case SCRIPT_VARIABLE	:
			if ( variable_struct_exists( _local, _value.value ) ) {
				_engine.stack.push( variable_struct_get( _local, _value.value ) );
				
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
			_command( _engine.stack );
			
	}
	return 0;
	
}
