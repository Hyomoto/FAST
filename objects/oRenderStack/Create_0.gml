// # oRenderStack v2.1b by Hyomoto
//	provides basic draw-order handling
// return the width of the provided surface
ro		= function( _id ) constructor {
	static event	= function() {
		with ( target ) { include( object_index ); }
		
	}
	static destroy	= function() {
		with ( target ) { instance_destroy(); }
		
	}
	sort	= _id.depth;
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
resize	= function( _width, _height ) {
	surface.width	= _width;
	surface.height	= _height;
	
}
position= function( _x, _y ) {
	x	= _x;
	y	= _y;
	
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
