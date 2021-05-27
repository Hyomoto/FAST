/// @func IterableList
/// @desc	Because of GML's constructor inheritance, each constructor must run in
///		order.  This provides a list template to that cause without any data that can be
///		inherited without causing issues.
// filter, from_array, toArray
function IterableList() constructor {
	static index	= function(i) {}	// overload
	static next		= function(i) {}	// overload
	static push		= function(v) {}	// overload
	static insert	= function(i,v) {}	// overload
	static pop		= function(i) {}	// overload
	static clear	= function() {}		// overload
	static size		= function() {}		// overload
	/// @param {mixed}	value	The value to be removed
	/// @desc	Removes the first item in the list that matches value.  If no such value exists,
	///		a ErrorValue will be thrown.
	/// @throws ErrorValue
	static remove	= function( _value ) {
		if ( size() == 0 ) { throw ErrorValue; }
		
		index( 0 );
		
		var _i = -1; repeat( size() ) { ++_i;
			if ( next() == _value ) { return pop( _i ); }
			
		}
		throw ErrorValue;
		
	}
	/// @param {mixed}	value	The value to count
	/// @param	Counts the number of occurences of value in the list.
	/// @returns int
	static count	= function( _value, _func ) {
		if ( size() == 0 ) { return 0; }
		
		if ( _func == undefined ) { _func = function( _key, _value ) { return _key == _value; }}
		
		index( 0 );
		
		var _c = 0; repeat( size() ) {
			if ( _func( _value, next() )) { ++_c; }
			
		}
		return _c;
		
	}
	/// @param {mixed}	key		
	/// @param {method}	func	If true, 
	/// @desc	Returns a new (#LinkedList) containing all entires that match the key.  If func is
	///		defined, this value will be passed along with the index key.  Returning true will add
	///		that value to the final list.
	/// @throws ErrorType
	static filter	= function( _key, _func ) {
		var _iter	= new __Self();
		
		if ( size == 0 ) { return _iter; }
		
		if ( _func == undefined ) { _func = function( _key, _value ) { return _key == _value; }}
		
		if ( is_method( _func ) == false ) { throw ErrorType; }
		
		index( 0 );
		
		repeat( size() ) {
			var _next	= next();
			
			if ( _func( _key, _next ) ) {
				_iter.push( _next );
				
			}
			
		}
		return _iter;
		
	}
	/// @param sorttype_or_function	The sort type (true for ascending, false for descending) or a function to use for sorting.
	/// @desc	Sorts the list according to the given rules
	static sort	= function( _sort_or_func ) {
		var _iter	= new __Self();
		
		var _array	= toArray();
		
		switch ( _sort_or_func ) {
			case undefined:
			case true:  _sort_or_func = function( _a, _b ) { return _a > _b ? 1 : -1; }; break;
			case false: _sort_or_func = function( _a, _b ) { return _a < _b ? 1 : -1; }; break;
		}
		array_sort( _array, _sort_or_func );
		
		var _i = 0; repeat( array_length( _array ) ) {
			_iter.push( _array[ _i++ ] );
			
		}
		return _iter;
		
	}
	/// @desc	Returns a new (#LinkedList) containing all of the unique entires in this list. The
	///		new list does not preserve the order of the original entries.
	static unique	= function() {
		var _iter	= new ( asset_get_index( instanceof( self ) ))();
		
		if ( size == 0 ) { return _iter; }
		
		var _array	= toArray();
		
		array_sort( _array, true );
		
		_iter.push( _array[ 0 ] );
		
		var _i = 1, _last = _array[ 0 ]; repeat( array_length( _array ) - 1 ) {
			if ( _array[ _i ] != _last ) { _iter.push( _array[ _i ] ); }
			_last	= _array[ _i++ ];
			
		}
		return _iter;
		
	}
	/// @desc	Reverses the order of the internal elements
	static reverse	= function() {
		var _iter	= new ( asset_get_index( instanceof( self ) ))();
		
		if ( size() == 0 ) { return _iter; }
		
		index( 0 );
		
		repeat( size() ) {
			_iter.insert( 0, next() );
			
		}
		return _iter;
		
	}
	/// @param {mixed}	value...	The value to find
	/// @param {method}	func		The function to use to check for matches
	/// @desc	Returns the index which matches the value
	static find	= function( _v, _f ) {
		if ( size() = 0 ) { return -1; }
		
		if ( _f == undefined ) { _f = function( _a, _b ) { return _a == _b; } }
		
		index( 0 );
		
		var _i = -1; repeat( size() ) { ++_i;
			if ( _f( _v, next() )) { return _i; }
			
		}
		return -1;
		
	}
	/// @param {mixed}	value...	The value to find
	/// @param {method}	func		The function to use to check for matches
	/// @desc	Returns the value which matches the value
	static pull	= function( _v, _f ) {
		if ( size() = 0 ) { return -1; }
		
		if ( _f == undefined ) { _f = function( _a, _b ) { return _a == _b; } }
		
		index( 0 );
		
		repeat ( size() ) {
			var _next	= next();
			
			if ( _f( _v, _next )) { return _next; }
			
		}
		return undefined;
		
	}
	/// @param {mixed}	value...	The value(s) to check for
	/// @desc	Returns true if the list contains all of the given values
	static contains	= function( _v ) {
		if ( size() == 0 ) { return false; }
		
		index( 0 );
		
		var _i = 0; repeat( argument_count * size() ) {
			var _next	= next();
			
			if ( _next == argument[ _i ] ) {
				if ( ++_i == argument_count ) { return true; }
				
				index( 0 );
				
				continue;
				
			}
			if ( _next == EOL ) { break; }
			
		}
		return false;
		
	}
	/// @desc	Returns a copy of this linked list
	/// @returns (#LinkedList)
	static copy	= function() {
		var _iter	= new (asset_get_index( instanceof( self ) ))();
		
		if ( size() == 0 ) { return _iter; }
		
		index( 0 );
		
		repeat( size() ) {
			_iter.push( next() );
			
		}
		return _iter;
		
	}
	/// @desc	Returns if the list is empty
	/// @returns bool
	static empty	= function() { return size() == 0; }
	/// @desc	If false, duplicates will not be added.
	/// @throws ErrorType
	static allow_duplicates	= function( _true ) { __Dupes = _true != false; return self; }
	/// @desc	Populates this structure with values from the given array
	static from_array	= function( _a ) {
		if ( is_array( _a ) == false ) { throw ErrorType; }
		clear();
		var _i = 0; repeat( array_length( _a ) ) {
			push( _a[ _i++ ] );
			
		}
		return self;
		
	}
	static toArray	= function() {
		if ( size() == 0 ) { return []; }
		
		index( 0 );
		
		var _a = array_create( size() ), _i = 0; repeat( size() ) {
			_a[ _i++ ]	= next();
			
		}
		return _a;
		
	}
	/// @desc	Converts this structure into a string.
	static toString	= function() {
		var _string	= "[";
		// small hack, index throws an error if iterable is empty
		if ( size() > 0 ) { index(0); }
		
		var _i = 0; repeat( size() ) {
			if ( _i++ > 0 ) { _string += ","; }
			
			_string	+= string( next() );
			
		}
		return _string + "]";
		
	}
	static EOL	= {}
	__Dupes	= true;
	__Self	= asset_get_index( instanceof( self ) );
	
}
