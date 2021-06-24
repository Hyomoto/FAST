/// @func angle_is_between
/// @param {float}	start	The first angle
/// @param {float}	end		The second angle
/// @param {float}	angle	The angle to check
/// @desc	Returns true if the angle is between start and end
/// @returns true
function angle_is_between( _a, _b, _angle ) {
	// swap a and b if a > b
	if ( _a > _b ) { var _h = _a; _a = _b; _b = _h; }
	
    _b = (_b - _a) < 0 ? _b - _a + 360 : _b - _a;    
    _angle = (_angle - _a) < 0 ? _angle - _a + 360 : _angle - _a;
	
    return (_angle < _b); 
	
}
