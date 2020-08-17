/// @func array_difference
/// @param array
/// @param arrays...
/// @desc	returns the unique values in array that do not appear in arrays...
function array_difference( _a ) {
	var _list	= new DsWalkable();
	var _result	= new DsWalkable();
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
