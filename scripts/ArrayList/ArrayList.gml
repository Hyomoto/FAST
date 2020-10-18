/// @func ArrayList
/// @param array/size	{mixed}	Either the starting array to use, or the size of the array to create.
/// @param default		{mixed}	optional: if provided, will fill the newly created array. Default: `undefined`
/// @desc An array that has the same functionality as a list. The array size is managed internally, and
//		when entries are added or removed, the array will grow to accomidate future values.  It does not
//		deallocate when shrunk.  Thus you should alway use methods to interact with the array to ensure
//		it is not destabilized.  You can change the `aggressiveness` to affect how much space is allocated
//		when the array grows.
/// @example
//var _array = new ArrayList( 10, 0 );
//
//_array.insert( 5, 10 );
//_array.remove( 0 );
//
//show_debug_message( _array );
/// @wiki Core-Index Arrays
function ArrayList( _size ) : Array( _size ) constructor {
	/// @override
	static size	= function() { return length; }
	/// @override
	static resize_Array	= resize;
	/// @override
	static resize	= function( _size, _default ) {
		resize_Array( ceil( _size == 0 ? 10 : _size * aggression ), _default );
		
		length	= _size;
		
	}
	/// @param {int} index The index to insert the value at, must be <= the size of the array
	/// @param {mixed} value The value to insert into the array
	/// @returns `value`
	static insert	= function( _index, _value ) {
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
		
		return _value;
		
	}
	/// @param {int} index The index to remove
	/// @desc Removes an index from the array, shrinking it.
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
	/// @param {mixed} value The value to add to the array
	/// @returns `value`
	/// @desc Adds a value to the end of the array, growing it if necessarry.
	static add	= function( _value ) {
		if ( length == array_length( content ) ) {
			resize_Array( max( length + 1, ceil( length * aggression ) ), undefined );
			
		}
		content[ length ]	= _value;
		
		++length;
		
		return _value;
		
	}
	/// @override
	static toArray	= function() {
		if ( array_length( content ) == length ) {
			return content;
			
		}
		var _array	= array_create( length );
		
		array_copy( _array, 0, content, 0, length );
		
		return _array;
		
	}
	/// @override
	static toString	= function( _divider ) {
		if ( is_string( _divider ) == false ) { _divider = ", " }
		
		var _array	= array_create( length );
		
		array_copy( _array, 0, content, 0, length );
		
		return array_to_string( _array, _divider );
		
	}
	/// @desc A multiplier for many extra elements will be allocated when the array resizes. Default: 1.33
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
