/// @func BufferedOutput
/// @param {__OutputStream__}	output	The output stream to buffer to
/// @param {int}				size	The size at which the buffer should write
/// @desc	Buffered output is an output stream that will hold the outputs passed to it until
///		it reaches a certain size, at which the outputs will be written to the provided output
///		stream.  This can be used, for example, to collect a bunch of log entries and write
///		them all at once.  If size is 0, the buffer will not be emptied until write_to_output
///		is called.  If output is not an __OutputStream__ or size is not a number,
///		InvalidArgumentType will be thrown.
/// @example
//var _output	= new BufferedOutput( new TextFile().open( "log.txt", FAST_FILE_OPEN_NEW ), 10 );
//
//var _i = 0; repeat( 18 ) { _output.write( _i++, "\n" ); }
/// @output 0-9 will be written to the text file, and 10-17 will remain in the buffer until more entries are buffered or the output is closed
/// @throws InvalidArgumentType
function BufferedOutput( _output, _size ) : __OutputStream__() constructor {
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
	
	__Type__.add( BufferedOutput );
	
}
