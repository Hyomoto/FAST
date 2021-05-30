if ( RenderManager().instance != noone ) {
	instance_destroy();
	
	exit;
	
}
/// @ignore
RenderManager().instance	= id;

application_surface_draw_enable( false );

if ( RenderManager().bUseViews ) {
	var _event	= new FrameEvent( FAST.ROOM_START, 0, undefined, function() {
		if ( RenderManager().render_width == undefined || RenderManager().render_height == undefined ) {
			RenderManager().set_resolution( view_get_wport( 0 ), view_get_hport( 0 ) );
			
		}
		
	}).once();
	
	var _event	= new FrameEvent( FAST.ROOM_START, 0, undefined, function() {
		view_enabled		= true;
		view_visible[ 0 ]	= true;
		view_set_wport( 0, RenderManager().render_width );
		view_set_hport( 0, RenderManager().render_width );
		
		camera_set_view_size( view_camera[ 0 ], RenderManager().render_width, RenderManager().render_height );
		
	});
	
}
