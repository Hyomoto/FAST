/// @func GenericOutput
/// @param {method} *function	if provided, overrides the "write" function
/// @desc	inheritable template, provides a standardized way for dealing with
///		structures that can be written to
/// @wiki Core-Index
function GenericOutput() constructor {
	static write	= function() {};
	static close	= function() {};
	static clear	= function() {};
	static save		= function() {};
	static size		= function() { return 0; }
	
	if ( argument_count > 0 && is_method( argument[ 0 ] ) ) {
		write	= argument[ 0 ];
		
	}
	
}
