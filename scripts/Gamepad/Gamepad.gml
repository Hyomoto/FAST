/// @func Gamepad
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
		static raw		= function() {
			return false;
			
		}
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
	dpad_left	= new input( gp_padl, self );
	dpad_right	= new input( gp_padr, self );
	dpad_up		= new input( gp_padu, self );
	dpad_down	= new input( gp_padd, self );
	
	face_1		= new input( gp_face1, self );
	face_2		= new input( gp_face2, self );
	face_3		= new input( gp_face3, self );
	face_4		= new input( gp_face4, self );
	
	rbutton		= new input( gp_shoulderr, self );
	lbutton		= new input( gp_shoulderl, self );
	rstick		= new input( gp_stickr, self );
	lstick		= new input( gp_stickl, self );
	select		= new input( gp_select, self );
	start		= new input( gp_start, self );
	
	rtrigger	= new input( gp_shoulderrb, self );
	ltrigger	= new input( gp_shoulderlb, self );
	
	lstick		= new inputAxis( gp_axislh, gp_axislv, self );
	rstick		= new inputAxis( gp_axisrh, gp_axisrv, self );
	
	port		= GamepadInit().get_port( self );
	padIndex	= -1;
	
	if ( port == undefined ) {
		log_notify( undefined, "Gamepad", "No virtual ports available." );
		
	}
	
}
