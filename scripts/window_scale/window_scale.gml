/** @desc	Scales the window to fill as close to value on the monitor as possible with the given dimensions.
 * @param {Real} _width
 * @param {Real} _height
 * @param {Real} _value
 * @returns {Real}	The window scale value.
*/
function window_scale( _width, _height, _value = 0.8 ) {
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
	
	surface_resize( application_surface, _ww, _wh );
	
	display_set_gui_size( _width, _height );
	
	return _scale;
	
}
