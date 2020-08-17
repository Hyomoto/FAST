/// @func log_nonfatal
/// @param id
/// @param event
/// @param values...
function log_nonfatal( _id, _event ) {
	if ( ERROR_LEVEL >= ERROR_NONFATAL ) {
		static instance	= new Logger( "nonfatal", FAST_LOGGER_DEFAULT_LENGTH, System, new FileText( "log/nonfatal.txt" ) );
		
		var _string	= ( is_undefined( _id ) ? "" : string( _id ) ) + " [" + _event + "] ";
		
		var _i = 2; repeat( argument_count - 2 ) {
			_string	+= string( argument[ _i++ ] );
			
		}
		instance.write( _string );
		
	}
	
}
