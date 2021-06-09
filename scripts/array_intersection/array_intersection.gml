/// @func array_intersection
/// @param {array}	arrays...
/// @desc Returns the unique entries of the given arrays combined into one.
/// @example
//var _union = array_intersection( [ 10, 20 ], [ 10, 20, 30 ] );
//
//show_debug_message( _union );
/// @returns array
/// @wiki Core-Index Functions
function array_intersection( _arr1, _arr2 ) {
	if ( array_length( _arr1 ) > array_length( _arr2 ) ) {
		var _h	= _arr1;
		
		_arr1	= _arr2;
		_arr2	= _h;
		
	}
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
