/// @func Logger
/// @param {string}				name		The name of the logger, will be used to differentiate its output
/// @param {__OutputStream__}	Outputs...	The outputs that this Logger will write to
/// @desc	The Logger makes it easy to write outputs to multiple streams.  A common use case is if you
///		wanted to write something to both the GMS output window as well as a text file.  If FAST events
///		are not disabled, all open Loggers will be closed when the game ends.  Since logger must make
///		use of the outputs, it must keep them open.  If you would like to change this behavior, use
///		a {#BufferedOutput} instead.
/// @example
//global.debug	= new Logger( "debug", FAST_LOGGER_DEFAULT_LENGTH, System, new FileText( "log/debug.text" ) )
//
//debug.write( "Hello World!" );
/// @wiki Logging-Index Constructors
function Logger( _name, _output ) constructor {
	static write	= function() {
		var _string = __Name + " :: ", _i = 0; repeat( argument_count ) {
			_string	+= string( argument[ _i++ ] );
			
		}
		var _i = -1; repeat( array_length( __Outputs ) ) { ++_i;
			__Outputs[ _i ].write( _string + ( __Outputs[ _i ] == SystemOutput ? "" : "\n" ));
			
		}
		
	}
	/// @desc Calls close() on all of the provided outputs. 
	static close	= function() {
		var _i = 0; repeat( array_length( __Outputs ) ) {
			__Outputs[ _i++ ].close();
			
		}
		if ( __Logs__ != undefined && ds_list_find_index( __Logs__, self ) > -1 )
			ds_list_delete( __Logs__, ds_list_find_index( __Logs__, self ));
		
		syslog( "Logger :: ", __Name, " closed succesfully." );
		
	}
	/// @desc Returns the name of this Logger, for debugging purposes.
	static toString	= function() {
		return __Name;
		
	}
	/// @var {int}	If FAST events are disabled, returns undefined. Otherwise used to manage the log list.
	/// @output	undefined or int
	static __Logs__	= ( function() {
		if ( FAST_DISABLE_EVENTS ) { return undefined; }
		
		var _list	= ds_list_create();
		
		var _event	= new FrameEvent( FAST_EVENT_GAME_END, 0, function( _list ) {
			syslog( "Logger :: Closing all opened loggers..." );
			
			var _i	= 0; repeat( ds_list_size( _list ) ) {
				var _target	= ds_list_find_value( _list, 0 );
				
				try {
					_target.close();
				
				} catch ( _ ) {
					syslog( new LoggerError().from_error( _ ) );
					
				}
				
			}
			ds_list_destroy( _list );
			
		}).once().parameter( _list );
		
		return _event.__Param;
		
	})();
	/// @desc An array of the outputs this Logger writes to.
	__Outputs	= array_create( argument_count - 1 );
	
	var _i = 1; repeat( argument_count - 1 ) {
		__Outputs[ _i - 1 ]	= argument[ _i ];
		++_i;
		
	}
	/// @desc The name of this Logger.
	__Name	= _name;
	
	write( _name + " opened " + date_datetime_string(date_current_datetime()) );
	
	if ( __Logs__ != undefined ) {
		ds_list_add( __Logs__, self );
		
	}
	
}
