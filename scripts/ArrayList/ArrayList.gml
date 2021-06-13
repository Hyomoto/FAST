/// @func ArrayList
/// @desc	A wrapper for the built-in GML array data structure.
function ArrayList() : __IterableList__() constructor {
	/// @param {int}	index	The position to read from
	/// @desc	Reads the value at the given index in the list.  If the index is out of range
	///		an IndexOutOfBounds will be thrown.
	/// @returns Mixed
	/// @throws IndexOutOfBounds
	static index	= function( _index ) {
		if ( _index < 0 || _index >= size() ) { throw new IndexOutOfBounds( "index", _index, size() ); }
		
		__Index	= _index;
		
		return __Content[ _index ];
		
	}
	/// @func	Seeks the next value in the list after the last read position, or EOL if the list has
	///		been fully traversed.  Can use index() to set the next read position.
	/// @returns mixed or EOL
	static next	= function() {
		if ( size() == 0 || __Index >= size() ) { return EOL; }
		
		return __Content[ __Index++ ];
		
	}
	/// @func	Seeks the previous value in the list before the last read position, or EOL if the front
	///		of the list has been reached.  Can use index() to set the next read position.
	/// @returns mixed or EOL
	static previous	= function() {
		if ( size() == 0 || __Index == 0 ) { return EOL; }
		
		return __Content[ --__Index ];
		
	}
	/// @param {mixed} *values...	One or more values
	/// @desc	Adds the given values to the end of the list
	/// @returns self
	static push	= function() {
		var _f = __OrderedBy == undefined ? function( _v ) { array_push( __Content, _v ) } : function( _v ) { array_insert( __Content, __OrderedBy( _v ), _v ); }
		var _i = 0;
		
		if ( size() == 0 ) { array_push( __Content, argument[ _i++ ] ); }
		
		repeat( argument_count - _i ) {
			if ( __Dupes == false && contains( argument[ _i ] ) ) { continue; }
			
			_f( argument[ _i++ ] );
			
		}
		return self;
		
	}
	/// @param {int}	index	The position to insert at
	/// @param {mixed}	value	The value to be inserted
	/// @desc	Inserts the value at the given index in the list.  If the index is out of range
	///		an IndexOutOfBounds will be thrown.
	/// @throws IndexOutOfBounds
	static insert	= function( _index, _value ) {
		if ( __Dupes == false && contains( _value ) ) { return; }
		if ( _index < 0 || _index > size() ) { throw new IndexOutOfBounds( "insert", _index, size() ); }
		
		array_insert( __Content, _index, _value );
		
	}
	/// @param {int}	index	The position to write to
	/// @param {Mixed}	value	The value to write
	/// @desc	Writes the value to the given index in the list.  If the index is out of range
	///		an IndexOutOfBounds will be thrown.
	/// @throws IndexOutOfBounds
	static replace	= function( _index, _value ) {
		if ( _index < 0 || _index >= size() ) { throw new IndexOutOfBounds( "index", _index, size() ); }
		
		__Content[ _index ]	= _value;
		
	}
	/// @param {int}	*index	If provided, the value will be 'popped' from this position
	/// @desc	Removes an entry from the list and returns its value.  If an index is provided it
	///		will remove and return that item, otherwise it will look for the last entry in the list. If
	///		the index is out of range, or the list is empty, an IndexOutOfBounds will be thrown.
	/// @returns Mixed
	/// @throws IndexOutOfBounds
	static pop	= function( _index ) {
		var _value;
		
		if ( _index < 0 || _index >= size() ) { throw new IndexOutOfBounds( "pop", _index, size() ); }
		
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
	static from_array	= function( _a ) {
		if ( is_array( _a ) == false ) { throw new InvalidArgumentType( "from_array", 0, _a, "array" ); }
		
		__Content	= _a;
		
		return self;
		
	}
	__Content	= [];
	__Index		= 0;
	__Type__.add( ArrayList );
	
}
