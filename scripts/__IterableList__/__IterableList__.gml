/// @func __IterableList__
/// @desc	IterableList is a template for building iterable lists.  This allows them to be used in a
///		consistent way throughout the library and your program.  If you wish to create your own
///		implementation, simply inherit it and overload the first seven methods.
function __IterableList__() : __Struct__() constructor {
	static index	= function(i) {}	// overload
	static next		= function(i) {}	// overload
	static push		= function(v) {}	// overload
	static insert	= function(i,v) {}	// overload
	static replace	= function(i,v) {}	// overload
	static pop		= function(i) {}	// overload
	static clear	= function() {}		// overload
	static size		= function() {}		// overload
	/// @param {int}	first	The first position
	/// @param {int}	second	The second position
	/// @desc	Swaps the position of the two elements.
	/// @throws InvalidArgumentType
	static swap		= function( _a, _b ) {
		if ( is_numeric( _a ) == false ) { throw new InvalidArgumentType( "swap", 0, _a, "number" ); }
		if ( is_numeric( _b ) == false ) { throw new InvalidArgumentType( "swap", 1, _b, "number" ); }
		
		var _hold	= index( _a );
		
		replace( _a, index( _b ) );
		replace( _b, _hold );
		
	}
	/// @param {mixed}	value	The value to be removed
	/// @desc	Removes the first item in the list that matches value.  If no such value exists,
	///		a ValueNotFound will be returned.
	/// @returns Mixed or ValueNotFound
	static remove	= function( _value ) {
		if ( size() > 0 ) {
			index( 0 );
			
			var _i = -1; repeat( size() ) { ++_i;
				if ( next() == _value ) { return pop( _i ); }
				
			}
			
		}
		return new ValueNotFound( "remove", _value );
		
	}
	/// @param {mixed}	value	The value to count
	/// @param	Counts the number of occurences of value in the list.
	/// @returns int
	static count	= function( _value ) {
		if ( size() == 0 ) { return 0; }
		
		index( 0 );
		
		var _c = 0; repeat( size() ) {
			if ( next() == _value ) { ++_c; }
			
		}
		return _c;
		
	}
	/// @param {mixed}	key		
	/// @param {method}	func	If true, 
	/// @desc	Returns a new (#LinkedList) containing all entires that match the key.  If func is
	///		defined, this value will be passed along with the index key.  Returning true will add
	///		that value to the final list.
	/// @throws InvalidArgumentType
	static filter	= function( _key, _f ) {
		var _iter	= new __Self();
		
		if ( size == 0 ) { return _iter; }
		
		if ( _f == undefined ) { _f = function( _a, _b ) { return _a == _b; }}
		if ( is_method( _f ) == false ) { throw new InvalidArgumentType( "filter", 1, _f, "method" ); }
		
		index( 0 ); repeat( size() ) {
			var _next	= next();
			
			if ( _f( _key, _next ) ) {
				_iter.push( _next );
				
			}
			
		}
		return _iter;
		
	}
	/// @param sorttype_or_function	The sort type (true for ascending, false for descending) or a function to use for sorting.
	/// @desc	Sorts the list according to the given rules
	static sort	= function( _sort_or_func ) {
		var _iter	= new __Self();
		
		var _array	= to_array();
		
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
	/// @param {method}	*func	optional: A function to determine comparison
	/// @desc	Returns a new (#$SELF$) containing all of the unique entires in this list.  If func is
	///		provided, the comparison will be done against the results of the function.  If this value
	///		is not a method, InvalidArgumentType will be thrown.
	/// @throws InvalidArgumentType
	/// @returns (#$SELF$)
	static unique	= function( _f ) {
		return union( [], _f );
		
	}
	/// @param {Mixed}	list	The list to combine with
	/// @param {method}	*func	optional: A function to determine comparison
	/// @desc	Returns a new (#$SELF$) combining all unique entries in this list and list.  If func is
	///		provided, the comparison will be done against the results of the function.  If this value
	///		is not a method, InvalidArgumentType will be thrown.
	/// @throws InvalidArgumentType
	/// @returns (#$SELF$)
	static union	= function( _list, _f ) {
		if ( _f == undefined ) { _f = function( _v ) { return _v; }}
		if ( is_method( _f ) == false ) { throw new InvalidArgumentType( "unique", 1, _f, "method" ); }
		
		var _iter	= new __Self();
		
		_list = [ self, _list ];
		
		var _i = 0; repeat( array_length( _list ) ) {
			var _t	= _list[ _i++ ];
			
			if ( is_array( _t ) ) { var _a = new Array(); _a.__Content = _t; _t = _a; }
			if ( struct_type( _t, __IterableList__ ) == false ) { throw new UnexpectedTypeMismatch("union", _t, "__IterableList__" ); }
			
			if ( _t.size() == 0 ) { continue; }
			
			_t.index( 0 ); repeat( _t.size() ) {
				var _next	= _t.next();
				
				if ( error_type( _iter.find( _next, _f ) ) == ValueNotFound )
					_iter.push( _next );
					
			}
			
		}
		return _iter;
		
	}
	/// @param {method}	*func	optional: A function to determine comparison
	/// @desc	Returns a new (#$SELF$) containing all of the entries shared with list.  If func is
	///		provided, the comparison will be done against the results of the function.  If this value
	///		is not a method, InvalidArgumentType will be thrown.
	/// @throws InvalidArgumentType
	/// @returns (#$SELF$)
	static intersection	= function( _list, _f ) {
		if ( _f == undefined ) { _f = function( _v ) { return _v; }}
		if ( is_method( _f ) == false ) { throw new InvalidArgumentType( "unique", 1, _f, "method" ); }
		
		var _iter	= new __Self();
		
		if ( is_array( _list ) ) { var _a = new Array(); _a.__Content = _list; _list = _a; }
		if ( struct_type( _list, __IterableList__ ) == false ) { throw new UnexpectedTypeMismatch("union", _list, "__IterableList__" ); }
		if ( _list.size() == 0 || size() == 0 ) { return _iter; }
		
		_list.index(0); repeat( _list.size() ) {
			var _next	= _list.next();
			
			if ( contains( _next, _f ) ) { _iter.push( _next ); }
			
		}
		return _iter;
		
	}
	/// @param {method}	*func	optional: A function to determine comparison
	/// @desc	Returns a new (#$SELF$) containing all of the entires not in the list.  If func is
	///		provided, the comparison will be done against the results of the function.  If this value
	///		is not a method, InvalidArgumentType will be thrown.
	/// @throws InvalidArgumentType
	/// @returns (#$SELF$)
	static difference	= function( _list, _f ) {
		if ( _f == undefined ) { _f = function( _v ) { return _v; }}
		if ( is_method( _f ) == false ) { throw new InvalidArgumentType( "unique", 1, _f, "method" ); }
		
		var _iter	= new __Self();
		
		if ( is_array( _list ) ) { var _a = new Array(); _a.__Content = _list; _list = _a; }
		if ( struct_type( _list, __IterableList__ ) == false ) { throw new UnexpectedTypeMismatch("union", _list, "__IterableList__" ); }
		if ( size() == 0 ) { return _iter; }
		
		index(0); repeat( size() ) {
			var _next	= next();
			
			if ( _list.contains( _next, _f ) == false ) { _iter.push( _next ); _list.push( _next ); }
			
		}
		return _iter;
		
	}
	/// @desc	Reverses the order of the internal elements
	static reverse	= function() {
		var _iter	= new ( asset_get_index( instanceof( self ) ))();
		
		if ( size() == 0 ) { return _iter; }
		
		index( 0 ); repeat( size() ) {
			_iter.insert( 0, next() );
			
		}
		return _iter;
		
	}
	/// @desc	Shuffles the elements of the array in a random order using a Fischer-Yates shuffle.
	static shuffle	= function( _rand ) {
		var _f	= struct_type( _rand, Randomizer ) ? method( _rand, _rand.next_range ) : irandom_range;
		var _iter	= copy();
		
		var _i = size(); repeat( size() - 1 ) { --_i;
            var _j = _f( 0, _i + 1 );
            
			_iter.swap( _i, _j );
            
        }
		return _iter;
		
	}
	/// @param {mixed}	value...	The value to find
	/// @param {method}	*func		optional: The function to use to check for matches
	/// @desc	Checks if the value exists in this list.  If it does not, a ValueNotFound error will
	///		be returned.  This can be check with the error_type() function.  If func is provided,
	///		the return of that function will be used for comparison.  If func is not a method,
	///		InvalidArgumentType will be thrown.
	/// @throws InvalidArgumentType
	/// @returns Mixed or ValueNotFound error
	static find	= function( _v, _f ) {
		if ( _f == undefined ) { _f = function( _v ) { return _v; }}
		if ( is_method( _f ) == false ) { throw new InvalidArgumentType( "find", 1, _f, "method" ); }
		
		if ( size() = 0 ) { return new ValueNotFound( "find", _v ); }
		
		if ( __OrderedBy != undefined ) {
			return __Search( _v );
			
		}
		if ( _f == undefined ) { _f = function( _v ) { return _v; } }
		
		index( 0 );
		
		var _i = -1; repeat( size() ) { ++_i;
			if ( _v == _f( next() )) { return _i; }
			
		}
		return new ValueNotFound( "find", _v );
		
	}
	/// @param {mixed}	value...	The value(s) to check for
	/// @desc	Returns true if the list contains all of the given values
	static contains	= function( _v, _f ) {
		if ( _f == undefined ) { _f = function( _v ) { return _v; }}
		if ( is_method( _f ) == false ) { throw new InvalidArgumentType( "contains", 1, _f, "method" ); }
		
		if ( is_array( _v ) == false ) { _v = [ _v ]; }
		
		if ( size() == 0 ) { return false; }
		
		var _i = 0; repeat( array_length( _v ) ) {
			if ( error_type( find( _v[ _i++ ] ) ) == ValueNotFound ) { return false; }
			
		}
		return true;
		
	}
	/// @desc	Returns a copy of this linked list
	/// @returns (#LinkedList)
	static copy	= function() {
		var _iter	= new __Self();
		
		if ( size() == 0 ) { return _iter; }
		
		index( 0 ); repeat( size() ) {
			_iter.push( next() );
			
		}
		return _iter;
		
	}
	/// @desc	Returns if the list is empty
	/// @returns bool
	static is_empty	= function() { return size() == 0; }
	/// @desc	If false, duplicates will not be added.
	static remove_duplicates	= function( _false ) { __Dupes = _false == false; return self; }
	/// @desc	If true, list will be sorted on push.
	static order	= function( _sort_or_func ) {
		switch( _sort_or_func ) {
			case undefined : case true :
				__OrderedBy = function( _v ) {
					var _m = __Search( _v );
					
					if ( error_type( _m ) == ValueNotFound ) { _m = _m.index; }
					
					return _v > index( _m ) ? _m + 1 : _m;
					
				} 
				break;
				
			case false	:
				__OrderedBy = function( _v ) {
					var _m = __Search( _v, function( _a, _b ) {
						return _a == _b ? 2 : _a < _b;
						
					});
					if ( error_type( _m ) == ValueNotFound ) { _m = _m.index; }
					
					return _v < index( _m ) ? _m + 1 : _m;
					
				}
				break;
				
		}
		return self;
		
	}
	/// @desc	Populates this structure with values from the given array
	static from_array	= function( _a ) {
		if ( is_array( _a ) == false ) { throw new InvalidArgumentType( "from_array", 0, _a, "array" ); }
		clear();
		var _i = 0; repeat( array_length( _a ) ) {
			push( _a[ _i++ ] );
			
		}
		return self;
		
	}
	/// @desc	Converts this data structure into an array and returns it.
	/// @param	{method}	*func	If provided, is used to populate the array.
	/// @desc	Returns this list as an array.  If func is defined, the value is passed into
	///		the function and the return is written instead.  If func is provided, but not
	///		a method, InvalidArgumentType is thrown.
	/// @throws InvalidArgumentType
	/// @returns Array
	static to_array	= function( _f ) {
		if ( _f == undefined ) { _f = function( _v ) { return _v; }}
		
		if ( is_method( _f ) == false ) { throw new InvalidArgumentType( "to_array", 0, _f, "method" ); }
		
		if ( size() == 0 ) { return []; }
		
		index( 0 );
		
		var _a = array_create( size() ), _i = 0; repeat( size() ) {
			_a[ _i++ ]	= _f( next() );
			
		}
		return _a;
		
	}
	/// @param {string}	JSON_string	The string to convert into a list
	/// @desc	Takes the provided string and uses it to populate the list.  If a string is not
	///		provided, InvalidArgumentType is thrown.  If the string does not convert into an array
	///		UnexpectedTypeMismatch will be thrown.
	/// @returns self
	/// @throws InvalidArgumentType, UnexpectedTypeMismatch
	static from_JSON	= function( _string ) {
		if ( is_string( _string ) == false ) { throw new InvalidArgumentType( "from_JSON", 0, _string, "string" ); }
		
		try {
			var _decode	= json_parse( _string );
		} catch ( _ex ) {
			throw new BadJSONFormat( "from_JSON" );
			
		}
		if ( is_array( _decode ) == false ) { throw new UnexpectedTypeMismatch( "from_JSON", _decode, "array" ); }
		
		return from_array( _decode );
		
	}
	/// @desc	Returns this list as a JSON string
	static to_JSON	= function() {
		return json_stringify( to_array() );
		
	}
	/// @desc	Converts this structure into a string and returns it.
	/// @returns String
	static toString	= function() {
		var _string	= "[";
		// small hack, index throws an error if iterable is empty so this avoids the call
		if ( size() > 0 ) { index(0); }
		
		var _i = 0; repeat( size() ) {
			if ( _i++ > 0 ) { _string += ","; }
			
			_string	+= string( next() );
			
		}
		return _string + "]";
		
	}
	static EOL	= {}
	static __Search	= function ( _value, _func ) {
		if ( _func == undefined ) { _func = function( _a, _b ) { return _a == _b ? 2 : _a > _b; }}
		
		var _l	= 0;
		var _h	= size() - 1;
		var _m	= 0;
		
		while ( _l <= _h ) {
			var _m	= ( _l + _h ) div 2;
			var _g	= index( _m );
			
			switch ( _func( _g, _value ) ) {
				case 0 : _l = _m + 1; break;
				case 1 : _h = _m - 1; break;
				default: return _m;
			}
		}
		return new ValueNotFound( "binary_search", _value, _m );
		
	}
	__Dupes		= true;
	__Self		= asset_get_index( instanceof( self ) );
	__OrderedBy	= undefined;
	__Type__.add( __IterableList__ );
	
}
