if ( RenderManager().instance != noone ) {
	instance_destroy();
	
	exit;
	
}
RenderManager().instance	= id;

application_surface_draw_enable( false );

if ( RenderManager().bUseViews ) {
	var _event	= event_create( FAST.ROOM_START, 0, undefined, function() {
		RenderManager().set_resolution( view_wport[ 0 ], view_hport[ 0 ] );
		
	}, true );
	var _event	= new FAST_Event( FAST.ROOM_START, 0, undefined, function() {
		view_enabled		= true;
		view_visible[ 0 ]	= true;
		//view_wport[ 0 ]		= RenderManager().render_width;
		//view_hport[ 0 ]		= RenderManager().render_height;
		
		camera_set_view_size( view_camera[ 0 ], RenderManager().render_width, RenderManager().render_height );
		
	});
	
}