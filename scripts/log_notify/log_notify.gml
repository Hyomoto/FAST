/// @func log_notify
/// @param {intp}	id			the source instance, should be an instance
/// @param {string}	event		the name of the event that should be logged
/// @param {mixed}	values...	any number of values
/// @desc Writes `values...` to the system output when ERROR_LEVEL >= ERROR_NOTIFY
/// @example
//log_debug( id, "load", "Could not load, ", _value, ". File doesn't exist." )
/// @wiki Logging-Index Functions
function log_notify( _id, _event ) {
	if ( FAST_ERROR_LOG & FAST_LOGGER_NOTIFY ) {
		static instance	= new Logger( "notify", SystemOutput );
		
		var _string	= ( is_undefined( _id ) ? "<undefined>" : string( _id ) ) + " [" + _event + "] ";
		
		var _i = 2; repeat( argument_count - 2 ) {
			_string	+= string( argument[ _i++ ] );
			
		}
		instance.write( _string );
		
	}
	
}
