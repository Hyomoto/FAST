/// @func Array
/// @param size
/// @param *default
/// @desc returns an array-as-a-struct
/* methods
sort()				- used as a template interface for constructors that inherit Array
size()				- returns the size of the array
swap( a, b )		- swaps index a and b in the array
unique()			- returns an array containing all unique values
concat( array )		- returns the array combined with the provided array
union( array )		- returns an array containing all unique values from the array combined with the provided array
difference( array )	- returns the array minus the values contained in the provided array
contains( value )	- searches the array and returns the index the value was found, or -1
set( index, value )	- sets the array index to the given value
get( *index )		- returns the value at the given index, or the array if no index is provided
forEach( function )	- performs the given function on each indice in the array
toArray()			- returns the array
toString()			- returns the array as a string
*/
function Array( _size ) constructor {
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
		var _default	= ( argument_count > 1 ? argument[ 1 ] : undefined );
		
		content	= array_create( _size, _default );
		
	}
	
}
