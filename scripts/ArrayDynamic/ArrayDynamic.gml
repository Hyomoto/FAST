/// @func ArrayDynamic
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

toArray()			- returns the array
toString()			- returns the array as a string
*/
function ArrayDynamic( _size ) : Array( _size ) constructor {
	// functions
	static size	= function() { return length; }
	
	static resize_Array	= resize;
	static resize	= function( _size, _default ) {
		resize_Array( ceil( _size == 0 ? 10 : _size * aggression ), _default );
		
		length	= _size;
		
	}
	static insert	= function( _value, _index ) {
		if ( _index < 0 || _index > size() ) { return; }
		
		if ( length == array_length( content ) ) {
			resize_Array( ceil( length * aggression ), undefined );
			
		}
		var _array	= array_create( array_length( content ), undefined );
		
		if ( _index > 0 ) {
			array_copy( _array, 0, content, 0, _index );
			
		}
		array_copy( _array, _index + 1, content, _index, length - _index );
		
		_array[ _index ]	= _value;
		
		content	= _array;
		
		++length;
		
	}
	static remove	= function( _index ) {
		if ( _index < 0 || _index >= size() ) { return; }
		
		var _array	= array_create( array_length( content ), undefined );
		
		if ( _index > 0 ) {
			array_copy( _array, 0, content, 0, _index );
			
		}
		if ( _index < length - 1 ) {
			array_copy( _array, _index, content, _index + 1, length - _index );
			
		}
		content	= _array;
		
		--length;
		
	}
	static append	= function( _value ) {
		if ( length == array_length( content ) ) {
			resize_Array( ceil( length * aggression ), undefined );
			
		}
		content[ length ]	= _value;
		
		++length;
		
	}
	static toArray	= function() {
		if ( array_length( content ) == length ) {
			return content;
			
		}
		var _array	= array_create( length );
		
		array_copy( _array, 0, content, 0, length );
		
		return _array;
		
	}
	static toString	= function( _divider ) {
		if ( is_string( _divider ) == false ) { _divider = ", " }
		
		var _array	= array_create( length );
		
		array_copy( _array, 0, content, 0, length );
		
		return array_to_string( _array, _divider );
		
	}
	aggression	= 1.33;
	
	if ( is_array( _size ) ) {
		length	= ceil( array_length( _size ) );
		content	= array_create( ceil( length * aggression ), undefined);
		
		array_copy( content, 0, _size, 0, length );
		
	} else {
		var _default	= ( argument_count > 1 ? argument[ 1 ] : undefined );
		
		length	= ceil( _size == 0 ? 10 : _size * aggression );
		content	= array_create( length, _default );
		
	}
	
}
