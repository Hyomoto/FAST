/// @func DsMap
function DsMap() constructor {
	static add	= function( _key, _value ) {
		ds_map_add( pointer, _key, _value );
		
		return _value;
		
	}
	static is_empty	= function() {
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
	static replace	= function( _key, _value ) {
		ds_map_replace( pointer, _key, _value );
		
		return _value;
		
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
	static dump	= function() {
		var _key	= first();
		
		repeat ( size() ) {
			show_debug_message( _key + " : " + string( find( _key ) ) );
			
			_key	= next( _key );
			
		}
		
	}
	static destroy	= function() {
		ds_map_destroy( pointer );
		
	}
	pointer	= ds_map_create();
	
}