/// @func Gamepad
/// @wiki Input-Handling-Index
function Gamepad() constructor {
	static input	= function( _constant, _gamepad ) constructor {
		static pressed		= function() {
			return gamepad_button_check_pressed( gamepad.padIndex, constant );
			
		}
		static held			= function() {
			return gamepad_button_check( gamepad.padIndex, constant );
			
		}
		// this is for compatibility with InputDevice
		static down			= held;
		static released		= function() {
			return gamepad_button_check_released( gamepad.padIndex, constant );
			
		}
		static magnitude	= function() {
			return gamepad_button_value( gamepad.padIndex, constant );
			
		}
		static toString	= function() {
			return string( constant ) + "(" + string( pressed() ) + ", " + string( magnitude() ) + ")";
			
		}
		constant	= _constant;
		gamepad		= _gamepad;
		event		= undefined;
		last		= false;
		
	}
	static inputAxis	= function( _axish, _axisv, _gamepad ) constructor {
		static degree	= function() {
			return point_direction( 0, 0, gamepad_axis_value( gamepad.padIndex, axish ), gamepad_axis_value( gamepad.padIndex, axisv ) );
			
		}
		static magnitude	= function() {
			return min( 1.0, sqrt( power( horizontal(), 2 ) + power( vertical(), 2 ) ) );
			
		}
		static horizontal	= function() {
			return gamepad_axis_value( gamepad.padIndex, axish );
			
		}
		static vertical	= function() {
			return gamepad_axis_value( gamepad.padIndex, axisv );
			
		}
		static left		= function() {
			return gamepad_axis_value( gamepad.padIndex, axish ) <= -threshold;
			
		}
		static right	= function() {
			return gamepad_axis_value( gamepad.padIndex, axish ) >= threshold;
			
		}
		static up		= function() {
			return gamepad_axis_value( gamepad.padIndex, axisv ) <= -threshold;
			
		}
		static down		= function() {
			return gamepad_axis_value( gamepad.padIndex, axisv ) >= threshold;
			
		}
		static set_threshold= function( _amount ) {
			threshold	= clamp( _amount, 0.0, 1.0 );
			
		}
		static toString	= function() {
			return string( axish + axisv ) + "(" + string( degree() ) + ", " + string( magnitude() ) + ")"; //+ string( gamepad_axis_value( gamepad.padIndex, axish ) ) + ", " + string( gamepad_axis_value( gamepad.padIndex, axisv ) ) + ")";
			
		}
		axish		= _axish;
		axisv		= _axisv;
		threshold	= 0.50;
		gamepad		= _gamepad;
		last		= false;
		
	}
	static set_deadzone	= function( _amount ) {
		_amount	= clamp( _amount, 0.0, 1.0 );
		
		gamepad_set_axis_deadzone( padIndex, _amount );
		
	}
	port		= GamepadManager().get_port( self );
	padIndex	= -1;
	
	if ( port == undefined ) {
		log_notify( undefined, "Gamepad", "No virtual ports available." );
		
	}
	
}
