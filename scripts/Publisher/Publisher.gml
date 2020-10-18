/// @func Publisher
/// @param {string} channels...	optional: If provided, will create channels with the given names.
/// @desc	Publishers are message processing backends.  Methods are bound to the channels, and called
//		with the supplied parameters when a channel is notified they belong to.  These methods are
//		called at the scope they are bound, which means they are run as if they were a part of the
//		subscribing instance.  Thus a single instance can subscribe to multiple channels, or even
//		the same channel multiple times if desired.
/// @example
//var _achievement	= new Publisher()
//
//_publisher.subscriber_add( "kills", function( _number ) {
//  global.kills_progress	+= _number;
//
//  if ( global.kills_progress > 1000 ) {
//    steam_set_achievement("kills1000");
//  }
//});
//_achivement.channel_notify( "kills", 1 );
/// @wiki Core-Index Publisher
function Publisher() constructor {
	/// @param {string}	channel	The name of the channel to notify.
	/// @param {mixed}	message	The message to pass to the the subscriber methods.
	/// @desc The channel, if it exists, will call all of its subscriber functions with message as an argument.
	static channel_notify	= function( _channel, _message ) {
		_channel	= ds_map_find_value( channels, _channel );
		
		if ( _channel == undefined ) { return; }
		
		_channel.notify( _message );
		
	}
	/// @param {string}	channel	The name of the channel to create.
	/// @desc	Creates a new channel if it doesn't exist, and ignores this if it does.
	static channel_add	= function( _channel ) {
		if ( ds_map_find_value( channels, _channel ) == undefined ) {
			ds_map_add( channels, _channel, new PublisherChannel() );
			
		}
		
	}
	/// @param {string}	channel	The name of the channel to remove.
	/// @desc	Destroys a channel if it exists, and ignores this if it does not.
	static channel_remove	= function( _channel ) {
		if ( ds_map_find_value( channels, _channel ) != undefined ) {
			ds_map_delete( channels, _channel );
			
		}
		
	}
	/// @returns Subscriber
	/// @param {string}	channel	The channel to subscribe to.
	/// @param {func}	method	The method that will be called when this channel is alerted.
	/// @desc	Adds the given method to the specified channel.  If the channel doesn't exist, it will be
	//		created.
	static subscriber_add	= function( _channel, _function ) {
		_channel	= ds_map_find_value( channels, _channel );
		
		if ( _channel != undefined ) {
			return _channel.add( _function );
			
		}
		
	}
	/// @param {string}		channel		The channel to remove the subscriber from.
	/// @param {Subscriber}	subscriber	The subscriber to remove from the channel.
	/// @desc	Removes the given subscriber from the specified channel. The Subscriber is what is
	//		returned when the channel is subscribed to.
	//> Note: It is good practice to remove a subscriber when they are destroyed. Failure to do so could cause the program to crash unexpectedly.
	static subscriber_remove	= function( _channel, _subscriber ) {
		_channel	= ds_map_find_value( channels, _channel );
		
		if ( _channel != undefined ) {
			var _seek	= _channel.find( _subscriber );
			
			if ( _seek != undefined ) {
				_channel.remove( _seek );
				
			}
			
		}
		
	}
	/// @desc Cleans up the internal structures this Publisher can be safely garbage-collected.
	static destroy	= function() {
		ds_map_destroy( channels );
		
	}
	/// @desc Returns a string showing all the channels and their number of subscribers.  Used for debugging purposes.
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
	/// @desc	The internal map of channels.
	channels	= ds_map_create();
	
	var _i = 0; repeat( argument_count ) {
		channel_add( argument[ _i ] );
		
	}
	
}
