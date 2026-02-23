/// @param {Struct.Gamepad} _source
/// @param {Constant.GamepadButton} _button
function GamepadButton( _source, _button ) constructor {
	static pressed	= function() {
		return gamepad_button_check_pressed( source.pad, button );
		
	}
	static released	= function() {
		return gamepad_button_check_released( source.pad, button );
		
	}
	static held	= function() {
		return gamepad_button_check( source.pad, button );
		
	}
	button	= _button;
	source	= _source;
	
}
