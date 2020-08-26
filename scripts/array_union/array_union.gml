/// @func array_union
/// @param arrays
function array_union(){
	var _list	= new DsLinkedList();
	var _array;
	
	if ( is_struct( _array ) ) {
		try {
			_array	= _array.toArray();
			
		} catch ( _ ) {
			return undefined;
			
		}
		
	}
	var _i = 0; repeat( argument_count ) {
		_array	= argument[ _i++ ];
		
		var _j = 0; repeat( array_length( _array ) ) {
			if ( _list.find( _array[ _j++ ] ) == undefined ) {
				_list.add( _array[ _j - 1 ] );
				
			}
			
		}
		
	}
	return _list.toArray();
	
}
