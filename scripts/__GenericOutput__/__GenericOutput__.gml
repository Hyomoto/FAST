/// @func __GenericOutput__
/// @param {func}	function	If provided, overrides the "write" function.
/// @desc	inheritable template, provides a standardized way for dealing with
///		structures that can be written to
/// @wiki Core-Index
function __GenericOutput__() : __Struct__() constructor {
	/// @desc	Used to write to an output.
	static write	= function() {};
	/// @desc	Used to close an output, this should save and clean up any internal structures.
	static close	= function() {};
	/// @desc	Used to to save the output to disk, or other location.
	static save		= function() {};
	
	if ( argument_count > 0 && is_method( argument[ 0 ] ) ) {
		write	= argument[ 0 ];
		
	}
	__Type__.add( __GenericOutput__ );
	
}
