/// @func gc_grid_create
/// @param {int}	width	The width of the grid.
/// @param {int}	height	The height of the grid.
/// @desc	Creates a new grid with the given dimensions and returns a struct containing it.  If this
//		struct is lost, the data structure will be cleaned up also.
function gc_grid_create( _width, _height ) {
	var _list	= { pointer : ds_grid_create( _width, _height ) };
	
	GarbageManager().add( {
		ref : weak_ref_create( _list ),
		pointer : _list.pointer,
		destroy : function() { ds_grid_destroy( pointer ); }
	});
	return _list;
	
}
