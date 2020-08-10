/// @func PublisherManager
function PublisherManager(){
	static manager	= function() constructor {
		static channel_find	= function( _channel, _create ) {
			var _result	= ds_map_find_value( channels, _channel );
			
			if ( is_undefined( _result ) && ( _create == undefined || _create == true ) ) {
				_result	= new Publisher();
				
				ds_map_add( channels, _channel, _result );
				
			}
			return _result;
			
		}
		static listener_add	= function( _id, _channel, _function ) {
			_channel	= channel_find( _channel );
			
			if ( _channel.find( _id ) == undefined ) {
				var _link	= _channel.subscribe( _id, _function );
				
			}
			
		}
		static listener_remove	= function( _id, _channel ) {
			_channel	= channel_find( _channel, false );
			
			if ( _channel == undefined ) { return; }
			
			_channel.unsubscribe( _id );
			
		}
		static listener_notify	= function( _channel, _message ) {
			_channel	= channel_find( _channel, false );
			
			if ( _channel == undefined ) { return; }
			
			_channel.notify( _message );
			
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
		
	}
	static instance	= new Feature( "FAST Observer", "1.1", "07/10/2020", new manager() );
	
	return instance.struct;
	
}
