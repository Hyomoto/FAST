/// @func DsTree
/// @desc DsTree is a traversable tree-like data structure
function DsTree() constructor {
	// finds the node at the given path and returns it
	static seek	= function( _path ) {
		var _dot	= string_pos( ".", _path );
		var _key	= ( _dot == 0 ? _path : string_copy( _path, 1, _dot - 1 ) );
		var _value	= table[? _key ];
		
		if ( _dot > 0 && _value != undefined && _value.is( "node" ) == false ) {
			_value	= undefined;
			
		}
		if ( _dot == 0 || _value == undefined ) {
			return ( _value == undefined ? undefined : _value );
			
		}
		return _value.value.seek( string_delete( _path, 1, _dot ) );
		
	}
	// flags the node as read-only
	static lock		= function( _path ) {
		var _value	= seek( _path );
		
		if ( _value != undefined ) {
			_value.lock();
			
		}
		
	}
	// flags the node as editable, all nodes are editable by default
	static unlock	= function( _path ) {
		var _value	= seek( _path );
		
		if ( _value != undefined ) {
			_value.unlock();
			
		}
		
	}
	// destroys the node
	static destroy	= function() {
		var _key	= ds_map_find_first( table );
		
		while ( _key != undefined ) {
			table[? _key ].destroy();
			
			_key	= ds_map_find_next( table, _key );
			
		}
		ds_map_destroy( table );
		
	}
	// returns the size of the node structure
	static size	= function( _links ) {
		_links	= ( _links == undefined ? true : _links );
		
		if ( branch == false ) {
			return ds_map_size( table );
			
		}
		var _key	= ds_map_find_first( table );
		var _size	= ds_map_size( table );
		var _value;
		
		repeat( _size ) {
			_value	= table[? _key ];
			
			if ( _value.is( "node" ) ) {
				if ( _value.base != DsTree_Link || _links ) {
					_size	+= _value.value.size( _links );
					
				}
				
			}
			_key	= ds_map_find_next( table, _key );
			
		}
		return _size;
		
	}
	// returns the value at the given path, or undefined
	static get	= function( _path, _undefined ) {
		var _value	= seek( _path );
		
		return ( is_undefined( _value ) ? _undefined : _value.value );
		
	}
	// sets the value at the given path, will infer type if not provided
	static set	= function( _path, _value, _type ) {
		var _dot	= string_pos( ".", _path );
		var _key	= ( _dot == 0 ? _path : string_copy( _path, 1, _dot - 1 ) );
		var _seek	= table[? _key ];
		
		if ( _dot == 0 ) {
			if ( _seek != undefined ) {
				if ( _seek.writable == false ) {
					return;
					
				}
				_seek.destroy();
				
			}
			if ( _type == undefined ) {
				if ( is_struct( _value ) ) { _value = new DsTree_Struct( _value ); }
				else if ( is_string( _value ) ) { _value = new DsTree_String( _value ); }
				else if ( is_real( _value ) ) { _value = new DsTree_Number( _value ); }
				else if ( is_array( _value ) ) { _value = new DsTree_Array( _value ); }
				else { _value = new DsTree_Value( _value ); }
				
			} else {
				if ( _type != 0 ) {
					_value	= new _type( _value );
					
				}
				
			}
			if ( _value.type == "node" ) {
				branch	= true;
				
			}
			table[? _key ]	= _value;
			
		} else {
			if ( _seek == undefined || _seek.is( "node" ) == false ) {
				if ( _seek != undefined ) {
					_seek.destroy();
					
				}
				_seek	= new DsTree();
				
				table[? _key ]	= new DsTree_Branch( _seek );
				
				branch	= true;
				
			} else {
				_seek	= _seek.value;
				
			}
			_seek.set( string_delete( _path, 1, _dot ), _value, _type );
			
		}
		
	}
	// copies this node into the node provided, or a new one if not provided, and
	// returns it
	static copy		= function( _target ) {
		var _new	= ( _target == undefined ? new DsTree() : _target );
		var _key	= ds_map_find_first( table );
		var _value, _seek;
		
		while ( _key != undefined ) {
			_value	= table[? _key ];
			_seek	= _new.seek( _key );
			
			if ( _seek != undefined && _seek.base == DsTree_Branch && _value.base == DsTree_Branch ) {
				_value.value.copy( _seek.value );
				
			} else {
				_new.set( _key, _value.copy(), false );
				//ds_map_replace( _new.table, _key, _value.copy() );
				
			}
			_key	= ds_map_find_next( table, _key );
			
		}
		_new.branch	= branch;
		
		return _new;
		
	}
	// removes the value with the given key
	static remove	= function( _key ) {
		var _value	= table[? _key ];
		
		if ( _value != undefined ) {
			_value.destroy();
			
		}
		ds_map_delete( table, _key );
		
	}
	// returns this node as a string
	static toString	= function() {
		return "node :: map " + string( table ) + ", entries " + string( ds_map_size( table ) );
		
	}
	table	= ds_map_create();
	branch	= false;
	
}
