/// @func DsMap
/// @desc	Creates a wrapper for GML's map data structure.  If using GMS2.3.1 or above, the structure
//		will be cleaned up automatically, otherwise destroy() must be called to properly clean it up.
/// @wiki Core-Index Data Structures
function DsMap() constructor {
	/// @param {string}	key	The key that will be used to retrieve this value.
	/// @param {mixed}	value	The value to be assigned to the key.
	/// @desc Adds the specified key-value pair to the map.
	/// @returns mixed
	static add	= function( _key, _value ) {
		ds_map_add( pointer, _key, _value );
		
		return _value;
		
	}
	/// @param {string}	key		The key to retrieve from the map.
	/// @param {mixed}	value	The value to be assigned to the key.
	/// @desc Adds the specified key-value pair if it doesn't exist, and replaces it if it does.
	/// @returns mixed
	static replace	= function( _key, _value ) {
		ds_map_replace( pointer, _key, _value );
		
		return _value;
		
	}
	/// @param {string} key		The key to retrieve from the map.
	/// @param {mixed}	value	The value that will be set if key does not exist.
	/// @desc If the value read at {key} is undefined, the value at {key} assumes the value of {value}
	/// @returns mixed
	static assume = function( _key, _value ) {
		var _read = get( _key );

		if ( _read == undefined ) {
		  _read = replace( _key, _value );

		}
		return _read;
		
	}
	/// @desc Returns true if the DsMap is empty
	static empty	= function() {
		return ds_map_empty( pointer );
		
	}
	/// @desc Returns the number of elements in the DsMap
	static size	= function() {
		return ds_map_size( pointer );
		
	}
	/// @param {string}	key			The key to find in the map.
	/// @param {mixed}	undefined	optional: The value to return if the key is undefined.
	/// @desc	Searches for the given key, and returns the value if found, other wise undefined.
	static find	= function( _key ) {
		var _value		= ds_map_find_value( pointer, _key );
		var _undefined	= ( argument_count > 1 ? argument[ 1 ] : undefined );
		
		return ( is_undefined( _value ) ? _undefined : _value );
		
	}
	/// @desc	Returns the first key in the map.
	static first	= function() {
		return ds_map_find_first( pointer );
		
	}
	/// @desc	Returns the next key in the map after the given key.
	static next	= function( _key ) {
		return ds_map_find_next( pointer, _key );
		
	}
	/// @param {string}	key		The key to find in the map.
	/// @desc	If the given key exists, it will be removed from the map.
	static remove	= function( _key ) {
		ds_map_delete( pointer, _key );
		
	}
	/// @desc	Destroys the internal map, required to properly clean up DsMap
	static destroy	= function() {
		ds_map_destroy( pointer );
		
	}
	/// @desc	Decodes the given string into the contents of the map.
	static read		= function( _string ) {
		ds_map_read( pointer, _string );
		
	}
	/// @desc	Returns a copy of the internal map.
	static copy		= function() {
		var _map	= ds_map_create();
		
		ds_map_copy( _list, pointer );
		
		return _map;
		
	}
	/// @desc	Returns the map as an array of values.
	static toArray	= function() {
		var _array	= array_create( ds_map_size( pointer ) );
		var _next = ds_map_find_first( pointer );
		
		var _i = 0; repeat( array_length( pointer ) ) {
			_array[ _i++ ]	= [ _next, ds_map_find_value( pointer, _next ) ];
			
			_next	= ds_map_find_next( pointer, _next );
			
		}
		return _array;
		
	}
	/// @desc	Encodes the map as a string.
	static toString	= function() {
		return ds_map_write( pointer );
		
	}
	static is		= function( _data_type ) {
		return _data_type == DsMap;
		
	}
	/// @desc	The internal pointer to the map data structure.
	pointer	= ds_map_create();
	// if the runtime is 2.3.1 or greater, use Garbage
	if ( FAST.runtime.equal_to_or_greater( 2, 3, 1 ) ) {
		GarbageManager().add( self, pointer, function( _x ) { ds_map_destroy( _x ); } );
		
	}
	
}
