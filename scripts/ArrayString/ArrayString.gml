/// @func ArrayString
/// @param array/size	{mixed}	Either the starting array to use, or the size of the array to create.
/// @param default		{mixed}	optional: if provided, will fill the newly created array. Default: `undefined`
/// @desc An Array wrapper specifically for holding and sorting strings.
/// @example
//var _array = new ArrayString( "Hello", "Amanda", "Cars", "Banana" );
//
//_array.sort( true );
//
//show_debug_message( _array );
/// @wiki Core-Index Arrays
function ArrayString( _size ) : Array( _size ) constructor {
	/// @override
	static set_Array = set;
	/// @override
	static set	= function( _index, _value ) {
		return set_Array( _index, string( _value ) );
		
	}
	/// @param {bool} ascending If true, will sort from A-Z, otherwise Z-A
	/// @desc Sorts the array in alphabetical order.
	static sort	= function( _ascending ) {
		array_quicksort( content, 0, size() - 1, _ascending,
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
