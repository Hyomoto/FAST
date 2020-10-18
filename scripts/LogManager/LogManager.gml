#macro FAST_LOGGER_DEFAULT_LENGTH	144

/// @func LogManager
/// @desc	LogManager is a wrapper for internal logging system functions. It hooks the system up
//		to the FAST event framework, and saves open files when the program closes.
/// @wiki Core-Index Logging
function LogManager() {
	static manager	= function() constructor {
		static log	= function() {
			static logger	= new Logger( "file", FAST_LOGGER_DEFAULT_LENGTH, System );
			
			var _string	= "";
			
			var _i = 0; repeat( argument_count ) {
				_string	+= string( argument[ _i++ ] );
				
			}
			logger.write( _string );
			
		}
		static add	= function( _debugger ) {
			ds_list_add( list, _debugger );
			
		}
		static toString	= function() {
			var _string	= "Loggers : ";
			var _i = 0; repeat( ds_list_size( list ) ) {
				if ( _i > 0 ) { _string += ", " }
				
				_string	+= list[| _i++ ].name;
				
			}
			return _string;
			
		}
		// close out all open loggers when program ends
		close	= new FrameEvent( FAST.GAME_END, 0, undefined, function() {
			System.write( "FAST Logging is shutting down..." );
			
			var _i	= 0; repeat( ds_list_size( list ) ) {
				ds_list_find_value( list, _i++ ).close();
				
			}
			
		}).once();
		
		list	= ds_list_create();
		
	}
	static instance = new Feature( "FAST Logging", "1.1a", "10/10/2020", new manager() );
	return instance.struct;
	
}
LogManager();
