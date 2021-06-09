/// @func array_shuffle
/// @param {array}	array	The array to shuffle
/// @param {array}	*rand	A (#Randomizer) to use
/// @desc	An implementation of the Fisher-Yates shuffle. Performs an in-place, single-pass
///		randomization of the provided array.  If an array is not provided, InvalidArgumentType will
///		be thrown.  If rand is defined, that will be used instead of the default GMS randomization.
/// @throws InvalidArgumentType
function array_shuffle( _array ) {
	if ( is_array( _array ) == false ) { throw new InvalidArgumentType( "array_shuffle", 0, _array, "array" ); }
	
	var _rand	= argument_count > 1 && struct_type( _rand, Randomizer ) ? method( argument[ 1 ], argument[ 1 ].next_range ) : irandom_range;
	
	var _size	= array_length( _array );
	
	var _i = _size; repeat( _size - 1 ) { -- _i;
		var _j = _rand( 0, _i + 1 );
		
		var _h	= _array[ _i ];
		
		_array[@ _i ]	= _array[ _j ];
		_array[@ _j ]	= _h;
		
    }
	
}
