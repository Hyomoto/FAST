/// @func ListBuffer
/// @wiki Core-Index Constructors
function ListBuffer( _list = new LinkedList() ) : __Buffer__() constructor {
	/// @desc	Reads the next chunk of data from the stream
	static read		= function() {
		__Buffer	= __Content.pop(0);
		return __Buffer;
		
	}	// override
	/// @desc	Returns true if the end of the stream has been reached
	static write	= function() {
		var _i = 0; repeat( argument_count ) {
			__Content.push( argument[ _i++ ] );
			
		}
		return self;
		
	}
	/// @desc	Closes the stream
	static finished	= function() {
		return __Content.size() == 0;
		
	}
	/// @desc	Returns the last chunk of data that was read from the stream
	static buffer	= function() { return __Buffer }
	
	/// @var {string}	The last thing read from the stream
	__Buffer	= undefined;
	__Content	= _list;
	
	__Type__.add( ListBuffer );
	__Type__.add( __InputStream__ );
	__Type__.add( __OutputStream__ );
	
}
