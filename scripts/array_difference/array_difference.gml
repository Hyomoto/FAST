/// @func array_difference
/// @param {array}	array1
/// @param {array}	array2
/// @desc	Returns a new array containing the difference of both arrays. These are the values that
///		are only in the first array.  If an array is not provided to either argument, InvalidArgumentType
///		will be thrown.
/// @example
//array_difference( [ 10, 20, 30 ], [ 20, 30, 40 ] );
/// @output [ 10 ]
/// @returns array
/// @throws InvalidArgumentType
/// @wiki Core-Index Functions
function array_difference( _arr1, _arr2 ) {
	if ( is_array( _arr1 ) == false ) { throw new InvalidArgumentType( "array_intersection", 0, _arr1, "array" ); }
	if ( is_array( _arr2 ) == false ) { throw new InvalidArgumentType( "array_intersection", 1, _arr2, "array" ); }
	
	var _hash	= {}
	
	var _i = -1; repeat( array_length( _arr1 ) ) { ++_i;
		_hash[$ string( _arr1[ _i ] ) ]	= _arr1[ _i ];
		
	}
	var _i = -1; repeat( array_length( _arr2 ) ) { ++_i;
		var _key	= string( _arr2[ _i ] );
		
		if ( variable_struct_exists( _hash, _key ) == false ) { continue; }
		
		variable_struct_remove( _hash, _key );
		
	}
	var _list	= variable_struct_get_names( _hash );
	var _array	= array_create( array_length( _list ) );
	
	var _i = -1; repeat( array_length ( _list ) ) { ++_i;
		_array[ _i ]	= _hash[$ _list[ _i ] ];
		
	}
	return _array;
	
}
