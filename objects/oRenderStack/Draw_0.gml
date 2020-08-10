if ( surface.update() ) {
	surface.set()
	
	surface_set_target( __renderSurface );
		draw_clear_alpha( renderClearColor, renderClearAlpha );
		
		var _i = 0; repeat( ds_list_size( objects ) ) {
			objects[| _i++ ].draw();
			
		}
	
	surface.reset();
	
}
surface.draw( x, y );
