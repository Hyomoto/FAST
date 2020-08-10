/// @func draw_bubble
/// @param sprite
/// @param index
/// @param x
/// @param y
/// @param width
function draw_bubble( _sprite, _index, _x, _y, _width ) {
	var _sw		= sprite_get_width( _sprite );
	var _min	= _sw * 3;
	var _w		= max( _width, _min );
	var _sw1	= ceil( ( _w - _min ) / 2 );
	var _sw2	= floor(( _w - _min ) / 2 );
	var _sp1	= _sw1 / _sw;
	var _sp2	= _sw2 / _sw;
	
	_x	= _x - ceil( _w / 2 );
	_y	= _y - sprite_get_height( _sprite );
	
	draw_sprite( _sprite, _index, _x, _y );
	draw_sprite_ext( _sprite, _index + 1, _x + _sw, _y, _sp1, 1, 0, c_white, 1.0 );
	draw_sprite( _sprite, _index + 2, _x + _sw + _sw1, _y );
	draw_sprite_ext( _sprite, _index + 1, _x + _sw + _sw + _sw1, _y, _sp2, 1, 0, c_white, 1.0 );
	draw_sprite( _sprite, _index + 3, _x + _sw + _sw + _sw1 + _sw2, _y );
	
}
