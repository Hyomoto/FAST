// # The default length that a logger will used when none is specified
#macro FAST_LOGGER_DEFAULT_LENGTH	144

// # this determines what errors will be shown by FAST
#macro ERROR_LEVEL		4

// # these are the error levels
#macro FAST_LOGGER_CRITICAL	1
#macro FAST_LOGGER_NONFATAL	2
#macro FAST_LOGGER_NOTIFY	3
#macro FAST_LOGGER_DEBUG	4

FAST.feature( "FLOG", "Logging", (1 << 32 ) + ( 1 << 16 ) + 1, "10/10/2020" );

#macro LogManager	( __FAST_logging_init() )

/// @func __FAST_logging_init
/// @desc	__FAST_logging_init is a wrapper for internal logging system functions. It hooks the system up
//		to the FAST event framework, and saves open files when the program closes.
/// @wiki Core-Index Logging
function __FAST_logging_init() {
	static manager	= function() constructor {
		static log	= SystemOutput;
		static add	= function( _debugger ) {
			ds_list_add( __List, _debugger );
			
		}
		static toString	= function() {
			var _string	= "Loggers : ";
			var _i = 0; repeat( ds_list_size( __List ) ) {
				if ( _i > 0 ) { _string += ", " }
				
				_string	+= __List[| _i++ ].name;
				
			}
			return _string;
			
		}
		// close out all open loggers when program ends
		close	= new FrameEvent( FAST_EVENT_GAME_END, 0, function() {
			log.write( "Logger :: Logging is shutting down..." );
			
			var _i	= 0; repeat( ds_list_size( __List ) ) {
				var _target	= ds_list_find_value( __List, _i++ );
				
				//try {
					_target.close();
					
				//}
				//catch ( _ ) {
				//	log.write( "Logger :: Log " + _target.__Name + " failed to close properly." );
					
				//}
				
			}
			ds_list_destroy( __List );
			
		}).once();
		
		__List	= ds_list_create();
		
	}
	static instance = new manager();
	return instance;
	
}
