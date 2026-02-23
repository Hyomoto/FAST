/// @param {Struct.Gamepad} _source
/// @param {Constant.GamepadAxis} _haxis
/// @param {Constant.GamepadAxis} _vaxis
function GamepadDualAxis( _source, _haxis, _vaxis, _threshold = 0.1 ) constructor {
    var _make_axis = function( _direction ) {
        static targets = {"left" : 0, "right" : 1, "up" : 2, "down" : 3}
        var _binding = { "lf" : last_frame, "tf" : this_frame, "dir" : targets[_direction] }
        return {
            "pressed"  : method(_binding, function() { return !lf[dir] && tf[dir]; }),
            "released" : method(_binding, function() { return lf[dir] && !tf[dir]; }),
            "held"     : method(_binding, function() { return tf[dir]; })
        }
    }
	static horizontal	= function() {
		return gamepad_axis_value( source.pad, haxis );
		
	}
	static vertical = function() {
		return gamepad_axis_value( source.pad, vaxis );
		
	}
    static value = function() {
        return point_distance(0, 0, horizontal(), vertical());
        
    }
    static angle = function() {
        return point_direction(0, 0, horizontal(), vertical());
        
    }
	static left	   = _make_axis( "left");
	static right   = _make_axis( "right" );
	static up      = _make_axis( "up" );
	static down    = _make_axis( "down" );
	
    static update = function() {
        var _h = horizontal();
        var _v = vertical();
        
        last_frame[0] = this_frame[0];
        last_frame[1] = this_frame[1];
        last_frame[2] = this_frame[2];
        last_frame[3] = this_frame[3];
        this_frame[0] = _h < -threshold_h;
        this_frame[1] = _h > threshold_h;
        this_frame[2] = _v < -threshold_v;
        this_frame[3] = _v > threshold_v;
        
    }
	haxis	= _haxis;
	vaxis	= _vaxis;
	source	= _source;
    if is_array( _threshold ) and array_length( _threshold ) < 2
        _threshold = [_threshold]; // if a single value is provided, use it for both axis'
    threshold_h = is_array( _threshold ) ? _threshold[ 0 ] : _threshold;
    threshold_v = is_array( _threshold ) ? _threshold[ 1 ] : _threshold;
	last_frame = [0, 0, 0, 0];
    this_frame = [0, 0, 0, 0];
    
}
