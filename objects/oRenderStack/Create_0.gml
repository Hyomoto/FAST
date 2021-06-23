// # oRenderStack v2.1b by Hyomoto
//	provides basic draw-order handling
/// @desc returns the width of the render surface
width	= function() {
	return surface.width;
	
}
/// @desc returns the height of the render surface
height	= function() {
	return surface.height;
	
}
/// @params {int}	ids...	Adds the instance ids to this render.
attach	= function( _id ) {
	ds_list_add( objects, _id );
	
	_id.visible	= false;
	
}
remove	= function( _id ) {
	var _i = 0; repeat( ds_list_size( objects ) ) {
		if ( objects[| _i++ ] == _id ) {
			ds_list_delete( objects, --_i );
			
			_id.visible	= true;
			
			break;
			
		}
		
	}
	
}
resize	= function( _x, _y, _w, _h ) {
	surface.resize( _w, _h );
	
	x	= _x;
	y	= _y;
	
	return id;
	
}
surface		= new Surface( 0, 0, true );
objects		= ds_list_create();
