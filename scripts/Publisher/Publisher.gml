/// @func Publisher
/// @wiki Publisher-Index
function Publisher() constructor {
	static channel_notify	= function( _channel, _message ) {
		_channel	= ds_map_find_value( channels, _channel );
		
		if ( _channel == undefined ) { return; }
		
		var _next = undefined;
		
		while ( _channel.has_next( _next ) ) {
			_next	= _channel.next( _next );
			
		}
		
	}
	static channel_add	= function( _channel ) {
		if ( ds_map_find_value( channels, _channel ) == undefined ) {
			ds_map_add( channels, _channel, new PublisherChannel() );
			
		}
		
	}
	static channel_remove	= function( _channel ) {
		if ( ds_map_find_value( channels, _channel ) != undefined ) {
			ds_map_delete( channels, _channel );
			
		}
		
	}
	static subscriber_add	= function( _channel, _function ) {
		_channel	= ds_map_find_value( channels, _channel );
		
		if ( _channel != undefined ) {
			return _channel.add( _function );
			
		}
		
	}
	static subscriber_remove	= function( _channel, _subscriber ) {
		_channel	= ds_map_find_value( channels, _channel );
		
		if ( _channel != undefined ) {
			var _seek	= _channel.find( _subscriber );
			
			if ( _seek != undefined ) {
				_channel.remove( _seek );
				
			}
			
		}
		
	}
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
		channel_add( argument[ _i ] );
		
	}
	
}