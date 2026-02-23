/// @desc Manages "channels" that can be listened to and notified.
function Publisher() constructor {
	/// @param {string} _channel
	/// @param {function} _callback
	/// @desc Hooks the provided callback into the specified channel.
	static listen	= function( _channel, _callback ) {
		if ( channels[$ _channel ] == undefined )
			channels[$ _channel ]	= [];
		array_push( channels[$ _channel ], _callback );
		return _callback;
		
	}
	/// @param {string} _channel
	/// @param {function} _callback
	/// @desc Removes the specified callback from the specified channel.
	static ignore	= function( _channel, _callback ) {
		if ( channels[$ _channel ] == undefined )
			return;
		channels[$ _channel ]	= array_filter( channels[$ _channel ], method({ "key" : _callback }, function( _v ) {
			return _v != key;
			
		}));
		
	}
	/// @param {string} _channel
	/// @param {any} _message
	/// @desc	Notifies the listeners in the specified channel and passes
	///		the provided message as arguments.
	static notify	= function( _channel, _message ) {
		array_foreach( channels[$ _channel ] ?? [], method({ "msg" : (is_array( _message ) ? _message : [ _message ] )}, function( _v ) {
			method_call( _v, msg );
			
		}));
		
	}
	channels	= {};
	
}
