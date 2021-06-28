/// @func Logger
/// @param {string}				name		The name of the logger, will be used to differentiate its output
/// @param {__OutputStream__}	Outputs...	The outputs that this Logger will write to
/// @desc	The Logger makes it easy to write outputs to multiple streams.  A common use case is if you
///		wanted to write something to both the GMS output window as well as a text file.  If FAST events
///		are not disabled, all open Loggers will be closed when the game ends.  By default Logger will keep
///		its outputs open, but you can change this behavior by buffering the inputs.  To add a buffered
///		output, use the format [size, Output], this will open and close the output once size has been
///		reached.  For example, a 
/// @example
//global.debug	= new Logger( "debug", FAST_LOGGER_DEFAULT_LENGTH, System, [ 10, new TextFile().open( "log/debug.text", FAST_FILE_NEW ) ] )
//
//debug.write( "Hello World!" );
/// @output Hello World! would be written to the console, but not to debug.txt until 9 more writes are
///		called for, the logger is closed, or the program ends.
/// @wiki Logging-Index Constructors
function Logger( _name ) constructor {
	/// @ignore
	static __buffer__	= function( _size, _output ) : __OutputStream__() constructor {
		static write	= function() {
			var _i = 0; repeat( argument_count ) {
				__Buffer[ __Index++ ]	= argument[ _i++ ];
				
				if ( __Index == __Length ) {
					write_to_output();
					
				}
				
			}
			
		}
		static close	= function() {
			write_to_output();
			
		}
		static buffer	= function() {
			if ( __Index == 0 ) { return ""; }
			
			return __Buffer[ __Index - 1 ];
			
		}
		static write_to_output	= function() {
			__Output.open();
			
			var _i = 0; repeat( __Index ) {
				__Output.write( __Buffer[ _i++ ] );
				
			}
			__Index	= 0;
			__Output.close();
			
			return self;
		
		}
		if ( struct_type( _output, __OutputStream__ ) == false ) { throw new InvalidArgumentType( "BufferedOutput", 0, _output, "__OutputStream__" ); }
		if ( is_numeric( _size ) == false ) { throw new InvalidArgumentType( "BufferedOutput", 1, _size, "integer" ); }
		
		__Output	= _output;
		__Length	= max( 1, floor( _size ));
		__Buffer	= array_create( _size );
		__Index		= 0;
		
		__Output.close();
		
		__Type__.add( BufferedOutput );
		
	}
	/// @param {string}	values...	Strings to write
	/// @desc	Writes the given strings to the log in the order provided.
	/// @returns self
	static write	= function() {
		var _string = __Name + " :: ", _i = 0; repeat( argument_count ) {
			_string	+= string( argument[ _i++ ] );
			
		}
		var _i = -1; repeat( array_length( __Outputs ) ) { ++_i;
			__Outputs[ _i ].write( _string + ( __Outputs[ _i ] == SystemOutput || __Outputs[ _i ].__Output == SystemOutput ? "" : "\n" ));
			
		}
		return self;
		
	}
	/// @desc Calls close() on all of the provided outputs.
	/// @returns self
	static close	= function() {
		var _i = 0; repeat( array_length( __Outputs ) ) {
			__Outputs[ _i++ ].close();
			
		}
		if ( __Logs__ != undefined && ds_list_find_index( __Logs__, self ) > -1 )
			ds_list_delete( __Logs__, ds_list_find_index( __Logs__, self ));
		
		syslog( "Logger :: ", __Name, " closed succesfully." );
		
		return self;
		
	}
	/// @desc Returns the name of this Logger, for debugging purposes.
	/// @returns string
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
	/// @var {array}	An array of the outputs this Logger writes to.
	/// @output	Outputs...
	__Outputs	= array_create( argument_count - 1 );
	
	var _i = 0; repeat( argument_count - 1 ) {
		var _output	= argument[ _i + 1 ];
		
		if ( is_array( _output )) {
			if ( struct_type( _output[ 1 ], __OutputStream__ ) == false )
				throw new InvalidArgumentType( "__init__", _i + 1, _output[ 1 ], "__OutputStream__" );
			__Outputs[ _i ] = new __buffer__( _output[ 0 ], _output[ 1 ] );
			
		} else {
			if ( struct_type( _output[ 1 ], __OutputStream__ ) == false )
				throw new InvalidArgumentType( "__init__", _i + 1, _output[ 1 ], "__OutputStream__" );
			__Outputs[ _i ]	= _output;
			
		}
		++_i;
		
	}
	/// @var {string}	The name of this Logger.
	__Name	= _name;
	
	write( _name + " opened " + date_datetime_string(date_current_datetime()) );
	
	if ( __Logs__ != undefined ) {
		ds_list_add( __Logs__, self );
		
	}
	
}
