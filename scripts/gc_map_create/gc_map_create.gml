/// @func gc_map_create
/// @desc	Creates a new map and returns a struct containing it.  If this struct is
//		lost, the data structure will be cleaned up also.
function gc_map_create() {
	var _pointer	= { pointer : ds_map_create() };
	
	GarbageManager().add(
		_pointer,
		_pointer.pointer,
		function( _x ) { if ( ds_exists( _x, ds_type_map ) ) ds_map_destroy( _x ); }
	);
	return _pointer;
	
}
