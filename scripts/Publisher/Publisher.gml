/// @func Publisher
function Publisher() {
	static channel_notify	= function( _channel, _message ) {
		
		
	}
	static channel_add	= function( _channel ) {
		if ( ds_map_find_value( _channel ) == undefined ) {
			ds_map_add( channels, _channel, new PublisherChannel() );
			
		}
		
	}
	static channel_remove	= function( _channel ) {
		if ( ds_map_find_value( _channel ) != undefined ) {
			ds_map_delete( channels, _channel );
			
		}
		
	}
	static subscriber_add	= function( _channel, _function ) {
		var _channel	= ds_map_find_value( channels, _channel );
		
		if ( _channel != undefined ) {
			_channel.add( _subscriber );
			
		}
		
	}
	static subscriber_remove	= function( _channel, _subscriber ) {
		var _channel	= ds_map_find_value( channels, _channel );
		
		if ( _channel != undefined ) {
			var _seek	= _channel.find( _subscriber );
			
			if ( _seek != undefined ) {
				_channel.remove( _seek );
				
			}
			
		}
		
	}
	//static channel_find	= function( _channel, _create ) {
	//	var _result	= ds_map_find_value( channels, _channel );
			
	//	if ( is_undefined( _result ) && ( _create == undefined || _create == true ) ) {
	//		_result	= new Publisher();
				
	//		ds_map_add( channels, _channel, _result );
				
	//	}
	//	return _result;
		
	//}
	//static listener_add	= function( _id, _channel, _function ) {
	//	_channel	= channel_find( _channel );
			
	//	if ( _channel.find( _id ) == undefined ) {
	//		var _link	= _channel.subscribe( _id, _function );
				
	//	}
			
	//}
	//static listener_remove	= function( _id, _channel ) {
	//	_channel	= channel_find( _channel, false );
			
	//	if ( _channel == undefined ) { return; }
			
	//	_channel.unsubscribe( _id );
			
	//}
	//static listener_notify	= function( _channel, _message ) {
	//	_channel	= channel_find( _channel, false );
			
	//	if ( _channel == undefined ) { return; }
			
	//	_channel.notify( _message );
			
	//}
	static toString	= function() {
		var _next	= ds_map_find_first( channels );
		var _string	= "";
			
		while ( _next != undefined ) {
			if ( _string != "" ) {
				_string	+= ", ";
					
			}
			_string	+= _next + "(" + string( channels[? _next ].size ) + ")";
				
			_next	= ds_map_find_next( channels, _next );
				
		}
		return _string;
			
	}
	channels	= ds_map_create();
	
	var _i = 0; repeat( argument_count ) {
		
		
	}
	
}