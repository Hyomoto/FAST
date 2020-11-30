/// @func gc_queue_create
/// @desc	Creates a new queue and returns a struct containing it.  If this struct is
//		lost, the data structure will be cleaned up also.
function gc_queue_create() {
	var _pointer	= { pointer : ds_queue_create() };
	
	GarbageManager().add(
		_pointer,
		_pointer.pointer,
		function( _x ) { if ( ds_exists( _x, ds_type_priority ) ) ds_queue_destroy( _x ); }
	);
	return _pointer;
	
}
