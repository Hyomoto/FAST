var _i = 0; repeat( ds_list_size( objects ) ) {
	if ( instance_exists( _id ) ) {
		_id	= objects[| _i++ ].target.visible	= true;
		
	}
	
}
ds_list_destroy( objects );
surface.free();
