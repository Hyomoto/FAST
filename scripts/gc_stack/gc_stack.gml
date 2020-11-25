/// @func gc_stack
function gc_stack() {
	var _list	= { pointer : ds_stack_create() };
	
	GarbageManager().add( {
		ref : weak_ref_create( _list ),
		pointer : _list.pointer,
		destroy : function() { ds_stack_destroy( pointer ); }
	});
	return _list;
	
}
