/// @func publisher_broadcast
/// @param channel
/// @param message
/// @wiki Publisher-Index
function publisher_broadcast( _channel, _message ) {
	static instance	= PublisherManager();
	
	instance.channel_notify( _channel, _message );
	
}
