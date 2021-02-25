/// @func gc_grid_create
/// @param {int}	width	The width of the grid.
/// @param {int}	height	The height of the grid.
/// @desc	Creates a new grid with the given dimensions and returns a struct containing it.  If this
//		struct is lost, the data structure will be cleaned up also.
function gc_grid_create( _width, _height ) {
	return new GarbageCollector( ds_grid_create( _width, _height ), function( _i ) {
		if ( not ds_exists( _i, ds_type_grid ) ) { return; }
		
		ds_grid_destroy( _i )
		
	});
	
}
