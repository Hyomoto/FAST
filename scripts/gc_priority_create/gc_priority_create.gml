/// @func gc_priority_create
/// @desc	Creates a new priority queue and returns a struct containing it.  If this struct is
//		lost, the data structure will be cleaned up also.
function gc_priority_create() {
	var _pointer	= { pointer : ds_priority_create() };
	
	GarbageManager().add(
		_pointer,
		_pointer.pointer,
		function( _x ) { if ( ds_exists( _x, ds_type_priority ) ) ds_priority_destroy( _x ); }
	);
	return _pointer;
	
}
