/// @desc	Returns a random element of the array.
function choose_array( _array ) {
	gml_pragma( "forceinline" );
	return _array[ irandom( array_length( _array ) - 1 ) ];
	
}
