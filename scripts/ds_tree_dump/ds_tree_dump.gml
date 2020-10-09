/// @func ds_tree_dump
/// @param node
/// @param *level
/// @param *output
/// @desc	dumps the contents of a node
function ds_tree_dump( _node ) {
	var _level	= ( argument_count > 1 ? argument[ 1 ] : 0 );
	var _output	= ( argument_count > 2 ? argument[ 2 ] : System );
	
	if ( instanceof( _node ) == "DsTree_Branch" ) {
		_node	= _node.value;
		
	}
	try {
		if ( _node.is( DsTree ) == false ) {
			_output.write( "Provided argument is not a tree!" );
		
			return;
		}
		
	} catch ( _ex ) {
		_output.write( "Provided argument is not a tree!" );
		
	}
	var _tab	= string_repeat( "	", _level );
	var _table	= _node.table;
	var _key, _value;
	
	_key	= ds_map_find_first( _table );
	
	_output.write( _tab, "<node ", _node.table," has ", ds_map_size( _table ), " records>" );
	
	while ( _key != undefined ) {
		_value	= _table[? _key ];
		
		if ( _value.type == "node" ) {
			if ( _value.base == DsTree_Link ) {
				_output.write( _tab, _key, "(id:", _value.value.table ,") *= {" );
				
			} else {
				
				_output.write( _tab, _key, "(id:", _value.value.table,") := {" );
				
			}
			ds_tree_dump( _value.value, _level + 1 );
			
			_output.write( _tab, "}" );
			
		} else {
			_output.write( _tab, _key, " = ", _value );
			
		}
		_key	= ds_map_find_next( _table, _key );
		
	}
	
}
