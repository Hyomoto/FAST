/// @func ArrayNumbers
/// @param size
/// @param *default
function ArrayNumbers( _size ) : Array( _size ) constructor {
	static superSet	= set;
	static set	= function( _index, _value ) {
		if ( !is_real( _value ) ) { _value = 0; }
		if ( _index >= 0 && _index < array_length( content ) ) {
			content[ _index ]	= _value;
			
		}
		return _value;
		
	}
	static sum	= function() {
		var _total = 0, _i = 0; repeat( array_length( content ) ) {
			_total	+= content[ _i ];
			
		}
		return _total;
		
	}
	static average	= function() {
		return sum() / array_length( content );
		
	}
	static superSet	= set;
	static set	= function( _index, _value ) {
		if ( !is_real( _value ) ) { _value = 0; }
		if ( _index >= 0 && _index < array_length( content ) ) {
			content[ _index ]	= _value;
			
		}
		return _value;
		
	}
	static sort	= function( _ascending ) {
		array_sort( content, 0, size() - 1, _ascending );
		
	}
	
}
