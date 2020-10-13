#macro GAMEPAD_MAXIMUM_VIRTUAL_PORTS	4
#macro Gamepads	GamepadManager()

/// @func GamepadManager
/// @wiki Input-Handling-Index
function GamepadManager() {
	static manager	= function() constructor {
		static log	= function() {
			static logger	= new Logger( "gamepad", FAST_LOGGER_DEFAULT_LENGTH, System );
			
			var _string	= "";
			
			var _i = 0; repeat( argument_count ) {
				_string	+= string( argument[ _i++ ] );
				
			}
			logger.write( _string );
			
		}
		
		static port	= function( _port ) constructor {
			static gain_pad	= function( _pad ) {
				if ( gamepad == undefined ) { return; }
				
				GamepadManager().log( undefined, "gain_pad", "Port ", portId, " got gamepad ", _pad );
				
				gamepad.padIndex	= _pad;
				padIndex	= _pad;
				lastIndex	= _pad;
				
			}
			static lose_pad	= function() {
				if ( padIndex == -1 ) { return; }
				
				GamepadManager().log( undefined, "lose_pad", "Port ", portId, " lost gamepad ", padIndex );
				
				gamepad.padIndex	= -1;
				padIndex			= -1;
				
			}
			static disconnect	= function() {
				gamepad		= undefined;
				
				lose_pad();
				
			}
			static toString	= function() {
				return "Connected: " + ( gamepad == undefined ? "false" : "true" ) + ", Pad: " + string( padIndex );
				
			}
			portId		= _port;
			gamepad		= undefined;
			lastIndex	= -1;
			padIndex	= -1;
			
		}
		static get_pad	= function() {
			if ( ds_queue_size( padQueue ) == 0 ) {
				return - 1;
				
			}
			return ds_queue_dequeue( padQueue );
			
		}
		static get_port	= function( _gamepad ) {
			var _i = 0; repeat( GAMEPAD_MAXIMUM_VIRTUAL_PORTS ) {
				var _port	= portList[ _i++ ];
				
				if ( _port.gamepad == undefined ) {
					_port.gamepad	= _gamepad;
					
					return _port;
					
				}
				
			}
			return undefined;
			
		}
		static get_gamepad	= function( _port ) {
			if ( _port < 0 || _port >= GAMEPAD_MAXIMUM_VIRTUAL_PORTS ) { return undefined; }
			
			return portList[ _port ].gamepad;
			
		}
		publisher	= new Publisher( "gamepad lost", "gamepad discovered" );
		
		publisher.subscriber_add( "gamepad discovered", function( _pad ) {
			var _i = 0; repeat( GAMEPAD_MAXIMUM_VIRTUAL_PORTS ) {
				var _port	= portList[ _i++ ];
				
				if ( _port.gamepad != undefined && _port.padIndex == -1 ) {
					_port.gain_pad( _pad );
					
					return;
					
				}
				
			}
			ds_queue_enqueue( _pad );
			
		});
		publisher.subscriber_add( "gamepad lost", function( _pad ) {
			var _i = 0; repeat( GAMEPAD_MAXIMUM_VIRTUAL_PORTS ) {
				var _port	= portList[ _i++ ];
				
				if ( _port.gamepad != undefined && _port.padIndex == _pad ) {
					_port.lose_pad();
					
					return;
					
				}
				
			}
			var _i = 0; repeat( ds_queue_size( padQueue ) ) {
				var _check	= ds_queue_dequeue( padQueue );
				
				if ( _pad != _check ) {
					ds_queue_enqueue( padQueue, _check );
					
				}
				
			}
			
		});
		padQueue	= ds_queue_create();
		portList	= array_create( GAMEPAD_MAXIMUM_VIRTUAL_PORTS );
		waiting		= 0;
		
		var _i = 0; repeat( GAMEPAD_MAXIMUM_VIRTUAL_PORTS ) {
			portList[ _i ]	= new port( _i );
			
			++_i;
			
		}
		var _event	= event_create( FAST.STEP_BEGIN, 0, undefined, function() {
			var _i = 0; repeat ( gamepad_get_device_count() ) {
				if ( gamepad_is_connected( _i ) ) {
					ds_queue_enqueue( padQueue, _i );
					
				}
				++_i;
				
			}
			var _i = 0; repeat( GAMEPAD_MAXIMUM_VIRTUAL_PORTS ) {
				var _pad	= get_pad();
				
				if ( _pad == -1 ) { break; }
				
				portList[ _i ].gain_pad( _pad );
				
				++_i;
				
			}
			
		}, true );
		
	}
	static instance	= new Feature( "FAST Gamepad", "1.0a", "10/10/2020", new manager() );
	return instance.struct;
	
}
