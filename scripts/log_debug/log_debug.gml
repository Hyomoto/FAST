/// @func log_debug
/// @param id
/// @param event
/// @param values...
function log_debug( _id, _event ) {
	if ( ERROR_LEVEL >= ERROR_DEBUG ) {
		static instance	= new Logger( "debug", System );
		
		var _string	= ( is_undefined( _id ) ? "" : string( _id ) ) + " [" + _event + "] ";
		
		var _i = 2; repeat( argument_count - 2 ) {
			_string	+= string( argument[ _i++ ] );
			
		}
		instance.write( _string );
		
	}
	
}
