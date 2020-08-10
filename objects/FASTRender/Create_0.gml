if ( RenderManager().instance != noone ) {
	instance_destroy();
	
	exit;
	
}
RenderManager().instance	= id;

application_surface_draw_enable( false );

//surface_resize( application_surface, Render.render_width, Render.render_height );
