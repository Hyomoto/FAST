/// @func __File__
/// @desc	The file struct provides a framework for building new file types.  It's important to
///		note that files do not inherit from input or output streams, and must be included manually
///		to allow them to be used with input and output functions.  FileText demonstrates the
///		requirements to properly implement a file as both an input and output stream.
/// @wiki Core-Index Abstract
function __File__() : __Struct__() constructor {
	static read		= function() {}					// override
	static write	= function() {}					// override
	static open		= function( _filename ) {}		// override
	static close	= function() {}					// override
	static finished	= function() { return false; }	// override
	/// @desc	Returns the last value read/written to this file
	static buffer	= function() { return __Buffer; }
	/// @desc	Returns true if the file is currently open and available for reading.
	/// @returns bool
	static is_open	= function() { return __Id != undefined; }
	/// @var {int}		The file current opened for reading
	__Id		= undefined;
	/// @var {string}	The name of the currently open files
	__Filename	= undefined;
	/// @var {string}	The last thing read from\written to the stream
	__Buffer	= undefined;
	
	__Type__.add( __File__ );
	
}
#macro FAST_FILE_OPEN_READ	0
#macro FAST_FILE_OPEN_WRITE	1
#macro FAST_FILE_OPEN_NEW	2
