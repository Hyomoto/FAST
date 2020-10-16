/// @func log_nonfatal
/// @param {intp}	id			the source instance, should be an instance
/// @param {string}	event		the name of the event that should be logged
/// @param {mixed}	values...	any number of values
/// @desc Writes `values...` to the system output and log/nonfatal.txt when ERROR_LEVEL >= ERROR_NONFATAL
/// @example
//log_debug( id, "load", "Could not load, ", _value, ". File doesn't exist." )
/// @wiki Core-Index Logging
function log_nonfatal( _id, _event ) {
	if ( ERROR_LEVEL >= ERROR_NONFATAL ) {
		static instance	= new Logger( "nonfatal", FAST_LOGGER_DEFAULT_LENGTH, System, new FileText( "log/nonfatal.txt", false, true ) );
		
		var _string	= ( is_undefined( _id ) ? "" : string( _id ) ) + " [" + _event + "] ";
		
		var _i = 2; repeat( argument_count - 2 ) {
			_string	+= string( argument[ _i++ ] );
			
		}
		instance.write( _string );
		
	}
	
}
