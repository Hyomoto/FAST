/// @func Dictionary
/// @desc    Creates a dictionary-type structure.
/// @wiki Core-Index Data Structures
function Dictionary() constructor {
    /// @param {string}    key        The key used to look up the value
    /// @param {mixed}    value    The value to assign to the key
    /// @desc    Sets the given key in the dictionary to the provided value.  If the key is not a
    ///        string, InvalidArgumentType will be thrown.
	/// @returns self
    /// @throws InvalidArgumentType
    static set    = function( _key, _value, _overwrite ) {
        if ( is_string( _key ) == false ) { throw new InvalidArgumentType( "set", 0, _key, "string" ); }
        if ( _overwrite == true && variable_struct_exists( __Content, _key ) ) { return; }
		
        __Content[$ _key ]    = _value;
        
        return self;
        
    }
    /// @param {string}    key        The key to remove
    /// @desc    Removes the given key from the dictionary.  If the key didn't exist,
    ///        ValueNotFound will be thrown.  If the key was not a string, InvalidArgumentType is thrown.
	/// @returns self
    /// @throws InvalidArgumentType, ValueNotFound
    static unset    = function( _key ) {
        if ( is_string( _key ) == false ) { throw new InvalidArgumentType( "unset", 0, _key, "string" ); }
        if ( variable_struct_exists( __Content, _key ) == false ) { throw new ValueNotFound( "unset", _key ); }
        
        variable_struct_remove( __Content, _key );
        
        return self;
        
    }
    /// @param {string}    key        The key to look up
    /// @desc    Looks up the given key in the dictionary and returns its value.  If the key is
    ///        not a string, InvalidArgumentType is thrown.  If the value does not exist, ValueNotFound will
    ///        be thrown.
	/// @returns Mixed
    /// @throws InvalidArgumentType, ValueNotFound
    static lookup    = function( _key ) {
        if ( is_string( _key ) == false ) { throw new InvalidArgumentType( "lookup", 0, _key, "string" ); }
        if ( variable_struct_exists( __Content, _key ) == false ) { throw new ValueNotFound( "lookup", _key ); }
        
        return __Content[$ _key ];
        
    }
	/// @param {array} order	The array of keys to return
	/// @desc	Looks up each key in the provided order and returns the resulting array. If the key
	///		is not a string InvalidArgumentType will be thrown, and if the value does not exist,
	///		ValueNotFound will be thrown.
	/// @returns Array
	/// @throws InvalidArgumentType, ValueNotFound
    static lookup_by_array    = function( _order ) {
        if ( is_array( _order ) == false ) { throw new InvalidArgumentType( "lookup_by_array", 0, _order, "array" ); }
        
        var _i = -1; repeat( array_length( _order ) ) { ++_i;
            _order[ _i ]    = lookup( _order[ _i ] );
            
        }
        return _order;
        
    }
	/// @param	{string}	key
	/// @desc	Returns true if the specified key exists in the dictionary. If the key is not a string
	///		InvalidArgumentType will be thrown.
	/// @returns bool
	/// @throws InvalidArgumentType
	static key_exists	= function( _key ) {
		if ( is_string( _key ) == false ) { throw new InvalidArgumentType( "key_exists", 0, _key, "string" ); }
		
		return variable_struct_exists( __Content, _key );
		
	}
    /// @desc    Returns the keys in the dictionary formatted as an array.
    /// @returns Array
    static keys_to_array    = function() {
        return variable_struct_get_names( __Content );
        
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
		
		return self;
		
	}
	/// @desc	Returns this dictionary as a JSON string.
	/// @returns string
	static to_JSON	= function() {
		return json_stringify( __Content );
		
	}
	/// @desc	Returns true if this dictionary contains no keys.
	/// @returns int
	static is_empty	= function() {
		return size() == 0;
		
	}
	/// @desc    Returns the number of entries in the dictionary.
    /// @returns Mixed
    static size    = function() {
        return variable_struct_names_count( __Content );
        
    }
    /// @desc    The internal struct which holds the key/value pairs.
    __Content    = {}
    
}
