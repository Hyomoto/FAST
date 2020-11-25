/// @func Array
/// @param array/size	{mixed}	Either the starting array to use, or the size of the array to create.
/// @param default		{mixed}	optional: if provided, will fill the newly created array. Default: `undefined`
/// @desc A wrapper for primitive arrays and an interface for building more complex ones.
/// @example
// array = new Array( 10, 0 );
// 
// array = new Array( [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] );
/// @wiki Core-Index Arrays
function Array( _size ) constructor {
	/// @desc Used as a template interface for constructors that inherit Array
	static sort	= function() {}
	/// @desc Returns the number of indexes in the array.
	/// @return int
	static size	= function() { return array_length( content ); }
	/// @param {int} a The first position
	/// @param {int} b The second position
	/// @desc Swaps the position of two values in the array.
	static swap	= function( _indexA, _indexB ) {
		if ( _indexA < 0 && _indexB >= size() ) { return; }
		if ( _indexA < 0 && _indexB >= size() ) { return; }
		
		var _hold	= content[ _indexA ];
		
		content[ _indexA ]	= content[ _indexB ];
		content[ _indexB ]	= _hold;
		
	}
	/// @desc Returns an array containing all of the unique elements in the array.
	static unique	= function() {
		return array_unique( toArray() );
		
	}
	/// @returns array
	/// @param {array} target The array to combine
	/// @desc Returns an array containing all the elements from both arrays..
	static concat	= function( _target ) {
		return array_concat( toArray(), _target );
		
	}
	/// @returns array
	/// @param {array} target The array to subtract
	/// @desc Returns an array containing every element not in the provided array.
	static difference	= function( _target ) {
		return array_difference( toArray(), _target );
		
	}
	/// @returns array
	/// @param {array} target The array to union with
	/// @desc Returns an array containing all of the unique elements between both arrays.
	static union	= function ( _target ) {
		return array_union( toArray(), _target );
		
	}
	/// @returns intp
	/// @param {mixed} value The value to search for
	/// @desc Return the first index which contains `value`, or -1 if it wasn't found.
	static contains	= function( _value ) {
		var _i = 0; repeat( size() ) {
			if ( content[ _i++ ] == _value ) {
				return _i - 1;
				
			}
			
		};
		return -1;
	}
	/// @param {int} index The index to set
	/// @param {mixed} value The value to assign
	/// @returns `value`
	/// @desc Used to set an element in the array.
	static set	= function( _index, _value ) {
		if ( _index >= 0 && _index < size() ) {
			content[ _index ]	= _value;
			
		}
		return _value;
		
	}
	/// @param {int} index The index to retrieve
	/// @returns Mixed
	/// @desc Used to get an element from the array.
	static get	= function( _index ) {
		if ( _index == undefined ) { return content; }
		if ( _index >= 0 && _index < size() ) {
			return content[ _index ];
			
		}
		return undefined;
		
	}
	/// @param {int} size The new size for the array
	/// @param {mixed} default optional: the value the array any new elements will be populated with. Default is `undefined`
	static resize	= function( _size, _default ) {
		var _array	= array_create( _size, _default );
		
		array_copy( _array, 0, content, 0, min( array_length( _array ), array_length( content ) ) );
		
		content	= _array;
		
	}
	static toArray	= function() {
		return content;
		
	}
	/// @desc Returns a comma-separated string(by default) of all values in the array.
	/// @param {string} divider optional: The divider between each element. Default: ", "
	static toString	= function( _divider ) {
		if ( is_string( _divider ) == false ) { _divider = ", " }
		
		return array_to_string( content, _divider );
		
	}
	static is		= function( _data_type ) {
		return _data_type == Array;
		
	}
	/// @param {array} content The internal array.
	content	= 0;
	
	if ( is_array( _size ) ) {
		content	= _size;
		
	} else {
		var _default	= ( argument_count > 1 ? argument[ 1 ] : undefined );
		
		content	= array_create( _size, _default );
		
	}
	
}
