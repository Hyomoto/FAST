/// @func gc_stack_create
function gc_stack_create() {
	var _list	= { pointer : ds_stack_create() };
	
	GarbageManager().add( {
		ref : weak_ref_create( _list ),
		pointer : _list.pointer,
		destroy : function() { ds_stack_destroy( pointer ); }
	});
	return _list;
	
}
