/// @func ArrayStrings
/// @param size
/// @param *default
function ArrayStrings( _size, _default ) : Array( _size, _default ) constructor {
	static superSet	= set;
	static set	= function( _index, _value ) {
		if ( !is_string( _value ) ) { _value = string( _value ); }
		return superSet( _index, _value );
		
	}
	static sort	= function( _ascending ) {
		array_sort( content, 0, size() - 1, _ascending,
			function( _value ) { return string_lower( _value ) },
			function( _value, _pivot, _ascending ) {
				var _p, _v;
				
				_value	= string_lower( _value );
				
				var _i = 1; repeat( min( string_length( _pivot ), string_length( _value ) ) ) {
					_p	= string_byte_at( _pivot, _i );
					_v	= string_byte_at( _value, _i++ );
					
					if ( _p == _v ) { continue; }
					
					if ( _ascending ? _p > _v : _p < _v ) {
						return true;
						
					}
					return false;
					
				}
				return ( _ascending ? string_length( _value ) <= string_length( _pivot ) : string_length( _value ) >= string_length( _pivot ) );
				
			}
			
		);
		
	}
	
}
