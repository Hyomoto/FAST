function UIRectangle( _x, _y, _width, _height, _callback = undefined ) : UIInteraction( _callback ) constructor {
	static isInside	= function( _x, _y ) {
		return point_in_rectangle( _x - x, _y - y, 0, 0, w, h );
		
	}
	static draw		= function( _x = 0, _y = 0, _color = c_white, _outline = true ) {
		if ( beforeDraw != undefined ) method_call( beforeDraw[ 0 ], beforeDraw, 1 );
		draw_rectangle_color( x + _x, y + _y, r + _x, b + _y, _color, _color, _color, _color, _outline );
		if ( afterDraw != undefined ) method_call( afterDraw[ 0 ], afterDraw, 1 );
		
	}
	x	= _x;
	y	= _y;
	r	= x + _width - 1;
	b	= y + _height- 1;
	w	= _width;
	h	= _height;
	
}
