/// @func array_simple_search
/// @param {Array}	array	The array to search
/// @param {Mixed}	value	The value to find
/// @param {method}	[*func]	optional: If provided, will be used for sake of comparison
/// @desc	Searches for the first occurance of value in the array, and returns that position.  You can
///		override the function used for comparison by specifying func. If the value is not found,
///		ValueNotFound will be returned.  If an array is not provided to search, or a method is not
///		provided for func InvalidArgumentType will be thrown.
/// @throws InvalidArgumentType
/// @returns Number or ValueNotFound
/// @example
//array_simple_search([ 10, 20, 30, 40, 50 ], 30 );
/// @output 2
/// @wiki Core-Index Functions
function array_simple_search( _array, _value, _f ) {
	if ( is_array( _array ) == false ) { throw new InvalidArgumentType( "array_simple_search", 0, _array, "array" ); }
	
	if ( _f == undefined ) { _f = function( _a, _b ) { return _a == _b; }}
	
	if ( is_method( _f ) == false ) { throw new InvalidArgumentType( "array_simple_search", 2, _f, "method" ); }
	
	var _i = 0; repeat( array_length( _array ) ) {
		if ( _f( _array[ _i++ ], _value )) { return _i - 1; }
		
	}
	return new ValueNotFound( "array_simple_search", _value, _i );
	
}
