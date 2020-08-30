switch ( async_load[? "event_type" ] ) {
	case "gamepad discovered" : case "gamepad lost" :
		publisher_broadcast( async_load[? "event_type" ], async_load[? "pad_index" ] );
		
		break;
		
}
