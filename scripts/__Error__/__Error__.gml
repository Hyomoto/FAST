/// @func __Error__
/// @desc	__Error__ is an inheritable type for building Errors.  It provides a convenient point of
///		entry and formatting for GML errors and is used by all errors thrown by FAST.
/// @wiki Core-Index Abstract
function __Error__() : __Struct__() constructor {
	static from_error	= function( _err ) {
		message		= _err.message;
		longMessage	= _err.longMessage;
		stacktrace	= _err.stacktrace;
		script		= _err.script;
		
		return self;
		
	}
	static conc	= function() { var _s = ""; var _i = 0; repeat( argument_count ) { _s += string( argument[ _i++ ] ); }; return _s; }
	static toString	= function() {
		var _msg	= string_break( instanceof( self ) + " :: " + message, __Width__ );
		
		return "\n\n\n" + _msg + "\n\n";
		
	}
	static __Width__	= 92;
	
	message		= "";
	longMessage	= "";
	stacktrace	= [];
	script		= "";
	
	__Type__.add( __Error__ );
	__Type__.add( __Self__ );
	
}
