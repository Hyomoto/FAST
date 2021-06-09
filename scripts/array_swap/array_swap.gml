/// @func array_swap
/// @param {array}	array	The array to reverse
/// @param {int}	a		The first element to swap
/// @param {int}	b		The second element to swap
/// @desc	Performs an in-place swap of the contents of the provided array and returns it.  Since
///		the original array is modified, it is not necessary to catch the result.
/// @example
//array = array_swap( ["a", "b", "c"], 0, 1 );
/// @output ["b", "a", "c"]
/// @throws InvalidArgumentType
/// @returns Array
/// @wiki Core-Index Functions
function array_swap( _array, _a, _b ) {
	if ( is_array( _array ) == false ) { throw new InvalidArgumentType( "array_reverse", 0, _array, "array" ); }
	
	var _h	= _array[ _a ];
	
	_array[@ _a ]	= _array[ _b ];
	_array[@ _b ]	= _h;
	
	return _array;
	
}
