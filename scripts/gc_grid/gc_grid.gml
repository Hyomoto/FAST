/// @func gc_grid
/// @param {int}	width	The width of the grid.
/// @param {int}	height	The height of the grid.
function gc_grid( _width, _height ) {
	var _list	= { pointer : ds_grid_create( _width, _height ) };
	
	GarbageManager().add( {
		ref : weak_ref_create( _list ),
		pointer : _list.pointer,
		destroy : function() { ds_grid_destroy( pointer ); }
	});
	return _list;
	
}
