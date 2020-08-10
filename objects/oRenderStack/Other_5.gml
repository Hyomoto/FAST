var _id;

if ( persistent ) {
	for ( var _i = 0; _i < ds_list_size( __renderObjects ); _i++ ) {
		_id	= __renderObjects[| _i ];
		
		if ( !instance_exists( _id ) || _id & RFLAG.PERSIST == 0 ) { ds_list_delete( __renderObjects, _i-- ) }
		
	}
	
}
