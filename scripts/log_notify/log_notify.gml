/// @func log_notify
/// @param id
/// @param event
/// @param values...
function log_notify( _id, _event ) {
	if ( ERROR_LEVEL >= ERROR_NOTIFY ) {
		static instance	= new Logger( "notify", System );
		
		var _string	= ( is_undefined( _id ) ? "" : string( _id ) ) + "[" + _event + "] ";
		
		var _i = 2; repeat( argument_count - 2 ) {
			_string	+= string( argument[ _i++ ] );
			
		}
		instance.write( _string );
		
	}
	
}
