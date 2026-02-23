/// @param {real} _width		The base horizontal resolution
/// @param {real} _height		The base vertical resolution
/// @param {real} _targetWidth	The target horizontal resolution. Default is the display width.
/// @param {real} _targetHeight	The target vertical resolution. Default is the display height.
/// @param {real} _guiWidth		The GUI horizontal resolution. Default is base width.
/// @param {real} _guiHeight	the GUI vertical resolution. Default is base height.
/// @param {bool} _upscale		If true, resizes the application surface to the target resolution, otherwise resizes it to the base resolution
/// @returns {Real}	The scale value of the base resolution to match the target one.
/// @desc	Sets up the game resolution. Width and height are the base game resolution, while the target is the device display.  The GUI values are optional.  If used,
///		the GUI will be scaled to those values, otherwise they will atch the base resolution.  Lastly, upscale determines whether the application surface will match
///		the base resolution or the target resolution.  By default this is true.
function set_resolution( _width, _height, _targetWidth = display_get_width(), _targetHeight = display_get_height(), _guiWidth = undefined, _guiHeight = undefined, _upscale = true ) {
	var _dw	= _targetWidth / _width;
	var _dh	= _targetHeight/ _height;
	var _scale	= max( 1, ( _targetWidth > _targetHeight ? _dh : _dw ));
	
	var _ww	= _width * _scale;
	var _wh	= _height* _scale;
	
	display_set_gui_size( _guiWidth ?? _width, _guiHeight ?? _height );
	
	if ( _upscale ) surface_resize( application_surface, _ww, _wh );
	else			surface_resize( application_surface, _width, _height );
	
	return _scale;
	
}
