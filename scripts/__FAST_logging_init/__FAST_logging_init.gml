// # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//								User-definable Macros
// # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// # The length of a string that loggers will add line breaks at
#macro FAST_LOGGER_DEFAULT_LENGTH	144

// # Sets whether or not log_critical, log_nonfatal, log_notify, or log_debug are logged
//		Remove them by commenting out which ones should be ignored.
#macro FAST_ERROR_LOG	0\
						+ FAST_LOGGER_CRITICAL \
						+ FAST_LOGGER_NONFATAL \
						+ FAST_LOGGER_NOTIFY \
						+ FAST_LOGGER_DEBUG

// # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// #							End of User Defines
// # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// # these are the error levels
#macro FAST_LOGGER_CRITICAL	0x1
#macro FAST_LOGGER_NONFATAL	0x2
#macro FAST_LOGGER_NOTIFY	0x4
#macro FAST_LOGGER_DEBUG	0x8

FAST.feature( "FLOG", "Logging", (1 << 32 ) + ( 1 << 16 ) + 1, "10/10/2020" );

/// @func LoggerError
/// @desc	Thrown when a logger causes an error.
/// @wiki Logging-Index Errors
function LoggerError( _name, _msg ) : __Error__() constructor {
	message	= conc( _name, " caused an error. ", _msg );
}


//#macro LogManager	( __FAST_logging_init() )

// @func __FAST_logging_init
// @desc	__FAST_logging_init is a wrapper for internal logging system functions. It hooks the system up
//		to the FAST event framework, and saves open files when the program closes.
//function __FAST_logging_init() {
//	static manager	= function() constructor {
//		static log	= SystemOutput;
//		static add	= function( _debugger ) {
//			ds_list_add( __List, _debugger );
			
//		}
//		static toString	= function() {
//			var _string	= "Loggers : ";
//			var _i = 0; repeat( ds_list_size( __List ) ) {
//				if ( _i > 0 ) { _string += ", " }
				
//				_string	+= __List[| _i++ ].name;
				
//			}
//			return _string;
			
//		}
//		// close out all open loggers when program ends
//		close	= new FrameEvent( FAST_EVENT_GAME_END, 0, function() {
//			log.write( "Logger :: Logging is shutting down..." );
			
//			var _i	= 0; repeat( ds_list_size( __List ) ) {
//				var _target	= ds_list_find_value( __List, _i++ );
				
//				//try {
//					_target.close();
					
//				//}
//				//catch ( _ ) {
//				//	log.write( "Logger :: Log " + _target.__Name + " failed to close properly." );
					
//				//}
				
//			}
//			ds_list_destroy( __List );
			
//		}).once();
		
//		__List	= ds_list_create();
		
//	}
//	static instance = new manager();
//	return instance;
	
//}
