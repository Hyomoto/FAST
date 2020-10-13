/// @func publisher_subscribe
/// @param channel
/// @param function
/// @wiki Publisher-Index
function publisher_subscribe( _channel, _function ) {
	static instance	= PublisherManager();
	
	instance.listener_add( self, _channel, _function );
	
}
