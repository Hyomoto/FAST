/// @func Array
/// @param size
/// @param *default
function Array( _size, _default ) constructor {
	static size	= function() { return array_length( content ); }
	static swap	= function( _indexA, _indexB ) {
		if ( _indexA < 0 && _indexB >= array_length( content ) ) { return; }
		if ( _indexA < 0 && _indexB >= array_length( content ) ) { return; }
		
		var _hold	= content[ _indexA ];
		
		content[ _indexA ]	= content[ _indexB ];
		content[ _indexB ]	= _hold;
		
	}
	static contains	= function( _value ) {
		var _i = 0; repeat( array_length( content ) ) {
			if ( content[ _i ] == _value ) {
				return _i;
				
			}
			
		};
		return -1;
	}
	static set	= function( _index, _value ) {
		if ( _index >= 0 && _index < array_length( content ) ) {
			content[ _index ]	= _value;
			
		}
		return _value;
		
	}
	static get	= function( _index ) {
		if ( _index >= 0 && _index < array_length( content ) ) {
			return content[ _index ];
			
		}
		return undefined;
		
	}
	static forEach	= function( _func ) {
		var _i = 0; repeat( size() ) {
			set( _i, _func( content[ _i ] ) );
			
		}
		
	}
	static toString	= function() {
		return string( content );
		
	}
	if ( is_array( _size ) ) {
		content	= _size;
		
	} else {
		content	= array_create( _size, _default );
		
	}
	
}
