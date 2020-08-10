if ( !view_enabled ) {
	view_enabled	= true;
	view_visible[ 0 ]	= true;
	view_wport[ 0 ]	= RenderManager().window_width;
	view_hport[ 0 ]	= RenderManager().window_height;
	
	camera_set_view_size( view_camera[ 0 ], RenderManager().render_width, RenderManager().render_height );
	
} else {
	RenderManager().set_resolution( camera_get_view_width( view_camera[ 0 ] ), camera_get_view_height( view_camera[ 0 ] ) );
	RenderManager().set_window( view_wport[ 0 ], view_hport[ 0 ] );
	
}
