/// @func Logger
/// @param {string}				name		The name of the logger, will be used to differentiate its output
/// @param {__OutputStream__}	Outputs...	The outputs that this Logger will write to
/// @desc	The Logger makes it easy to write outputs to multiple streams.  A common use case is if you
///		wanted to write something to both the GMS output window as well as a text file.  It has a few
///		additional features such as calling close on all outputs when the game ends to ensure that all
///		logging is caught.
/// @example
//global.debug	= new Logger( "debug", FAST_LOGGER_DEFAULT_LENGTH, System, new FileText( "log/debug.text" ) )
//
//debug.write( "Hello World!" );
/// @wiki Core-Index Logging
function Logger( _name, _output ) constructor {
	static write	= function() {
		var _string = __Name + " :: ", _i = 0; repeat( argument_count ) {
			_string	+= string( argument[ _i++ ] );
			
		}
		var _i = 0; repeat( array_length( __Outputs ) ) {
			__Outputs[ _i++ ].write( _string );
			
		}
		
	}
	/// @desc Calls close() on all of the provided outputs. 
	static close	= function() {
		var _i = 0; repeat( array_length( __Outputs ) ) {
			__Outputs[ _i++ ].close();
			
		}
		LogManager.log.write( "Logger ", __Name, " has been closed." );
		
	}
	/// @desc Returns the name of this Logger, for debugging purposes.
	static toString	= function() {
		return __Name;
		
	}
	/// @desc An array of the outputs this Logger writes to.
	__Outputs	= array_create( argument_count - 1 );
	
	var _i = 1; repeat( argument_count - 1 ) {
		__Outputs[ _i - 1 ]	= argument[ _i ];
		
		__Outputs[ _i - 1 ].close();
		
		++_i;
		
	}
	/// @desc The name of this Logger.
	__Name	= _name;
	
	write( "log opened " + date_datetime_string(date_current_datetime()) + "\n" );
	
	LogManager.add( self );
	
}
