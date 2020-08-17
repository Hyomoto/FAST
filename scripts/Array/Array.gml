/// @func Array
/// @param size
/// @param *default
function Array( _size, _default ) constructor {
	// interfaces
	static sort	= function() {}
	// functions
	static size	= function() { return array_length( content ); }
	static swap	= function( _indexA, _indexB ) {
		if ( _indexA < 0 && _indexB >= array_length( content ) ) { return; }
		if ( _indexA < 0 && _indexB >= array_length( content ) ) { return; }
		
		var _hold	= content[ _indexA ];
		
		content[ _indexA ]	= content[ _indexB ];
		content[ _indexB ]	= _hold;
		
	}
	static unique	= function() {
		return array_unique( content );
		
	}
	static concat	= function( _target ) {
		return array_concat( content, _target );
		
	}
	static difference	= function( _target ) {
		return array_difference( content, _target );
		
	}
	static union	= function ( _target ) {
		return array_union( content, _target );
		
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
		if ( _index >= 0 && _index < size() ) {
			content[ _index ]	= _value;
			
		}
		return _value;
		
	}
	static get	= function( _index ) {
		if ( _index == undefined ) { return content; }
		if ( _index >= 0 && _index < size() ) {
			return content[ _index ];
			
		}
		return undefined;
		
	}
	static forEach	= function( _func ) {
		var _i = 0; repeat( size() ) {
			set( _i, _func( content[ _i ] ) );
			
		}
		
	}
	static toArray	= function() {
		return content;
		
	}
	static toString	= function( _divider ) {
		return array_to_string( content, _divider );
		
	}
	if ( is_array( _size ) ) {
		content	= _size;
		
	} else {
		content	= array_create( _size, _default );
		
	}
	
}
