/// @func log_critical
/// @param id
/// @param event
/// @param values...
function log_critical( _id, _event ) {
	if ( ERROR_LEVEL >= ERROR_CRITICAL ) {
		static instance	= new Logger( "critical", System, new FileText( "log/critical.txt" ) );
		
		var _string	= ( is_undefined( _id ) ? "" : string( _id ) ) + " [" + _event + "] ";
		
		for ( var _i = 2; _i < argument_count; ++_i ) {
			_string	+= string( argument[ _i ] );
			
		}
		instance.write( _string );
		
	}
	
}
