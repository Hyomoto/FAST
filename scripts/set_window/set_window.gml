/// @param {Real} _width	The base horizontal resolution.
/// @param {Real} _height	The base vertical resolution.
/// @param {Real} _value	How much of the monitor the window should attempt to use.
/// @param {Bool} _upscale	Whether or not to upscale the application surface to the window size.  If false, uses the base resolution instead.
/// @returns {Real}	The window scale value.
/// @desc	Scale the game window to the closest pixel-perfect size based on the target resolution and the display resolution.
function set_window( _width, _height, _value = 0.8, _upscale = true ) {
	var _dw	= (display_get_width() * _value) / _width;
	var _dh	= (display_get_height()* _value) / _height;
	var _scale	= max( 1, ( display_get_width() > display_get_height() ? _dh : _dw ));
	// slice off the remainder
	_scale	-= _scale % 1;
	
	var _ww	= _width * _scale;
	var _wh	= _height* _scale;
	var _wx	= ( display_get_width() - _ww ) div 2;
	var _wy	= ( display_get_height()- _wh ) div 2;
	
	window_set_rectangle( _wx, _wy, _ww, _wh );
	
	return set_resolution( _width, _height, _ww, _wh,,, _upscale );
	
}
