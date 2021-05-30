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
function array_difference( _a ) {
	var _list	= new LinkedList();
	var _result	= new LinkedList();
	var _array;
	
	var _i = 1; repeat( argument_count - 1 ) {
		_array	= argument[ _i++ ];
		
		var _j = -1; repeat( array_length( _array ) ) { ++_j;
			if ( _list.contains( _array[ _j ] )) { continue; }
			
			_list.push( _array[ _j ] );
			
		}
		
	}
	var _i = -1; repeat( array_length( _a ) ) { ++_i;
		if ( _list.contains( _a[ _i ] )) { continue; }
		
		_result.push( _a[ _i ] );
		
	}
	return _result.to_array();
	
}
