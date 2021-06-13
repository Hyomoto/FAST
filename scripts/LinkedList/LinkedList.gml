/// @func LinkedList
/// @desc	A GML-based linked list data structure.
function LinkedList() : __IterableList__() constructor {
	/// @param {int}	index	The position to read from
	/// @desc	Reads the value at the given index in the list.  If the index is out of range
	///		an IndexOutOfBounds will be thrown.
	/// @returns Mixed
	/// @throws IndexOutOfBounds
	static index	= function( _index ) {
		if ( _index < 0 || _index >= size() ) { throw new IndexOutOfBounds( "index", _index, size() ); }
		var _i = ( __Index != undefined && _index >= __Index.i ? __Index.i : 0 ), _l = ( __Index != undefined && _i >= __Index.i ? __Index.p : __First ); repeat( size() ) {
			if ( _i++ == _index ) { __Index = { p: _l, i: _index }; return _l.value; }
			_l	= _l.next;
			
		}
		
	}
	/// @func	Seeks the next value in the list after the last read position, or EOL if the list has
	///		been fully traversed.  Can use index() to set the next read position.
	/// @returns mixed or EOL
	static next	= function() {
		if ( __Size == 0 ) { return EOL; }
		if ( __Index == undefined ) { __Index = { p: __First, i: 0 }; }
		if ( __Index.p == undefined ) { return EOL; }
		
		var _value	= __Index.p.value;
		
		__Index = { p: __Index.p.next, i: __Index.i + 1 };
		
		return _value;
		
	}
	/// @func	Seeks the previous value in the list before the last read position, or EOL if the front
	///		of the list has been reached.  Can use index() to set the next read position.
	/// @returns value or EOL
	static previous	= function() {
		if ( size() == 0 || __Index == undefined || __Index.i == 0 ) { return EOL; }
		
		index( __Index.i - 1 );
		
		return __Index.p.value;
		
	}
	/// @param {mixed} *values...	One or more values
	/// @desc	Adds the given values to the end of the list
	/// @returns self
	static push	= function() {
		static __add__	= function( _v ) {
			if ( __Last == undefined ) {
				__First	= { value: _v, next: undefined }
				__Last		= __First;
				
			} else {
				__Last.next	= { value: _v, next: undefined }
				__Last		= __Last.next;
				
			}
			++__Size;
		}
		var _f = __OrderedBy == undefined ? 
				__add__
				:
			function( _v ) {
				insert( __OrderedBy( _v ), _v );
			}
		var _i = 0;
		
		if ( size() == 0 ) { __add__( argument[ _i++ ] ); }
		
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
	/// @returns self
	/// @throws IndexOutOfBounds
	static insert	= function( _index, _value ) {
		if ( __Dupes == false && contains( _value ) ) { return; }
		if ( _index < 0 || _index > size() ) { throw new IndexOutOfBounds( "insert", _index, size() ); }
		if ( _index = 0 ) {
			__First	= { value: _value, next: __First }
			__Index	= { p: __First, i: 0 }
			
		} else {
			index( _index - 1 );
			__Index.p.next	= { value: _value, next: __Index.p.next }
			
		}
		++__Size;
		
		return self;
		
	}
	/// @param {int}	index	The position to write to
	/// @param {Mixed}	value	The value to write
	/// @desc	Writes the value to the given index in the list.  If the index is out of range
	///		an IndexOutOfBounds will be thrown.
	/// @throws IndexOutOfBounds
	static replace	= function( _index, _value ) {
		if ( _index < 0 || _index >= size() ) { throw new IndexOutOfBounds( "index", _index, size() ); }
		
		index( _index );
		
		__Index.p.value	= _value;
		
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
		
		if ( size() == 1 && ( _index == 0 || _index == undefined ) ) {
			_value	= __First.value;
			
			__First	= undefined;
			__Last	= undefined;
			__Index	= undefined;
			
		} else {
			_index = _index == undefined ? __Size : _index + 1;
			
			var _i = 0, _l = __First, _last = undefined; repeat( _index ) {
				if ( ++_i == _index ) {
					_value	= _l.value;
					
					if ( _last == undefined )
						__First	= _l.next;
					else
						_last.next	= _l.next;
					
					if ( _l == __Last ) {
						__Last		= _last;
						__Index		= undefined;
						
					} else {
						__Index = { p: _l.next, i: _index };
						
					}
					
				}
				_last	= _l;
				_l		= _l.next;
				
			}
			
		}
		--__Size;
		
		return _value;
		
	}
	/// @desc	Clears the list
	static clear	= function() {
		__First	= undefined;
		__Last	= undefined;
		__Size	= 0;
		
	}
	/// @desc	Returns the size of the list
	/// @returns int
	static size		= function() { return __Size; }
	
	__First		= undefined;
	__Last		= undefined;
	__Index		= undefined;
	__Size		= 0;
	__Type__.add( LinkedList );
	
}
