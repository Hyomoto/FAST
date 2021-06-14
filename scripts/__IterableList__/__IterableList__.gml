/// @func __IterableList__
/// @desc	This is an interface for building python-style lists. To make a new data structure, inherit
///		this constructor and implement the first eight methods. IterableLists are compatible with one
///		another, despite any underlying differences in structure choice.  They can be used as stacks,
///		queues, unordered or ordered lists, and sets.  When used as an ordered list, binary search is
///		used for insertion and traversal, but this behavior can be changed by overwriting __Search.
/// @wiki Core-Index Abstract
function __IterableList__() : __Struct__() constructor {
	/// @desc Retrieves the value at the given index and sets the traversal pointer
	static index	= function(i) {}	// @overload
	/// @desc Returns the next value in the list, or EOL if the end has been reached
	static next		= function(i) {}	// @overload
	/// @desc Returns the previous value in the list, or EOL if the end has been reached
	static previous	= function(i) {}	// @overload
	/// @desc Adds the given values to the list
	static push		= function(v) {}	// @overload
	/// @desc Inserts the value at the given index
	static insert	= function(i,v) {}	// @overload
	/// @desc Replaces the element at the given index with the new value
	static replace	= function(i,v) {}	// @overload
	/// @desc Pops the last value off the list, or the index if provided
	static pop		= function(i) {}	// @overload
	/// @desc Clears the list
	static clear	= function() {}		// @overload
	/// @desc Returns the size of the list
	static size		= function() {}		// @overload
	/// @desc	Returns the first element in the data structure.
	/// @returns mixed or EOL
	static first	= function() {
		if ( size() == 0 ) { return EOL; }

		return index( 0 );

	}
	/// @desc	Returns the last element in the data structure.
	/// @returns mixed or ValueNotFound
	static last	= function() {
		if ( size() == 0 ) { return ValueNotFound( "last", "", -1 ); }

		return index( size() - 1 );

	}
	/// @param {int}	first	The first position
	/// @param {int}	second	The second position
	/// @desc	Swaps the position of the first and second elements.
	/// @throws InvalidArgumentType
	static swap		= function( _a, _b ) {
		if ( is_numeric( _a ) == false ) { throw new InvalidArgumentType( "swap", 0, _a, "number" ); }
		if ( is_numeric( _b ) == false ) { throw new InvalidArgumentType( "swap", 1, _b, "number" ); }

		var _hold	= index( _a );

		replace( _a, index( _b ) );
		replace( _b, _hold );

	}
	/// @param {mixed}	value	The value to be removed
	/// @param {method}	*func	optional: If provided, will be used for sake of comparison
	/// @desc	Removes the first item in the list that matches value.  If no such value exists,
	///		a ValueNotFound will be returned.
	/// @returns mixed or ValueNotFound
	static remove	= function( _value, _f ) {
		if ( size() > 0 ) {
			var _i = find( _value, _f );

			if ( error_type( _i ) != ValueNotFound )
				return pop( _i );

		}
		return new ValueNotFound( "remove", _value, -1 );

	}
	/// @param {mixed}	value	The value to count
	/// @desc	Counts the number of occurences of value in the list.
	/// @returns int
	static count	= function( _value ) {
		if ( size() == 0 ) { return 0; }

		index( 0 );

		var _c = 0; repeat( size() ) {
			if ( next() == _value ) { ++_c; }

		}
		return _c;

	}
	/// @param {mixed}	key		The value you want to filter by
	/// @param {method}	*func	optional: If provided, will be used for sake of comparison
	/// @desc	Returns a new {$self} containing all entires that match the key.  If func is
	///		defined, this value will be passed along with the index key.  Returning true will add
	///		that value to the final list.
	/// @throws InvalidArgumentType
	/// @returns {$self}
	static filter	= function( _key, _f ) {
		var _iter	= new __Self__();

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
	/// @param {mixed}	sort_or_func	The sort type logic to use
	/// @desc	If sort_or_func is true, or no argument is provided, the list will be sorted in ascending
	///		order.  If false, it will use a descending order.  Otherwise, if a function is provided, that
	///		will determine the ordering in the list.  If an invalid argument is provided, InvalidArgumentType
	///		will be thrown.
	/// @throws InvalidArgumentType
	/// @returns {$self}
	static sort	= function( _sort_or_func ) {
		var _iter	= new __Self__();

		var _array	= to_array();

		switch ( _sort_or_func ) {
			case undefined:
			case true:  _sort_or_func = function( _a, _b ) { return _a > _b ? 1 : -1; }; break;
			case false: _sort_or_func = function( _a, _b ) { return _a < _b ? 1 : -1; }; break;
		}
		if ( is_method( _sort_or_func ) == false ) { throw new InvalidArgumentType( "sort", 0, _sort_or_func, "method" ); }

		array_sort( _array, _sort_or_func );

		var _i = 0; repeat( array_length( _array ) ) {
			_iter.push( _array[ _i++ ] );

		}
		return _iter;

	}
	/// @param {method}	*func	optional: A function to determine comparison
	/// @desc	Returns a new {$self} containing all of the unique entires in this list.  If func is
	///		provided, the comparison will be done against the results of the function.  If this value
	///		is not a method, InvalidArgumentType will be thrown.
	/// @throws InvalidArgumentType
	/// @returns {$self}
	static unique	= function( _f ) {
		return union( [], _f );

	}
	/// @param {mixed}	list	The list to combine with
	/// @param {method}	*func	optional: A function to determine comparison
	/// @desc	Returns a new {$self} combining all unique entries in this list and list.  If func is
	///		provided, the comparison will be done against the results of the function.  If this value
	///		is not a method, InvalidArgumentType will be thrown.
	/// @throws InvalidArgumentType
	/// @returns {$self}
	static union	= function( _list, _f ) {
		if ( _f == undefined ) { _f = function( _v ) { return _v; }}
		if ( is_method( _f ) == false ) { throw new InvalidArgumentType( "unique", 1, _f, "method" ); }

		if ( is_array( _list ) ) { _list = new __Self__().from_array( _list ); }
		if ( struct_type( _list, __IterableList__ ) == false ) { throw new InvalidArgumentType("intersection", 0, _list, "__IterableList__" ); }
		if ( _list.size() == 0 && size() == 0 ) { return new __Self__(); }

		if ( _f == undefined ) { _f = string; }

		var _iter	= new __Self__();
		var _hold	= {};

		var _i = -1; repeat( size() ) { ++_i;
			if ( variable_struct_exists( _hold, _f( index( _i ) ) ))
				continue;

			_hold[$ _f( index( _i ) ) ]	= 1;
			_iter.push( index( _i ) )

		}
		var _i = -1; repeat( _list.size() ) { ++_i;
			if ( variable_struct_exists( _hold, _f( _list.index( _i ) ) ))
				continue;

			_hold[$ _f( _list.index( _i ) ) ]	= 1;
			_iter.push( _list.index( _i ) )

		}
		return _iter;

	}
	/// @param {mixed}	list	The list to intersect with
	/// @param {method}	*func	optional: A function to determine comparison
	/// @desc	Returns a new {$self} containing all of the entries shared with list.  If func is
	///		provided, the comparison will be done against the results of the function.  If this value
	///		is not a method, InvalidArgumentType will be thrown.
	/// @throws InvalidArgumentType
	/// @returns {$self}
	static intersection	= function( _list, _f ) {
		if ( _f == undefined ) { _f = function( _v ) { return _v; }}
		if ( is_method( _f ) == false ) { throw new InvalidArgumentType( "unique", 1, _f, "method" ); }

		if ( is_array( _list ) ) { _list = new __Self__().from_array( _list ); }
		if ( struct_type( _list, __IterableList__ ) == false ) { throw new InvalidArgumentType("intersection", 0, _list, "__IterableList__" ); }
		if ( _list.size() == 0 || size() == 0 ) { return new __Self__(); }

		if ( _f == undefined ) { _f = string; }

		var _iter	= new __Self__();
		var _hold	= {};

		var _i = -1; repeat( size() ) { ++_i;
			_hold[$ _f( index( _i ) ) ]	= index( _i );

		}
		var _i = -1; repeat( _list.size() ) { ++_i;
			var _key	= _f( _list.index( _i ) );

			if ( variable_struct_exists( _hold, _key ) == false ) { continue; }

			_iter.push( _hold[$ _key ] );

			variable_struct_remove( _hold, _key );

		}
		return _iter;

	}
	/// @param {mixed}	list	The list to difference with
	/// @param {method}	*func	optional: A function to determine comparison
	/// @desc	Returns a new {$self} containing all of the entires not in the list.  If func is
	///		provided, the comparison will be done against the results of the function.  If this value
	///		is not a method, InvalidArgumentType will be thrown.
	/// @throws InvalidArgumentType
	/// @returns {$self}
	static difference	= function( _list, _f ) {
		if ( _f == undefined ) { _f = function( _v ) { return _v; }}
		if ( is_method( _f ) == false ) { throw new InvalidArgumentType( "unique", 1, _f, "method" ); }

		if ( is_array( _list ) ) { _list = new __Self__().from_array( _list ); }
		if ( struct_type( _list, __IterableList__ ) == false ) { throw new InvalidArgumentType("difference", 0, _list, "__IterableList__" ); }

		if ( _f == undefined ) { _f = string; }

		if ( size() == 0 ) { return new __Self__(); }

		var _iter	= new __Self__();
		var _hold	= {};

		var _i = -1; repeat( _list.size() ) { ++_i;
			_hold[$ _f( _list.index( _i ) ) ]	= 1;

		}
		var _i = -1; repeat( size() ) { ++_i;
			var _key	= _f( index( _i ) );

			if ( variable_struct_exists( _hold, _key ) ) { continue; }

			_iter.push( index( _i ) );

			variable_struct_set( _hold, _key, 1 );

		}
		return _iter;

	}
	/// @desc	Returns a new {$self} containing all the elements of this list reversed.
	/// @returns {$self}
	static reverse	= function() {
		var _iter	= new ( asset_get_index( instanceof( self ) ))();

		if ( size() == 0 ) { return _iter; }

		index( 0 ); repeat( size() ) {
			_iter.insert( 0, next() );

		}
		return _iter;

	}
	/// @param {__Randomizer__}	random	optional: A randomizer to use for shuffling
	/// @desc	Returns a new {$self} with the elements of the list randomized using a Fischer-Yates shuffle.
	///		If a randomizer is provided, that will be used instead of the GMS random functions.
	/// @returns {$self}
	static shuffle	= function( _rand ) {
		var _f	= struct_type( _rand, __Randomizer__ ) ? method( _rand, _rand.next_int ) : irandom;
		var _iter	= copy();

		var _i = size(); repeat( size() - 1 ) { --_i;
            var _j = _f( _i );

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
	/// @returns Mixed or ValueNotFound
	static find	= function( _v, _f ) {
		if ( _f == undefined ) { _f = function( _v ) { return _v; }}
		if ( is_method( _f ) == false ) { throw new InvalidArgumentType( "find", 1, _f, "method" ); }

		if ( size() = 0 ) { return new ValueNotFound( "find", _v, -1 ); }

		if ( __OrderedBy != undefined ) {
			return __Search( _v );

		}
		if ( _f == undefined ) { _f = function( _v ) { return _v; } }

		index( 0 );

		var _i = -1; repeat( size() ) { ++_i;
			if ( _v == _f( next() )) { return _i; }

		}
		return new ValueNotFound( "find", _v, -1 );

	}
	/// @param {mixed}	value...	The value(s) to check for
	/// @param {method}	*func	optional: A function to determine comparison
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
	/// @desc	Returns a copy of this {$self}
	/// @returns {$self}
	static copy	= function() {
		var _iter	= new __Self__();

		if ( size() == 0 ) { return _iter; }

		index( 0 ); repeat( size() ) {
			_iter.push( next() );

		}
		return _iter;

	}
	/// @desc	Returns if the list is empty
	/// @returns bool
	static is_empty	= function() { return size() == 0; }
	/// @param {bool}	false	Whether or not to allow duplicates
	/// @desc	If true, or a argument is not provided, duplicates will not be added to the list.
	static no_duplicates	= function( _false ) { __Dupes = _false == false; return self; }
	/// @param {mixed}	sort_or_func	The sorting method to use
	/// @desc	If sort_or_func is true, or no argument is provided, the list will be ordered in ascending
	///		fashion.  If false, it will use a descending order.  Otherwise, if a function is provided, that
	///		will determine the ordering in the list.
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
	/// @param {__InputStream__}	input	An InputStream to read from.
	/// @param {bool}				close	If false, the stream will not be closed after reading
	/// @desc	Populates this structure with values from the provided input stream.  By default,
	///		the stream will be closed afterwards.  If close is false, however, this behavior will
	///		be overridden.  If input is not an {#__InputStream__}, InvalidArgumentType will be
	///		thrown.
	/// @throws InvalidArgumentType
	/// @returns self
	static from_input	= function( _input, _close ) {
		if ( struct_type( _input, __InputStream__ ) == false ) { throw new InvalidArgumentType( "from_input", 0, _input, "__InputStream__" ); }
		clear();
		while( _input.finished() == false ) {
			push( _input.read() );

		}
		if ( _close != false ) { _input.close(); }

		return self;

	}
	/// @param {__OutputStream__}	output	An OutputStream to write to
	/// @param {bool}				close	If false, the stream will not be closed after writing
	/// @param {method}				*func	If provided, is used to determine what is sent to the stream.
	/// @desc	Writes this data structure to the provided output stream. By default, the stream will
	///		be closed after writing.  If close is false, however, this behavior will be overridden. If
	///		output is not an {#__OutputStream__} or func is not a method, InvalidArgumentType will be
	///		thrown.
	/// @throws InvalidArgumentType
	/// @returns output
	static to_output	= function( _output, _close, _f ) {
		if ( struct_type( _output, __OutputStream__ ) == false ) { throw new InvalidArgumentType( "to_output", 0, _output, "__OutputStream__" ); }

		if ( _f == undefined ) { _f = function( _v ) { return _v; }}

		if ( is_method( _f ) == false ) { throw new InvalidArgumentType( "to_array", 1, _f, "method" ); }

		index(0); repeat( size() ) {
			_output.write( _f( next() ) );

		}
		if ( _close != false ) { _output.close(); }

		return _output;

	}
	/// @param {array}	array	An array of values
	/// @desc	Populates this structure with values from the provided array.
	static from_array	= function( _a ) {
		if ( is_array( _a ) == false ) { throw new InvalidArgumentType( "from_array", 0, _a, "array" ); }
		clear();
		var _i = 0; repeat( array_length( _a ) ) {
			push( _a[ _i++ ] );

		}
		return self;

	}
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
	/// @ignore
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
	/// @var {struct}	The pointer that is returned when the end of list is reached
	/// @output constant
	static EOL	= {}
	/// @var {bool}	Whether or not this {$self} will accept duplicates
	__Dupes		= true;
	/// @var {method}	The function used to perform ordered insertions
	__OrderedBy	= undefined;

	__Type__.add( __IterableList__ );

}
