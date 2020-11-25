/// @func gc_priority_queue
function gc_priority_queue() {
	var _list	= { pointer : ds_priority_create() };
	
	GarbageManager().add( {
		ref : weak_ref_create( _list ),
		pointer : _list.pointer,
		destroy : function() { ds_priority_destroy( pointer ); }
	});
	return _list;
	
}
