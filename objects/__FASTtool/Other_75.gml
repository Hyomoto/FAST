switch ( async_load[? "event_type" ] ) {
	case "gamepad discovered" : case "gamepad lost" :
		observer_notify( async_load[? "event_type" ], async_load[? "pad_index" ] );
		
		break;
		
}
