/// @func array_bogosort
/// @param {array}	array	The array to sort
/// @desc	Used to 
function array_bogosort( _arr ) {
	static __in_order__	= function( _arr ) {
		var _i = 0; repeat( array_length( _arr ) - 1 ) {
			if ( _arr[ _i ] > _arr[ _i + 1 ] )
				return false;
			++_i;
		}
		return true;
		
	}
	// for optimization
	if ( array_length( _arr ) < 2 )
		return;
	
	var _i = 0;
	
	while ( __in_order__( _arr ) == false ) {
		array_shuffle( _arr );
		++_i;
	}
	return _i;
	
}
