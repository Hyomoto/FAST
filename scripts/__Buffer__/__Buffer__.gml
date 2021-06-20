/// @func __Buffer__
/// @desc	The buffer struct provides a framework for building new IO types.  It's important to
///		note that buffers do not inherit from input or output streams, and must be included manually
///		to allow them to be used with input and output functions.  FileText demonstrates the
///		requirements to properly implement a file as both an input and output stream.
/// @wiki Core-Index Abstract
function __Buffer__() : __Struct__() constructor {
	/// @desc	Reads the next chunk of data from the file
	static read		= function() {}					// override
	/// @desc	Writes a chunk of data to the file
	static write	= function() {}					// override
	/// @desc	Opens the file.  This should facilitate re-opening a closed file
	///		if no arguments are provided.
	static open		= function( _filename ) {}		// override
	/// @desc	Closes the file.
	static close	= function() {}					// override
	/// @desc	Returns true if reading the file has reached the end.
	static finished	= function() { return false; }	// override
	/// @desc	Returns the last value read/written to this file
	static buffer	= function() { return __Buffer; }
	/// @desc	Returns true if the file is currently open and available for reading.
	/// @returns bool
	static is_open	= function() { return __Id != undefined; }
	/// @var {int}		The file current opened for reading
	__Id		= undefined;
	/// @var {string}	A name that can be used to identify the buffer source
	__Source	= "<undef>";
	/// @var {string}	The last thing read from\written to the stream
	__Buffer	= undefined;
	
	__Type__.add( __Buffer__ );
	
}
