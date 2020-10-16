#macro FAST_LOGGER_DEFAULT_LENGTH	144

/// @func LogManager
/// @wiki Core-Index Logging
function LogManager() {
	static manager	= function() constructor {
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
			syslog( list );
			var _i	= 0; repeat( ds_list_size( list ) ) {
				ds_list_find_value( list, _i++ ).close();
				
			}
			
		}).once();
		list	= ds_list_create();
		syslog( "LOG ", list );
	}
	static instance = new Feature( "FAST Logging", "1.1a", "10/10/2020", new manager() );
	return instance.struct;
	
}
LogManager();
