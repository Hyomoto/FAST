/// @func ArrayNumber
/// @param array/size	{mixed}	Either the starting array to use, or the size of the array to create.
/// @param default		{mixed}	optional: if provided, will fill the newly created array. Default: `undefined`
/// @desc	An array that specializes in dealing with numbers.
//_array = new Array( [ 10, 20, 30 ] );
//
//show_debug_message( _array.sum() );
/// @wiki Core-Index Arrays
function ArrayNumber( _size ) : Array( _size ) constructor {
	static set_Array	= set;
	static set	= function( _index, _value ) {
		set_Array( _index, string_to_real( _value ) );
		
	}
	static sum	= function() {
		var _total = 0, _i = 0; repeat( array_length( content ) ) {
			_total	+= content[ _i ];
			
		}
		return _total;
		
	}
	static lowest	= function() {
		var _lowest	= undefined;
		
		var _i = 0; repeat ( size() ) {
			if ( _lowest == undefined || content[ _i ] < _lowest ) {
				_lowest	= content[ _i ];
				
			}
			++_i;
			
		}
		return _lowest;
		
	}
	static highest	= function() {
		var _highest	= undefined;
		
		var _i = 0; repeat ( size() ) {
			if ( _highest == undefined || content[ _i ] > _highest ) {
				_highest	= content[ _i ];
				
			}
			++_i;
			
		}
		return _highest;
		
	}
	static average	= function() {
		return sum() / size();
		
	}
	static sort	= function( _ascending ) {
		array_quicksort( content, 0, size() - 1, _ascending );
		
	}
	
}
