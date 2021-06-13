/// @func __OutputStream__
/// @desc	An output stream provides a generic wrapper for functions that can write to files,
///		the network, the output console, etc... A function that wants to write to an output
///		stream should only have to call write and/or close to complete its operation. The
///		actual stream may contain main more methods or values as needed, but they must
///		implement these two methods to ensure a consistent point of access for write operations.
/// @wiki Core-Index Abstract
function __OutputStream__() : __Struct__() constructor {
	static open		= function() {} // override
	static write	= function() {}	// override
	static close	= function() {}	// override
	static buffer	= function() { return __Buffer }
	/// @var {string}	The last thing written to the stream
	__Buffer	= undefined;
	
	__Type__.add( __OutputStream__ );
	
}
