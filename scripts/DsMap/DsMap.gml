/// @func DsMap
/// @wiki Core-Index Data Structures
function DsMap() constructor {
	static add	= function( _key, _value ) {
		ds_map_add( pointer, _key, _value );
		
		return _value;
		
	}
	static replace	= function( _key, _value ) {
		ds_map_replace( pointer, _key, _value );
		
		return _value;
		
	}
	/// @param key
    /// @param value to set if key does not have a value already
    /// @desc If the value read at {key} is undefined, the value at {key} assumes the value of {value}
    static assume = function( _key, _value ) {
        var _r = read(_key);
        return (is_undefined( _r ) ? replace( _key, _value ) : _r );
    }
	
	static empty	= function() {
		return ds_map_empty( pointer );
		
	}
	static size	= function() {
		return ds_map_size( pointer );
		
	}
	static find	= function( _key ) {
		var _value		= ds_map_find_value( pointer, _key );
		var _undefined	= ( argument_count > 1 ? argument[ 1 ] : undefined );
		
		return ( is_undefined( _value ) ? _undefined : _value );
		
	}
	static first	= function() {
		return ds_map_find_first( pointer );
		
	}
	static next	= function( _key ) {
		return ds_map_find_next( pointer, _key );
		
	}
	static remove	= function( _key ) {
		ds_map_delete( pointer, _key );
		
	}
	static destroy	= function() {
		ds_map_destroy( pointer );
		
	}
	static read		= function( _string ) {
		ds_map_read( pointer, _string );
		
	}
	static copy		= function() {
		var _map	= ds_map_create();
		
		ds_map_copy( _list, pointer );
		
		return _map;
		
	}
	static toArray	= function() {
		var _array	= array_create( ds_map_size( pointer ) );
		var _next = ds_map_find_first( pointer );
		
		var _i = 0; repeat( array_length( pointer ) ) {
			_array[ _i++ ]	= [ _next, ds_map_find_value( pointer, _next ) ];
			
			_next	= ds_map_find_next( pointer, _next );
			
		}
		return _array;
		
	}
	static toString	= function() {
		return ds_map_write( pointer );
		
	}
	static is		= function( _data_type ) {
		return _data_type == DsMap;
		
	}
	pointer	= ds_map_create();
	
}
