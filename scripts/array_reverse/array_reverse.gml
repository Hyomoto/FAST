/// @func array_reverse
/// @param {array}	array	The array to reverse
/// @desc	Performs an in-place reversal of the contents of the provided array and returns it.  Since
///		the original array is modified, it is not necessary to catch the result.
/// @example
//array = array_reverse( [0, 1, 2, 3] );
/// @output [3, 2, 1, 0]
/// @throws InvalidArgumentType
/// @returns Array
/// @wiki Core-Index Functions
function array_reverse( _array ) {
	if ( is_array( _array ) == false ) { throw new InvalidArgumentType( "array_reverse", 0, _array, "array" ); }
	
	var _s	= array_length( _array );
	var _l	= 0;
	var _r	= _s;
	
	repeat( _s div 2 ) {
		var _h	= _array[ _l ];
		
		_array[@ _l++ ]	= _array[ --_r ];
		_array[@ _r ]	= _h;
		
	}
	return _array;
	
}
