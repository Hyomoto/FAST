/// @param {real} _x
/// @param {real} _y
/// @param {real} _width
/// @param {real} _height
/// @param {Asset.GMSprite} _sprite
/// @param {real} _index
/// @param {function,array} _callback
function UISpriteStretched( _x, _y, _width, _height, _sprite, _index = 0, _callback = undefined ) : UISprite( _x, _y, _sprite, _index, _callback ) constructor {
	static isInside	= function( _x, _y ) {
		if ( sprite == -1 ) 
			return false;
		return point_in_rectangle( _x - x, _y - y,
			0,
			0,
			width - 1,
			height- 1
		);
		
	}
	static draw	= function( _x = 0, _y = 0 ) {
		if ( sprite == -1 )
			return;
		
		if ( animate ) {
			index	+= ( get_timer() - start ) / 1_000_000 * sprite_get_speed( sprite );
			start	= get_timer();
			
		}
		if ( beforeDraw != undefined ) method_call( beforeDraw[ 0 ], beforeDraw, 1 );
		draw_sprite_stretched_ext( sprite, index, x + _x, y + _y, width, height, color, 1.0 );
		if ( afterDraw != undefined ) method_call( afterDraw[ 0 ], afterDraw, 1 );
		
	}
	static style	= function( _animate = animate, _color = color ) {
		animate	= _animate;
		color	= _color;
		return self;
		
	}
	width	= _width;
	height	= _height;
	
}
