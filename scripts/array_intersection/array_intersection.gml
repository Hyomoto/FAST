/// @func array_intersection
/// @param {array}	array1
/// @param {array}	array2
/// @desc	Returns a new array containing the intersection of both arrays. These are the values that
///		are shared by both arrays, except duplicates.  If an array is not provided to either argument,
///		InvalidArgumentType will be thrown.
/// @example
//array_intersection( [ 10, 20, 30 ], [ 20, 30, 40 ] );
/// @output [ 20,30 ]
/// @returns array
/// @throws InvalidArgumentType
/// @wiki Core-Index Functions
function array_intersection( _arr1, _arr2 ) {
	//if ( array_length( _arr1 ) > array_length( _arr2 ) ) {
	//	var _h	= _arr1;
		
	//	_arr1	= _arr2;
	//	_arr2	= _h;
		
	//}
	if ( is_array( _arr1 ) == false ) { throw new InvalidArgumentType( "array_intersection", 0, _arr1, "array" ); }
	if ( is_array( _arr2 ) == false ) { throw new InvalidArgumentType( "array_intersection", 1, _arr2, "array" ); }
	
	var _hash	= {}
	var _output	= {}
	
	var _i = -1; repeat( array_length( _arr1 ) ) { ++_i;
		_hash[$ string( _arr1[ _i ] ) ]	= _arr1[ _i ];
		
	}
	var _i = -1; repeat( array_length( _arr2 ) ) { ++_i;
		var _key	= string( _arr2[ _i ] );
		
		if ( _hash[$ _key ] == undefined ) { continue; }
		
		_output[$ _key ]	= _arr2[ _i ];
		variable_struct_remove( _hash, _key );
		
	}
	var _list	= variable_struct_get_names( _output );
	var _array	= array_create( array_length( _list ) );
	
	var _i = -1; repeat( array_length ( _list ) ) { ++_i;
		_array[ _i ]	= _output[$ _list[ _i ] ];
		
	}
	return _array;
	
}
