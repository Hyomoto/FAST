/// @func error_type
/// @param	{__Error__}	error	The error to check
///	@desc	Returns the type of the provided error.  If the value is _not_ an error, undefined will
///		be returned.
/// @example
//var _index = array_binary_search( [ 1, 2, 3 ], "dog" );
//
//if ( error_type( _index ) == ValueNotFound ) { _index = -1; }
/// @returns undefined or __Error__
/// @wiki Core-Index Functions
function error_type( _ex ) {
	if ( struct_type( _ex, __Error__ ) == false ) { return undefined; }
	
	return _ex.__Self__;
	
}
