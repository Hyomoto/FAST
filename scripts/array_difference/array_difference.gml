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
	var _list	= new DsLinkedList();
	var _result	= new DsLinkedList();
	var _array;
	
	var _i = 1; repeat( argument_count - 1 ) {
		_array	= argument[ _i ];
		
		if ( is_struct( _array ) ) {
			try {
				_array	= _array.toArray();
				
			} catch ( _ ) {
				return undefined;
				
			}
			
		}
		var _j = 0; repeat( array_length( _array ) ) {
			if ( _list.find( _array[ _j++ ] ) == undefined ) {
				_list.add( _array[ _j - 1 ] );
				
			}
			
		}
		
	}
	var _i = 0; repeat( array_length( _a ) ) {
		if ( _list.find( _a[ _i++ ] ) == undefined ) {
			_result.add( _a[ _i - 1 ] );
			
		}
		
	}
	return _result.toArray();
	
}
