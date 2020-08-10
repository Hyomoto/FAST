/// @func draw_bar( sprite, index, x, y, width, percent )
/// @param sprite
/// @param index
/// @param x
/// @param y
/// @param width
/// @param percent
function draw_bar( _sprite, _index, _x, _y, _width, _percent ) {
	var _w	= ceil( _width * _percent );
	var _h	= sprite_get_height( _sprite );
	var _o	= sprite_get_width( _sprite );
	var _t	= ( _w < _o + 2 ? min( _o - 2, _o + 2 - _w ) : 0 );
	
	if ( _w < 2.0 ) { return; }
	if ( _w > 2.0 ) {
		draw_sprite_part( _sprite, _index, 0, 0, _o - _t, _h, _x, _y );
		
	}
	draw_sprite_part( _sprite, _index + 2, _t, 0, _o - _t, _h, _x + _w - ( _o - _t ), _y );
	
	var _gap	= max( 0, _w - _o * 2 ) / _o;
	if ( _gap > 0 ) {
		draw_sprite_ext( _sprite, _index + 1, _x + _o, _y, _gap, 1, 0, c_white, 1.0 );
		
	}
	
}
