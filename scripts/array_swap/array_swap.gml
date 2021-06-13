/// @func array_swap
/// @param {array}	array	The array to reverse
/// @param {int}	a		The first element to swap
/// @param {int}	b		The second element to swap
/// @desc	Performs an in-place swap of the contents of the provided array.  If an array is not provided,
///		or the indexes are not integers, InvalidArgumentType will be thrown.  If the indexes are outside
///		the bounds of the array, IndexOutOfBounds will be thrown.
/// @example
//array_swap( ["a", "b", "c"], 0, 1 );
/// @output ["b", "a", "c"]
/// @throws InvalidArgumentType, IndexOutOfBounds
/// @returns array
/// @wiki Core-Index Functions
function array_swap( _array, _a, _b ) {
	if ( is_array( _array ) == false ) { throw new InvalidArgumentType( "array_swap", 0, _array, "array" ); }
	if ( is_numeric( _a ) == false ) { throw new InvalidArgumentType( "array_swap", 1, _a, "integer" ); }
	if ( is_numeric( _b ) == false ) { throw new InvalidArgumentType( "array_swap", 2, _b, "integer" ); }
	
	if ( min( _a, _b ) < 0 ) { throw new IndexOutOfBounds( "array_swap", min( _a, _b ), "integer" ); }
	if ( max( _a, _b ) >= array_length( _array ) ) { throw new IndexOutOfBounds( "array_swap", max( _a, _b ), "integer" ); }
	
	var _h	= _array[ _a ];
	
	_array[@ _a ]	= _array[ _b ];
	_array[@ _b ]	= _h;
	
	return _array;
	
}
