/// @func gc_grid_create
/// @param {int}	width	The width of the grid.
/// @param {int}	height	The height of the grid.
/// @desc	Creates a new grid with the given dimensions and returns a struct containing it.  If this
//		struct is lost, the data structure will be cleaned up also.
function gc_grid_create( _width, _height ) {
	var _pointer	= { pointer : ds_grid_create( _width, _height ) };
	
	GarbageManager().add(
		_pointer,
		_pointer.pointer,
		function( _x ) { if ( ds_exists( _x, ds_type_priority ) ) ds_grid_destroy( _x ); }
	);
	return _pointer;
	
}
