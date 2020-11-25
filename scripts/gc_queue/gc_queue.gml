/// @func gc_queue
function gc_queue() {
	var _list	= { pointer : ds_queue_create() };
	
	GarbageManager().add( {
		ref : weak_ref_create( _list ),
		pointer : _list.pointer,
		destroy : function() { ds_queue_destroy( pointer ); }
	});
	return _list;
	
}
