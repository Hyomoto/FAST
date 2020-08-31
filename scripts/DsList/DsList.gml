/// @func DsList
function DsList() constructor {
	static add	= function() {
		var _i = 0; repeat( argument_count ) {
			ds_list_add( pointer, argument[ _i++ ] );
			
		}
		
	}
	static insert	= function( _value, _index ) {
		ds_list_insert( pointer, _index, _value );
		
	}
	static remove_value	= function( _value ) {
		var _index	= ds_list_find_value( pointer, _value );
		
		if ( _index > 0 ) {
			ds_list_delete( pointer, _index );
			
		}
		
	}
	static remove_index	= function( _index ) {
		if ( _index < ds_list_size( pointer ) && _index > 0 ) {
			ds_list_delete( pointer, _index );
			
		}
		
	}
	static size	= function() {
		return ds_list_size( pointer );
	}
	static empty	= function() {
		return ds_list_empty( pointer );
		
	}
	static sort	= function( _ascending ) {
		ds_list_sort( pointer, _ascending );
		
	}
	static swap	= function( _source_index, _target_index ) {
		var _hold	= ds_list_find_value( pointer, _source_index );
		
		pointer[| _source_index ]	= pointer[| _target_index ];
		pointer[| _target_index ]	= _hold;
		
	}
	static find_value	= function( _value ) {
		return ds_list_find_index( pointer, _value );
		
	}
	static find_index	= function( _index ) {
		return ds_list_find_value( pointer, _index );
		
	}
	static destroy	= function() { ds_list_destroy( pointer ); }
	static toString	= function() {
		var _string	 = "";
		
		var _i = 0; repeat ( size() ) {
			if ( _i > 0 ) { _string += ", " }
			
			_string	+= pointer[| _i++ ];
			
		}
		return _string;
		
	}
	pointer	= ds_list_create();
	
	var _i = 0; repeat( argument_count ) {
		add( argument[ _i++ ] );
		
	}
	
}

