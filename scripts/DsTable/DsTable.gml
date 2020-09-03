/// @func DsTable
function DsTable() constructor {
	static add	= function( _key, _value ) {
		ds_map_add( map, _key, _value );
		ds_list_add( list, _value );
		
		return _value;
		
	}
	static empty	= function() {
		return ds_map_empty( map );
		
	}
	static size	= function() {
		return ds_map_size( map );
		
	}
	/// @func find_value_by_key
	/// @param key
	/// @param *undefined
	static find_value_by_key	= function( _key ) {
		var _value		= ds_map_find_value( map, _key );
		var _undefined	= ( argument_count > 1 ? argument[ 1 ] : undefined );
		
		return ( is_undefined( _value ) ? _undefined : _value );
		
	}
	static find_key_by_value	= function( _value ) {
		var _find	= first_key();
		
		repeat ( size() ) {
			if ( ds_map_find_value( map, _find ) == _value ) {
				return _find;
				
			}
			_find	= next_key( _find );
			
		}
		return undefined;
		
	}
	static find_index_by_value	= function( _value ) {
		return ds_list_find_index( list, _index );
		
	}
	static find_value_by_index	= function( _index ) {
		return ds_list_find_value( list, _index );
		
	}
	static replace_by_key	= function( _key, _value ) {
		var _index	= find_index_by_value( find_value_by_key( _key ) );
		
		ds_map_replace( map, _key, _value );
		ds_list_set( list, _index, _value );
		
		return _value;
		
	}
	static replace_by_index	= function( _index, _value ) {
		var _key	= find_key_by_value( find_value_by_index( _index ) );
		
		ds_map_replace( map, _key, _value );
		ds_list_set( list, _index, _value );
		
		return _value;
		
	}
	static first_key	= function() {
		return ds_map_find_first( map );
		
	}
	static next_key	= function( _key ) {
		return ds_map_find_next( map, _key );
		
	}
	static remove_by_key	= function( _key ) {
		var _index	= find_index_by_value( find_value_by_key( _key ) );
		
		ds_map_delete( map, _key );
		ds_list_delete( list, _index );
		
	}
	static remove_by_index	= function( _index ) {
		var _key	= find_key_by_value( find_value_by_index( _index ) );
		
		ds_map_delete( map, _key );
		ds_list_delete( list, _index );
		
	}
	static is		= function( _data_type ) {
		return _data_type == DsTable;
		
	}
	static toArray	= function() {
		var _array	= array_create( size() );
		
		var _i = 0; repeat( size() ) {
			_array[ _i ]	= [ find_key_by_value( list[| _i ] ), list[| _i ] ];
			
			++_i;
			
		}
		return _array;
		
	}
	static toString	= function() {
		return string( toArray() );
		
	}
	static destroy	= function() {
		ds_map_destroy( map );
		ds_list_destroy( list );
		
	}
	map		= ds_map_create();
	list	= ds_list_create();
	
}
