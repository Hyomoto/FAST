/// @func gc_list_create
function gc_list_create() {
	var _list	= { pointer : ds_list_create() };
	
	GarbageManager().add( {
		ref : weak_ref_create( _list ),
		pointer : _list.pointer,
		destroy : function() { ds_list_destroy( pointer ); }
	});
	return _list;
	
}
