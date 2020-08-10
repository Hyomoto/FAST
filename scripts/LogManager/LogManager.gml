/// @func LogManager
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
		close	= new EventOnce( FAST.GAME_END, 0, undefined, function() {
			log( "FAST Logging is shutting down..." );
			
			var _i	= 0; repeat( ds_list_size( list ) ) {
				list[| _i++ ].close();
				
			}
			
		});
		list	= ds_list_create();
		
	}
	static instance = new Feature( "FAST Logging", "1.1", "08/03/2020", new manager() );
	return instance.struct;
	
}
