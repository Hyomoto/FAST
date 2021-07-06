/// @func array_shuffle
/// @param {array}		array	The array to shuffle
/// @param {__Randomizer__}	*rand	If specified, will be used instead of GMS' functions
/// @desc	Returns a new array with the contents of the original array shuffled.  Utilizes a 
///		Fisher-Yates shuffle.  If an array is not provided, InvalidArgumentType will be thrown.  If
///		rand is defined, that will be used instead of the default GMS randomization.  If rand is
///		defined but is not of type __Randomizer__, InvalidArgumentType will be thrown.
/// @throws InvalidArgumentType
/// @returns array
/// @wiki Core-Index Functions
function array_shuffle( _array ) {
	if ( is_array( _array ) == false ) { throw new InvalidArgumentType( "array_shuffle", 0, _array, "array" ); }
	
	var _rand	= irandom;
	
	if ( argument_count > 1 ) {
		if ( struct_type( argument[ 1 ], __Randomizer__ ) == false ) { throw new InvalidArgumentType( "array_shuffle", 1, argument[1], "__Randomizer__" ); }
		
		_rand	= method( argument[ 1 ], argument[ 1 ].next_int );
		
	}
	var _size	= array_length( _array );
	//var _new	= array_create( _size );
	
	var _i = _size; repeat( _size - 1 ) { --_i;
		var _j	= _rand( _i );
		var _h	= _array[ _i ];
		
		_array[@ _i ]	= _array[ _j ];
		_array[@ _j ]	= _h;
		
    }
	
}
