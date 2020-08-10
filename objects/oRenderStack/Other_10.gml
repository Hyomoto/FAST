switch ( method_called ) {
	case "render-remove" :
		ds_list_delete_value( __renderObjects, method_params );
		
		if ( ERROR_LEVEL >= ERROR_DEBUG ) {
			logID( method_params, "was removed from render ", __debug_id( id ) ) }
		
		break;
		
	case "render-add" :
		var _id	= method_params | ( method_params.persistent ? RFLAG.PERSIST : 0 );
		
		ds_list_add( __renderObjects, _id );
		
		with ( _id ) {
			if ( !component_validate( CRENDERABLE ) ) {
				if ( ERROR_LEVEL >= ERROR_NONFATAL ) {
					logEvent( other.id, "render-add", __debug_id( id ), "is not cRenderable!" ); }
			
				exit;
			
			}
			renderId	= other.id;
			
		}
		if ( ERROR_LEVEL >= ERROR_DEBUG ) {
			logID( _id, "was added to render ", __debug_id( id ) ) }
		
		break;
		
	default : event_inherited();
	
}
