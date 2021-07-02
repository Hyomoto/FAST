/// @func __InputStream__
/// @desc	An input stream is a generic wrapper for functions that need to read from a source
///		such as a file, buffer, network device, etc... A function that wants to read from an
///		input stream should only have to call read, finished and/or close to complete it's
///		operation. The actual stream may contain many more methods and variables, but they
///		must implement these methods to ensure a consistent point of access for read operations.
/// @wiki Core-Index Abstract
function __InputStream__() : __Struct__() constructor {
	/// @desc	Opens the stream
	static open		= function() {} // override
	/// @desc	Reads the next chunk of data from the stream
	static read		= function() {}	// override
	/// @desc	Returns true if the end of the stream has been reached
	static finished	= function() {}	// override
	/// @desc	Closes the stream
	static close	= function() {} // override
	/// @desc	Returns the last chunk of data that was read from the stream
	static buffer	= function() { return __Buffer }
	/// @var {string}	The last thing read from the stream
	__Buffer	= undefined;
	
	__Type__.add( __InputStream__ );
	
}
