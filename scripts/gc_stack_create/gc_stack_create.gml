/// @func gc_stack_create
/// @desc	Creates a new stack and returns a struct containing it.  If this struct is
//		lost, the data structure will be cleaned up also.
function gc_stack_create() {
	var _pointer	= { pointer : ds_stack_create() };
	
	GarbageManager().add(
		_pointer,
		_pointer.pointer,
		function( _x ) { if ( ds_exists( _x, ds_type_priority ) ) ds_stack_destroy( _x ); }
	);
	return _pointer;
	
}
