/// @func DatabaseManager
function DatabaseManager() {
	static database	= function() constructor {
		static	__undefined	= new DsTree_Value( undefined );
		static logger	= new Logger( "database", FAST_LOGGER_DEFAULT_LENGTH, System, new FileText( "log/database.txt", false, true ) );
		static log	= function() {
			var _string	= "";
			
			var _i = 0; repeat( argument_count ) {
				_string	+= string( argument[ _i++ ] );
				
			}
			logger.write( _string );
			
		}
		static add_datatype	= function( _key, _function ) {
			if ( ds_map_find_value( table, _key ) != undefined ) {
				log_notify( undefined, "DatabaseManager.add_datatype", "Data type ", _key, " was previously defined. It has been overwritten." );
				
				++warnings;
				
			}
			table[? _key ]	= _function;
			
		}
		static get_datatype	= function( _key ) {
			return table[? _key ];
			
		}
		static add_static	= function( _key, _value ) {
			_value.writable	= false;
			
			values[? _key ]	= _value;
			
			return _value;
			
		}
		static get_static	= function( _key ) {
			return values[? _key ];
			
		}
		static clear_static	= function() {
			ds_map_clear( values );
			
		}
		static add_link		= function( _link ) {
			ds_queue_enqueue( links, _link );
			
		}
		static resolve_links= function( _node ) {
			var _size	= -1;
			var _base, _link;
			
			while ( ds_queue_size( links ) != _size ) {
				_size	= ds_queue_size( links );
				
				repeat( ds_queue_size( links ) ) {
					_base	= ds_queue_dequeue( links );
					_link	= _node.seek( _base.value );
					
					if ( _link == undefined ) {
						ds_queue_enqueue( links, _base );
						
						continue;
						
					}
					_base.value	= _link.value;
					_base.type	= _link.type;
					
				}
				
			}
			
		}
		// reads entires and converts them to DsTree_Values
		static parse		= function( _value, _file ) {
			var _first	= string_char_at( _value, 1 );
			
			switch ( _first ) {
				case "$" :
					var _break	= string_explode( _value, ":", false );
					var _type	= get_datatype( string_delete( _break[ 0 ], 1, 1 ) );
					
					if ( _type == undefined ) {
						log_nonfatal( undefined, "FAST_database_load.lookup", "Data type ", _break[ 0 ], " not found. Ignored." );
						
						++errors;
						
						return __undefined;
						
					}
					return _type( _break[ 1 ], _file );
					
				case "@" :
					var _static = get_static( string_delete( _value, 1, 1 ) );
					
					if ( _static == undefined ) {
						log_nonfatal( undefined, "FAST_database_load.lookup", "Static ", _value, " not found. Ignored." );
						
						++errors;
						
						return __undefined;
						
					}
					return _static.copy();
					
				default :
					var _type	= ( type == undefined ? undefined : get_datatype( type ) );
					
					if ( _type == undefined ) {
						if ( _first == "\"" ) {
							return new DsTree_String( string_copy( _value, 2, string_length( _value ) - 2 ) );
							
						}
						return new DsTree_Number( string_to_real( _value ) );
						
					}
					return _type( _value, _file );
					
			}
			throw( "DatabaseManager().parse unexpectedly failed! This shouldn't be possible." );
			
		}
		table	= ds_map_create();
		values	= ds_map_create();
		links	= ds_queue_create();
		stack	= ds_stack_create();
		type	= undefined;
		records	= 0;
		errors	= 0;
		warnings= 0;
		
		add_datatype( "array", function( _input ) {
			var _array	= string_explode( _input, ",", true );
			
			var _i = 0; repeat( array_length( _array ) ) {
				if ( string_char_at( _array[ _i ], 1 ) == "\"" ) {
					_array[ _i ]	= string_copy( _array[ _i ], 2, string_length( _array[ _i ] ) - 2 );
					
				} else {
					_array[ _i ]	= string_to_real( _array[ _i ] );
					
				}
				//_array[ _i ]	= parse( _array[ _i ] ).value;
				
				++_i;
				
			}
			return new DsTree_Array( _array );
			
		});
		add_datatype( "link", function( _input, _file ) {
			var _link	= new DsTree_Link( _input );
			
			add_link( _link );
			
			return _link;
			
		});
		
	}
	static instance	= new Feature( "FAST Database", "1.0", "08/02/2020", new database() );
	return instance.struct;
	
}
