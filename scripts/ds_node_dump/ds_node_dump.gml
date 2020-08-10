/// @func ds_node_dump
/// @param node
/// @param *level
/// @desc	dumps the contents of a node
function ds_node_dump( _node, _level ) {
	_level	= ( is_undefined( _level ) ? 0 : _level );
	
	if ( instanceof( _node ) == "DsNodeNode" ) {
		_node	= _node.value;
		
	}
	if ( instanceof( _node ) != "DsNode" ) {
		log( "Provided argument is not a node." );
		
		return;
		
	}
	var _tab	= string_repeat( "	", _level );
	var _table	= _node.table;
	var _key	= ds_map_find_first( _table );
	var _value;
	
	log( _tab, "<node ", _node.table," has ", ds_map_size( _table ), " records>" );
	
	while ( _key != undefined ) {
		_value	= _table[? _key ];
		
		if ( _value.is( "node" ) ) {
			if ( _value.base == DsNodeLink ) {
				log( _tab, _key, "(id:", _value.value.table ,") * {" );
				
			} else {
				
				log( _tab, _key, "(id:", _value.value.table,") = {" );
				
			}
			ds_node_dump( _value.value, _level + 1 );
			
			log( _tab, "}" );
			
		} else {
			log( _tab, _key, " = ", _value );
			
		}
		_key	= ds_map_find_next( _table, _key );
		
	}
	
}
