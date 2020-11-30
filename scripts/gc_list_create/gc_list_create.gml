/// @func gc_list_create
/// @desc	Creates a new list and returns a struct containing it.  If this struct is
//		lost, the data structure will be cleaned up also.
function gc_list_create() {
	var _pointer	= { pointer : ds_list_create() };
	
	GarbageManager().add(
		_pointer,
		_pointer.pointer,
		function( _x ) { if ( ds_exists( _x, ds_type_list ) ) ds_list_destroy( _x ); }
	);
	return _pointer;
	
}
