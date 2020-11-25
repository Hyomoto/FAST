/// @func gc_map
function gc_map() {
	var _list	= { pointer : ds_map_create() };
	
	GarbageManager().add( {
		ref : weak_ref_create( _list ),
		pointer : _list.pointer,
		destroy : function() { ds_map_destroy( pointer ); }
	});
	return _list;
	
}
