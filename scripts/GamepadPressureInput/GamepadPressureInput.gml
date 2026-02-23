/// @param {Struct.Gamepad} _source
/// @param {Constant.GamepadButton} _button
function GamepadPressureInput( _source, _button, _threshold = 0.4 ) constructor {
    static value = function() {
        return gamepad_button_value( source.pad, button );
        
    }
    static pressed  = function() {
        return !last_frame && this_frame;
        
    }
    static released  = function() {
        return last_frame && !this_frame;
        
    }
    static held  = function() {
        return this_frame;
        
    }
    static update = function() {
        last_frame = this_frame;
        this_frame = value() >= threshold;
        
    }
	button	= _button;
	source	= _source;
    threshold = _threshold;
	last_frame = false;
    this_frame = false;
    
}
