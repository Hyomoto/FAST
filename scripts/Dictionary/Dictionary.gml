/// @func Dictionary
/// @desc    Creates a dictionary-type structure. Will be cleaned up automatically once the reference is lost.
/// @wiki Core-Index Data Structures
function Dictionary() constructor {
    /// @param {string}    key        The key used to look up the value
    /// @param {mixed}    value    The value to assign to the key
    /// @desc    Sets the given key in the dictionary to the provided value.  If the key is not a
    ///        string, InvalidArgumentType will be thrown.
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
    /// @throws InvalidArgumentType, ValueNotFound
    static lookup    = function( _key ) {
        if ( is_string( _key ) == false ) { throw new InvalidArgumentType( "lookup", 0, _key, "string" ); }
        if ( variable_struct_exists( __Content, _key ) == false ) { throw new ValueNotFound( "lookup", _key ); }
        
        return __Content[$ _key ];
        
    }
	static key_exists	= function( _key ) {
		if ( is_string( _key ) == false ) { throw new InvalidArgumentType( "key_exists", 0, _key, "string" ); }
		
		return variable_struct_exists( __Content, _key );
		
	}
    /// @desc    Returns the number of entries in the dictionary.
    /// @returns Mixed
    static size    = function() {
        return variable_struct_names_count( __Content );
        
    }
    /// @desc    Returns the keys in the dictionary formatted as an array.
    /// @returns Array
    static keys_to_array    = function() {
        return variable_struct_get_names( __Content );
        
    }
    /// @desc    Returns values in the dictionary, formatted as an array.  If order is
    ///        specified, the values will be retrieved in that order.  Otherwise, all values
    ///        will be returned in an arbitrary order.
    static values_to_array    = function( _order ) {
        if ( _order == undefined ) { _order = keys_to_array(); }
        
        var _i = -1; repeat( array_length( _order ) ) { ++_i;
            _order[ _i ]    = lookup( _order[ _i ] );
            
        }
        return _order;
        
    }
	static from_JSON	= function( _string ) {
		if ( is_string( _string ) == false ) { throw new InvalidArgumentType( "from_JSON", 0, _string, "string" ); }
		
		var _decode	= json_parse( _string );
		
		if ( is_struct( _decode ) == false ) { throw new UnexpectedTypeMismatch( "from_JSON", _decode, "struct" ); }
		
		__Content	= _decode;
		
	}
	/// @desc	Returns this dictionary as a JSON string
	static toString	= function() {
		return json_stringify( __Content );
		
	}
    /// @desc    The internal struct which holds the key/value pairs.
    __Content    = {}
    
}
