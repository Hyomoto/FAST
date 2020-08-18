/// @func script_add_function
/// @param name
/// @param args...
/// @param function
function script_add_function( _name ){
	static manager	= ScriptManager();
	
	if ( manager.commands[? _name ] != undefined ) {
		manager.logger.write( "[script_add_function] Could not add \"", _name, "\": function already defined! Skipped." );
		
		return false;
		
	}
	var _args;
	
	if ( argument_count - 2 > 0 && is_array( argument[ 1 ] ) ) {
		_args	= argument[ 1 ];
		
	} else {
		_args	= array_create( argument_count - 2 );
		
		var _i = 1; repeat( array_length( _args ) ) {
			_args[ _i - 1 ]	= argument[ _i ];
			
			++_i;
			
		}
		
	}
	var _function	= argument[ argument_count - 1 ];
	
	manager.command( new ScriptFunction( _name, _args, _function ) );
	
	return true;
	
}
