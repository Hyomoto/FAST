/// @func array_union
/// @param {array}	array1
/// @param {array}	array2
/// @desc	Returns a union of the provided arrays. This will produce a new array that contains all of
///		the values in every list, except duplicates.  If a provided argument is not an array,
///		InvalidArgumentType will be thrown.
/// @example
//array_union( [ 10, 20, 30 ], [ 20, 30, 40 ] );
/// @output [ 10,20,30,40 ]
/// @returns array
/// @throws InvalidArgumentType
/// @wiki Core-Index Functions
function array_union( _arr1, _arr2 ) {
	var _hash	= {}
	
	var _i = 0; repeat( argument_count ) {
		var _array	= argument[ _i++ ];
		
		if ( is_array( _array ) == false ) { throw new InvalidArgumentType( "array_union", _i - 1, _array, "array" ); }
		
		var _j = -1; repeat( array_length( _array ) ) { ++_j;
			_hash[$ string( _array[ _j ] ) ]	= _array[ _j ];
			
		}
		
	}
	var _list	= variable_struct_get_names( _hash );
	var _array	= array_create( array_length( _list ) );
	
	var _i = -1; repeat( array_length ( _list ) ) { ++_i;
		_array[ _i ]	= _hash[$ _list[ _i ] ];
		
	}
	return _array;
	
}
