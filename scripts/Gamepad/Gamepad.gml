/// @func Gamepad
/// @wiki Input-Handling-Index Constructors
function Gamepad() : __Struct__() constructor {
	/// @var {array}	A list of all the reserved keywords for Gamepad.
	static __Reserved__	= [ "new_button", "new_axis", "set_deadzone", "__Reserved__", "__Type__", "__Pad__", "__Manager__" ];
	/// @param {string}	name		The name of the new input to bind to
	/// @param {int}	constant	The gamepad constant to bind
	/// @desc	Creates a new button input on the gamepad.  Each button can have one input bound
	///		to it.  If the name of the new keyword is reserved, ReservedKeyword will be thrown.
	/// @throws ReservedKeyword
	static new_button	= function( _name, _constant ) {
		if ( error_type( array_simple_search( __Reserved__, _name ) ) != ValueNotFound )
			throw new ReservedKeyword( "new_button", _name);
		
		variable_struct_set( self, _name, new ( function( _constant, _self ) constructor {
			static pressed	= function() { return gamepad_button_check_pressed( __Gamepad.__Pad__, __Constant ); }
			static check	= function() { return gamepad_button_check( __Gamepad.__Pad__, __Constant ); }
			static released	= function() { return gamepad_button_check_released( __Gamepad.__Pad__, __Constant ); }
			static state	= function() {
				if ( gamepad_button_check( __Gamepad.__Pad__, __Constant ) )
					__State	= __State == FAST_BUTTON_FREE ? FAST_BUTTON_PRESSED : FAST_BUTTON_CHECK;
				else
					__State = __State & FAST_BUTTON_CHECK ? FAST_BUTTON_RELEASED: FAST_BUTTON_FREE;
				return __State;
			}
			static bind	= function( _constant ) {
				__Constant	= _constant;
				
			}
			__Gamepad	= _self;
			__Constant	= _constant;
			__State		= FAST_BUTTON_FREE;
			
		})( _constant, self ));
		
	}
	/// @param {string}	name	The name of the new input to bind to
	/// @param {int}	haxis	The horizontal axis to bind, or `undefined`
	/// @param {int}	vaxis	The vertical axis to bind, or `undefined`
	/// @desc	Creates a new axis input on the gamepad.  Each axis can have two axis' bound to it
	///		but setting it to undefined will cause it to always return 0.  If the name of the new
	///		keyword is reserved, ReservedKeyword will be thrown.
	/// @throws ReservedKeyword
	static new_axis		= function( _name, _haxis, _vaxis ) {
		if ( error_type( array_simple_search( __Reserved__, _name ) ) != ValueNotFound )
			throw new ReservedKeyword( "new_axis", _name);
		
		variable_struct_set( self, _name, new ( function( _constant, _self ) constructor {
			static haxis	= function() { return __Haxis != undefined ? gamepad_axis_value( __Gamepad.__Pad__, _Haxis ) : 0; }
			static vaxis	= function() { return __Vaxis != undefined ? gamepad_axis_value( __Gamepad.__Pad__, _Vaxis ) : 0; }
			static state	= function() {
				var _haxis	= haxis();
				var _vaxis	= vaxis();
				
				__State.direction	= point_direction( 0, 0, _haxis, _vaxis );
				__State.magnitude	= min( 1.0, sqrt( _haxis * _haxis + _vaxis * _vaxis ) );
				
				return __State;
				
			}
			static bind	= function( _haxis, _vaxis ) {
				__Haxis		= _haxis;
				__Vaxis		= _vaxis;
				
			}
			__Gamepad	= _self;
			__Haxis		= _haxis;
			__Vaxis		= _vaxis;
			__State		= {direction: 0, magnitude: 0 };
			
		})( _constant, self ));
		
	}
	static set_deadzone	= function( _amount ) {
		_amount	= clamp( _amount, 0.0, 1.0 );
		
		gamepad_set_axis_deadzone( padIndex, _amount );
		
	}
	static __Manager__	= ( function() {
		if ( FAST_DISABLE_EVENTS ) { return undefined; }
		
		var _manager	= new ( function() {
			__Ports	= array_create( FAST_GAMEPAD_VIRTUAL_PORTS );
			 var _i = 0; repeat( FAST_GAMEPAD_VIRTUAL_PORTS ) { __Ports[ _i++ ] = {
				 input: noone,
				 output: noone
			 }};
			 
		})();
		
		var _event	= new FrameEvent( FAST_EVENT_STEP, 0, function( _list ) {
			syslog( "Logger :: Closing all opened loggers..." );
			
			var _i	= 0; repeat( ds_list_size( _list ) ) {
				var _target	= ds_list_find_value( _list, 0 );
				
				try {
					_target.close();
				
				} catch ( _ ) {
					syslog( new LoggerError().from_error( _ ) );
					
				}
				
			}
			ds_list_destroy( _list );
			
		}).once().parameter( _manager );
		
		return self;
		
	})();
	//__Manager__
	/// @desc The port this gamepad is plugged into. You can get the port number via port.portId if this gamepad is plugged into a port.
	//port		= GamepadManager().get_port( self );
	/// @desc The pad index this Gamepad is used.
	//padIndex	= -1;
	
	//if ( port == undefined ) {
	//	GamepadManager().log( "Gamepad could not be connected, no virtual ports available." );
		
	//}
	__Type__.add( Gamepad );
	
}
