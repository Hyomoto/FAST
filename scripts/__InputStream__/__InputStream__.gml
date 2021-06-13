/// @func __InputStream__
/// @desc	An input stream is a generic wrapper for functions that need to read from a source
///		such as a file, buffer, network device, etc... A function that wants to read from an
///		input stream should only have to call read, finished and/or close to complete it's
///		operation. The actual stream may contain many more methods and variables, but they
///		must implement these methods to ensure a consistent point of access for read operations.
/// @wiki Core-Index Abstract
function __InputStream__() : __Struct__() constructor {
	static open		= function() {} // override
	static read		= function() {}	// override
	static finished	= function() {}	// override
	static close	= function() {} // override
	static buffer	= function() { return __Buffer }
	/// @var {string}	The last thing read from the stream
	__Buffer	= undefined;
	
	__Type__.add( __InputStream__ );
	
}
