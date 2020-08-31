// # oRenderStack v2.1b by Hyomoto
//	provides basic draw-order handling
// return the width of the provided surface
ro		= function( _id ) constructor {
	target	= _id;
	
}
width	= function() {
	return surface.width;
	
}
height	= function() {
	return surface.height;
	
}
add		= function( _id ) {
	ds_list_add( objects, new ro( _id ) );
	
	_id.visible	= false;
	
}
remove	= function( _id ) {
	var _i = 0; repeat( ds_list_size( objects ) ) {
		if ( objects[| _i++ ].target == _id ) {
			ds_list_delete( objects, --_i );
			
			_id.visible	= true;
			
			break;
			
		}
		
	}
	
}
size	= function( _x, _y, _w, _h ) {
	surface.resize( _w, _h );
	
	x	= _x;
	y	= _y;
	
	return id;
	
}
// when cleanup is true, also removes children
destroy	= function( _cleanup ) {
	_cleanup	= ( _cleanup == undefined ? false : _cleanup );
	
	if ( _cleanup ) {
		var _i = 0; repeat( ds_list_size( objects ) ) {
			objects[| _i++ ].destroy();
			
		}
		
	}
	
}
surface		= new Surface( 0, 0 );
objects		= ds_list_create();
