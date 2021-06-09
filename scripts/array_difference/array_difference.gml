/// @func array_difference
/// @param {array}	array
/// @param {array}	arrays...
/// @desc Returns the first array with the entries of subsequent arrays removed.
/// @example
//var _diff = array_difference( [ 10, 20, 30 ], [ 10, 20 ] );
//
//show_debug_message( _diff );
/// @returns array
/// @wiki Core-Index Functions
function array_difference( _arr1, _arr2 ) {
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
