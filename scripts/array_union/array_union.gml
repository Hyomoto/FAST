/// @func array_union
/// @param {array}	arrays...
/// @desc Returns the unique entries of the given arrays combined into one.
/// @example
//var _union = array_union( [ 10, 20 ], [ 10, 20, 30 ] );
//
//show_debug_message( _union );
/// @returns array
/// @wiki Core-Index Functions
function array_union(){
	var _list	= new LinkedList();
	var _array;
	
	var _i = 0; repeat( argument_count ) {
		_array	= argument[ _i++ ];
		
		var _j = -1; repeat( array_length( _array ) ) { ++_j;
			if ( _list.contains( _array[ _j ] )) { continue; }
			_list.push( _array[ _j ] );
			
		}
		
	}
	return _list.to_array();
	
}
