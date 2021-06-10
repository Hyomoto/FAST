/// @func array_reverse
/// @param {array}	array	The array to reverse
/// @desc	Returns a new array with the elements of the provided array reversed.  If an array is not
///		provided, InvalidArgumentType will be thrown.
/// @example
//array = array_reverse( [0, 1, 2, 3] );
/// @output [3, 2, 1, 0]
/// @throws InvalidArgumentType
/// @returns array
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
