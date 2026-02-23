/// @param {real} _x
/// @param {real} _y
/// @param {Asset.GMSprite} _sprite
/// @param {real} _index
/// @param {function,array} _callback
function UISpritePart( _x, _y, _sprite, _index = 0, _left = 0, _top = 0, _width = undefined, _height = undefined, _callback = undefined ) : UIInteraction( _callback ) constructor {
	static isInside	= function( _x, _y ) {
		if ( sprite == -1 ) 
			return false;
		return point_in_rectangle( _x - x, _y - y,
			sprite_get_bbox_left( sprite ),
			sprite_get_bbox_top( sprite ),
			sprite_get_bbox_right( sprite ),
			sprite_get_bbox_bottom( sprite )
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
		draw_sprite_part_ext( sprite, index, left, top, width, height, x + _x - sprite_get_xoffset( sprite ), y + _y - sprite_get_yoffset( sprite ), 1.0, 1.0, color, 1.0 );
		if ( afterDraw != undefined ) method_call( afterDraw[ 0 ], afterDraw, 1 );
		
	}
	static style	= function( _animate = animate, _color = color, _scaleX = 1, _scaleY = 1 ) {
		animate	= _animate;
		color	= _color;
		width	= _scaleX;
		height	= _scaleY;
		return self;
		
	}
	static reset	= function() {
		start	= get_timer();
		return self;
		
	}
	static set	= function( _sprite, _index ) {
		sprite	= _sprite;
		index	= _index;
		
	}
	x		= _x;
	y		= _y;
	sprite	= _sprite;
	index	= _index;
	start	= get_timer();
	color	= c_white;
	left	= _left;
	top		= _top;
	width	= _width  ?? sprite_get_width( sprite );
	height	= _height ?? sprite_get_height( sprite );
	animate = false;
	
}
