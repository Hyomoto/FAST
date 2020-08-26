/// @func array_unique
/// @param array
function array_unique( _array ){
	var _list	= new DsLinkedList();
	
	if ( is_struct( _array ) ) {
		try {
			_array	= _array.toArray();
			
		} catch ( _ ) {
			return undefined;
			
		}
		
	}
	var _i = 0; repeat( array_length( _array ) ) {
		if ( _list.find( _array[ _i++ ] ) == undefined ) {
			_list.add( _array[ _i - 1 ] );
			
		}
		
	}
	return _list.toArray();
	
}
