/// @func Dictionary
/// @desc    Creates a dictionary-type structure. Unlike a hash table, a dictionary can be searched
///		for a nearest match as well as specific entries, as well as iterate through entries forwards
///		or backwards.
/// @wiki Core-Index Data Structures
function Dictionary() : HashMap() constructor {
    /// @param {string}	key		The key used to look up the value
	/// @param {mixed}	value	The value to assign to the key
    /// @desc	Sets the given key in the dictionary to the provided value.  If the key is not a
    ///		string, InvalidArgumentType will be thrown.
	/// @returns self
    /// @throws InvalidArgumentType
    static set		= function( _key, _value ) {
		if ( is_string( _key ) == false ) { throw new InvalidArgumentType( "set", 0, _key, "string" ); }
        if ( variable_struct_exists( __Content, _key ) == false ) {
			__Keys.push( _key );
			
		}
        __Content[$ _key ]    = _value;
        
        return self;
        
    }
    /// @param {string}		key	The key to remove
    /// @desc	Removes the given key from the dictionary.  If the key didn't exist,
    ///		ValueNotFound will be thrown.  If the key was not a string, InvalidArgumentType is thrown.
	/// @returns self
    /// @throws InvalidArgumentType, ValueNotFound
    static unset	= function( _key ) {
        if ( is_string( _key ) == false ) { throw new InvalidArgumentType( "unset", 0, _key, "string" ); }
        if ( variable_struct_exists( __Content, _key ) == false ) { throw new ValueNotFound( "unset", _key ); }
        
        variable_struct_remove( __Content, _key );
        __Keys.remove( _key );
		
        return self;
        
    }
	/// @param {string}	key	The key to look up
    /// @desc	Looks up the given key in the dictionary and returns its value.  If the key is
    ///		not a string, InvalidArgumentType is thrown.  If the value does not exist, ValueNotFound will
    ///		be thrown.
	/// @returns Mixed
    /// @throws InvalidArgumentType, ValueNotFound
    static lookup    = function( _key ) {
        if ( is_string( _key ) == false ) { throw new InvalidArgumentType( "lookup", 0, _key, "string" ); }
        if ( variable_struct_exists( __Content, _key ) == false ) { throw new ValueNotFound( "lookup", _key ); }
        
		__Last	= __Keys.find( _key );
		
        return __Content[$ _key ];
        
    }
	/// @desc	Returns the value of the last read key, or ValueNotFound if it doesn't exist.
	/// @returns mixed or ValueNotFound
	static peek	= function() {
		if ( __Keys.size() == 0 || __Last == __Keys.size() || __Last == undefined ) { return new ValueNotFound( "peek", __Last, -1 ); }
		
		return __Content[$ __Keys.index( __Last ) ];
		
	}
	/// @param {mixed}	value	The value to assign
	/// @desc	Sets the last read key to the provided value.  If there was no last value read,
	///		ValueNotFound is thrown.
	/// @throws ValueNotFound
	/// @returns self
	static poke		= function( _value ) {
		if ( __Keys.size() == 0 || __Last == undefined ) { throw new ValueNotFound( "poke", __Last, -1 ); }
		
		var _key	= __Keys.index( __Last );
		
        __Content[$ _key ]    = _value;
        
        return self;
        
	}
	/// @desc	Returns the next key after the last key searched, or ValueNotFound if it doesn't exist.
	/// @returns mixed or ValueNotFound
	static first	= function() {
		if ( __Keys.size() == 0 ) { return new ValueNotFound( "next", "", -1 ); }
		
		var _value	= __Keys.first();
		
		__Last	= 0;
		
		return _value;
		
	}
	/// @desc	Returns the previous key after the last key searched, or ValueNotFound if it doesn't exist.
	/// @returns mixed or ValueNotFound
	static last		= function() {
		if ( __Keys.size() == 0 ) { return new ValueNotFound( "next", "", -1 ); }
		
		__Last	= __Keys.size() - 1;
		
		return __Keys.last();
		
	}
	/// @desc	Returns the next key after the last key searched, or ValueNotFound if it doesn't exist.
	/// @returns mixed or ValueNotFound
	static next		= function() {
		if ( __Last == undefined || __Last == __Keys.size() ) { return new ValueNotFound( "next", "undefined", -1 ); }
		if ( ++__Last == __Keys.size() ) {  return new ValueNotFound( "next", "undefined", -1 ); }
		
		return __Keys.index( __Last );
		
	}
	/// @desc	Returns the previous key after the last key searched, or ValueNotFound if it doesn't exist.
	/// @returns mixed or ValueNotFound
	static previous		= function() {
		if ( __Last == undefined || __Last == 0 ) { return new ValueNotFound( "next", "", -1 ); }
		
		return __Keys.index( --__Last );
		
	}
	/// @param {string}	pattern	The search pattern to look for
	/// @desc	Searches for the nearest key to the given search pattern.
	/// @returns string or ValueNotFound
	static search	= function( _pattern ) {
		if ( size() == 0 ) { return new ValueNotFound( "search", _pattern, -1 ); }
		if ( size() == 1 ) { return __Keys.index( 0 ); }
		
		var _i	= __Keys.find( _pattern );
		
		__Last	= _i.index;
		
		if ( _pattern > __Keys.index( __Last ) && __Last != __Keys.size() - 1 ) {
			__Last++;
			
		}
		return __Keys.index( __Last );
		
	}
    /// @desc	Returns the keys in the dictionary formatted as an array.
    /// @returns Array
    static keys_to_array    = function() {
        return __Keys.__Content;
        
    }
	/// @param {string}	JSON_string	The string to convert into a dictionary
	/// @desc	Takes the provided string and uses it to populate the dictionary.  If a string is not
	///		provided, InvalidArgumentType is thrown.  If the string does not convert into a dictionary
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
		if ( is_struct( _decode ) == false ) { throw new UnexpectedTypeMismatch( "from_JSON", _decode, "array" ); }
		
		__Content	= _decode;
		
		__Keys.__Content	= variable_struct_get_names( __Content );
		
		__Last	= undefined;
		
		array_sort( __Keys.__Content, true );
		
		return self;
		
	}
	/// @desc    Returns the number of entries in the dictionary.
    /// @returns Mixed
    static size    = function() {
        return __Keys.size();
        
    }
	/// @desc	Empties the hash table
	static clear	= function() {
		__Content	= {};
		__Keys.clear();
		__Last		= undefined;
		
	}
    /// @var {struct}		The internal struct which holds the key/value pairs.
    __Content	= {}
	/// @var {ArrayList}	An ordered list of all the keys in the dictionary.
    __Keys		= new ArrayList().order();
	/// @var {int}			The last key that was looked up in the dictionary.
	__Last		= undefined;
	
	__Type__.add( Dictionary );
	
}
