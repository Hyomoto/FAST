if ( surface.update() ) {
	surface.set( true )
	
	var _i = 0; repeat( ds_list_size( objects ) ) {
		with( objects[| _i++ ] ) { event_perform( ev_draw, 0 ); }
		
	}
	surface.reset();
	
}
surface.draw( x, y );
