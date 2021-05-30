/// @func PublisherChannel
/// @desc	A simple publisher-subscriber framework. Methods are bound to the PublisherChannel, and called
//		with the supplied parameters when a channel is notified they belong to.  These methods are
//		called at the scope they are bound, which means they are run as if they were a part of the
//		subscribing instance.  Thus any number of instances can subscribe to a single PublisherChannel,
//		or even the same one multiple times if desired.
/// @example
//var _channel	= new PublisherChannel()
//
//_channel.add( function( _message ) {
//  show_debug_message( _message );
//}
//_channel.notify( "Hello World!" );
/// @wiki Core-Index Publisher
function PublisherChannel() constructor {
	/// @param {func} method The method to add to the list.
	/// @desc Adds the specified method to the list of listeners.  If the provided argument was not
	///		a method, InvalidArgumentType will be thrown.
	/// @returns method
	/// @throws InvalidArgumentType
	static add	= function( _func ) {
		if ( is_method( _func ) == false ) { throw new InvalidArgumentType( "push", 0, _func, "method" ); }
		
		array_push( __Subscribers, _func );
		
		return _func;
		
	}
	/// @param {method}	method	The method to remove fromt he list.
	/// @desc	Removes the specified listener from the channel.
	static remove	= function( _func ) {
		var _i = 0; repeat( array_length( __Subscribers ) ) {
			if ( __Subscribers[ _i ] == _func ) {
				array_delete( __Subscribers, _i, 1 );
				break;
			}
			++_i;
		}
		
	}
	/// @param {mixed}	message	The message to pass to the subscribers.
	/// @desc	Calls each of the subscriber methods with `message` as an argument.
	static notify	= function( _message ) {
		var _i = 0; repeat( size() ) {
			__Subscribers[ _i++ ]( _message );
			
		}
		
	}
	/// @desc	Returns the number of subscribers in the channel
	static size	= function() {
		return array_length( __Subscribers );
		
	}
	__Subscribers	= [];
	
}
