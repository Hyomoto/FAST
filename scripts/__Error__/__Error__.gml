/// @func __Error__
/// @desc	__Error__ is an inheritable type for building Errors.  It provides a convenient point of
///		entry and formatting for GML errors and is used by all errors thrown by FAST.
/// @wiki Core-Index Abstract
function __Error__() : __Struct__() constructor {
	/// @param {struct}	error	A previously generated error
	/// @desc	Can be used to inject one error into another.  This is to allow injecting
	///		GMS-thrown exceptions into FAST's error handling.
	static from_error	= function( _err ) {
		message		= _err.message;
		longMessage	= _err.longMessage;
		stacktrace	= _err.stacktrace;
		script		= _err.script;
		
		return self;
		
	}
	/// @param {struct}	error	A previously generated error
	/// @desc	Can be used to create a generic error from a string.  This is to allow injecting
	///		GMS-thrown one-off errors into FAST's error handling.
	static from_string	= function( _string ) {
		message		= _string;
		return self;
		
	}
	/// @desc	Provides a shortened call to string_formatted
	static f	= string_formatted
	/// @desc	Provides a shortened call to string_concantate
	static c	= function() { var _s = ""; var _i = 0; repeat( argument_count ) { _s += string( argument[ _i++ ] ); }; return _s; }
	/// @desc	Returns the error message formatted for the unhandled exception handler.
	static toString	= function() {
		static __H__	= string_repeat( "~", __Width__ );
		var _msg	= string_break( instanceof( self ) + " :: " + message, __Width__ );
		return "\r\n" + __H__ + "\n" + _msg + "\n\r\n" + __H__ + "\n";
		
	}
	/// @var {int}		Determines where line breaks should be inserted into error messages
	static __Width__	= 92;
	/// @var {string}	A short, descriptive error message that will be displayed to the user
	message		= "";
	/// @var {string}	Unused, a full more descriptive error message
	longMessage	= "";
	/// @var {array}	The stack trace that caused the error
	stacktrace	= [];
	/// @var {string}	The script that caused the error
	script		= "";
	
	__Type__.add( __Error__ );
	__Type__.add( __Self__ );
	
}
