// # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//								User-definable Macros
// # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// # The maximum number of gamepads that can be connected
#macro GAMEPAD_MAXIMUM_VIRTUAL_PORTS	4

// # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// #							End of User Defines
// # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#macro GamepadManager	__FAST_input_config__()

FAST.feature( "FINP", "Input Handling", (1 << 32 ) + ( 1 << 16 ) + 0, "11/22/2021" );

/// @func NoGamepadVirtualPortAvailable
/// @desc	Thrown when a gamepad is requested but no virtual ports are available.
/// @wiki Core-Index Errors
function NoGamepadVirtualPortAvailable( _type ) : __Error__() constructor {
	message	= _type + " could not be created, there are no virtual ports available."
}

/// @func __FAST_input_config__
function __FAST_input_config__() {
	static instance	= new ( function() constructor {
		static __logger__	= new Logger( "GamepadManager", SystemOutput );
		static log	= method( __logger__, __logger__.write );
		
		static ports	= new ( function( _max ) constructor {
			/// @desc	Return if a gamepad is connected to the given port.
			static is_connected	= function( _port = 0 ) {
				return get_gamepad( _port ) != noone;
				
			}
			/// @desc Return the gamepad connected to the given port, or noone.
			static get_gamepad	= function( _port = 0 ) {
				if ( is_numeric( _port ) == false )
					throw new InvalidArgumentType( "GamepadManager.port.is_connected", 0, _port, "number" );
				if ( _port < 0 || _port >= GAMEPAD_MAXIMUM_VIRTUAL_PORTS)
					throw new IndexOutOfBounds( "GamepadManager.port.is_connected", 0, GAMEPAD_MAXIMUM_VIRTUAL_PORTS);
				
				return __Ports[ _port ];
				
			}
			/// @desc	Return the number of gamepads currently connected.
			static connected	= function() {
				var _c = 0, _i = 0; repeat( GAMEPAD_MAXIMUM_VIRTUAL_PORTS) {
					if ( is_connected( _i++ )) { ++_c; }
					
				}
				return _c;
				
			}
			/// @desc	Returns the first empty port
			static find_empty_port	= function() {
				var _i = -1; repeat( GAMEPAD_MAXIMUM_VIRTUAL_PORTS) { ++_i;
					if ( not is_connected( _i )) { return _i }
					
				}
				return -1;
				
			}
			static connect_gamepad_to_port	= function( _pad, _port = -1 ) {
				if ( ( is_struct( _pad ) && struct_type( _pad, __Gamepad__ )) == false )
					throw new InvalidArgumentType( "GamepadManager.ports.connect_gamepad_to_port", 0, _pad, "__Gamepad__" );
				if ( is_numeric( _port ) == false )
					throw new InvalidArgumentType( "GamepadManager.port.is_connected", 0, _port, "number" );
				
				if ( _port == -1 )
					_port	= find_empty_port();
				
				if ( _port < 0 || _port >= GAMEPAD_MAXIMUM_VIRTUAL_PORTS)
					throw new IndexOutOfBounds( "GamepadManager.port.is_connected", 0, GAMEPAD_MAXIMUM_VIRTUAL_PORTS);
				
				__Ports[ _port ]	= _pad;
				
				return _port;
				
			}
			static disconnect_gamepad_from_port	= function( _port ) {
				if ( is_numeric( _port ) == false )
					throw new InvalidArgumentType( "GamepadManager.port.is_connected", 0, _port, "number" );
				if ( _port < 0 || _port >= GAMEPAD_MAXIMUM_VIRTUAL_PORTS)
					throw new IndexOutOfBounds( "GamepadManager.port.is_connected", 0, GAMEPAD_MAXIMUM_VIRTUAL_PORTS);
				
				var _pad	= __Ports[ _port ];
				
				__Ports[ _port ]	= noone;
				
				return _pad;
				
			}
			static toString	= function() {
				var _string	= "", _i = -1; repeat( GAMEPAD_MAXIMUM_VIRTUAL_PORTS ) { ++_i;
					if ( __Ports[ _i ] == noone )
						_string	+= string_formatted( "Port {}: <empty>\n", _i );
					else
						_string	+= string_formatted( "Port {}: Connected to {}\n", _i, __Ports[ _i ].padIndex );
					
				}
				return _string;
				
			}
			__Ports	= array_create( GAMEPAD_MAXIMUM_VIRTUAL_PORTS, noone );
			
		})();
		/// @desc Return the number of gamepads currently connected
		static connected	= function() {
			return ports.connected();
			
		}
		/// @desc Request an available pad.
		static get_pad	= function() {
			if ( ds_queue_size( padQueue ) == 0 ) {
				return - 1;
				
			}
			var _pad	= ds_queue_dequeue( padQueue );
			
			array_push( usedPads, _pad );
			
			return _pad;
			
		}
		/// @desc Generates an event to look for all connected gamepads.
		static poll_connected_gamepads	= function( _wait = 0 ) {
			if ( pollEvent != undefined )
				return;
			pollEvent	= new FrameEvent( FAST.STEP_BEGIN, _wait, function() {
				var _i = 0; repeat ( gamepad_get_device_count()) {
					if ( gamepad_is_connected( _i ) ) {
						publisher.channel_notify( "gamepad discovered", _i );
					
					}
					++_i;
				
				}
				log( ds_queue_size( padQueue ), " devices available." );
				
				pollEvent	= undefined;
				
			}).once();
			
		}
		static toString	= function() {
			return string( FAST.features[$ "FINP" ]) + "\n" + string( ports );
			
		}
		publisher	= new Publisher( "gamepad lost", "gamepad discovered" );
		
		publisher.subscriber_add( "gamepad discovered", function( _pad ) {
			if ( error_type( array_simple_search( usedPads, _pad )) != ValueNotFound )
				return;
			
			var _lost	= array_simple_search( lostPads, _pad, function( _a, _b ) { return _a[ 1 ] == _b; });
			// if this was a pad that went missing, try to find its original owner
			if ( error_type( _lost ) != ValueNotFound ) {
				// the gamepad is still missing its pad, connect it
				if ( lostPads[ _lost ][ 0 ].padIndex == -1 ) {
					log( "Gamepad in port ", lostPads[ _lost ][ 0 ].port, " recovered device." );
					
					lostPads[ _lost ][ 0 ].padIndex = _pad;
					
					array_push( usedPads, _pad );
					
					return;
					
				}
				// otherwise, this lost pad is a lost cause, throw it away and continue
				array_delete( lostPads, _lost, 1 );
				
			}
			// search for a gamepad wanting a controller
			var _i = 0; repeat( GAMEPAD_MAXIMUM_VIRTUAL_PORTS ) {
				var _gp	= ports.get_gamepad( _i++ );
				// gamepad exists and has no pad, connect it
				if ( _gp != noone && _gp.padIndex == -1 ) {
					log( "Gamepad in port ", _gp.port, " got device ", _pad ,"." );
					
					_gp.padIndex	= _pad;
					
					array_push( usedPads, _pad );
					
					return;
					
				}
				
			}
			// nothing found, store the pad
			repeat( ds_queue_size( padQueue ) ) {
				var _check	= ds_queue_dequeue( padQueue );
				
				if ( _pad != _check ) {
					ds_queue_enqueue( padQueue, _check );
					
				}
				
			}
			var _lost	= array_simple_search( usedPads, _pad );
			
			if ( _lost > -1 ) {
				array_delete( usedPads, _lost, 1 );
				
			}
			ds_queue_enqueue( padQueue, _pad );
			
			log( "Device ", _pad, " discovered." );
			
		});
		publisher.subscriber_add( "gamepad lost", function( _pad ) {
			repeat( ds_queue_size( padQueue ) ) {
				var _check	= ds_queue_dequeue( padQueue );
				
				if ( _pad != _check ) {
					ds_queue_enqueue( padQueue, _check );
					
				}
				
			}
			var _lost	= array_simple_search( usedPads, _pad );
			
			if ( _lost > -1 ) {
				array_delete( usedPads, _lost, 1 );
				
			}
			var _i = 0; repeat( GAMEPAD_MAXIMUM_VIRTUAL_PORTS ) {
				var _gp	= ports.get_gamepad( _i );
				
				if ( _gp != noone && _gp.padIndex == _pad ) {
					log( "Gamepad in port ", _gp.port, " lost device ", _gp.padIndex, "." );
					
					array_push( lostPads, [ _gp, _pad ] ); // push it to the lost pads
					
					_gp.padIndex	= -1;
					
					return;
					
				}
				
			}
			
		});
		padQueue	= ds_queue_create();
		lostPads	= [];
		usedPads	= [];
		pollEvent	= undefined;
		
		var _event	= new FrameEvent( FAST.ASYNC_SYSTEM, 0, function() {
			switch ( async_load[? "event_type" ] ) {
				case "gamepad discovered" : case "gamepad lost" :
					publisher.channel_notify( async_load[? "event_type" ], async_load[? "pad_index" ] );
					
					break;
				
			}
			
		});
		
	})();
	
	return instance;
	
}
