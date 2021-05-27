/// @func Array
/// @param {mixed}	*values...	the default values to place in the list.
function Array() : IterableList() constructor {
	/// @param {int}	index	The position to read from
	/// @desc	Reads the value at the given index in the list.  If the index is out of range
	///		an ErrorIndex will be thrown.
	/// @returns Mixed
	/// @throws ErrorIndex
	static index	= function( _index ) {
		if ( _index < 0 || _index >= size() ) { throw ErrorIndex; }
		
		__Index	= _index;
		
		return __Content[ _index ];
		
	}
	/// @func	Seeks the next value in the list after the last read position, or EOL if the list has
	///		been fully traversed.  Can use index() to set the next read position.
	/// @returns value or EOL
	static next	= function() {
		if ( size() == 0 || __Index >= size() ) { return EOL; }
		
		return __Content[ __Index++ ];
		
	}
	/// @param {mixed} *values...	One or more values
	/// @desc	Adds the given values to the end of the list
	static push	= function() {
		var _i = 0; repeat( argument_count ) {
			if ( __Dupes == false && contains( argument[ _i ] ) ) { continue; }
			
			array_push( __Content, argument[ _i++ ] );
			
		}
		return self;
		
	}
	/// @param {int}	index	The position to insert at
	/// @param {mixed}	value	The value to be inserted
	/// @desc	Inserts the value at the given index in the list.  If the index is out of range
	///		an ErrorIndex will be thrown.
	/// @throws ErrorIndex
	static insert	= function( _index, _value ) {
		if ( __Dupes == false && contains( _value ) ) { return; }
		
		array_insert( __Content, _index, _value );
		
	}
	/// @param {int}	*index	If provided, the value will be 'popped' from this position
	/// @desc	Removes an entry from the list an returns its value.  If an index is provided it
	///		will remove and return that item, otherwise it will look for the last entry in the list. If
	///		the index is out of range, or the list is empty, an ErrorIndex will be thrown.
	/// @returns Mixed
	/// @throws ErrorIndex
	static pop	= function( _index ) {
		var _value;
		
		if ( _index < 0 || _index >= size() ) { throw ErrorIndex; }
		
		if ( _index == undefined || _index == size() - 1 )
			return array_pop( __Content );
			
		var _value	= __Content[ _index ];
		
		array_delete( __Content, _index, 1 );
		
		return _value;
		
	}
	/// @desc	Clears the list
	static clear	= function() { __Content = []; }
	/// @desc	Returns the size of the list
	/// @returns int
	static size		= function() { return array_length( __Content ); }
	
	__Content	= [];
	__Index		= 0;
	
}
