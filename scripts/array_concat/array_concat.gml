/// @func array_concat
/// @param arrays...
function array_concat(){
	var _size	= 0;
	
	if ( is_struct( _array ) ) {
		try {
			_array	= _array.toArray();
			
		} catch ( _ ) {
			return undefined;
			
		}
		
	}
	var _i = 0; repeat( argument_count ) {
		_size	+= array_length( argument[ _i++ ] );
		
	}
	var _array	= array_create( _size );
	var _last	= 0;
	
	var _i = 0; repeat( argument_count ) {
		array_copy( _array, _last, argument[ _i ], 0, array_length( argument[ _i ] ) );
		
		_last	= array_length( argument[ _i ] );
		
		++_i;
		
	}
	return _array;
	
}
