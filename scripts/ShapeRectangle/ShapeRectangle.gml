/// @func ShapeRectangle
/// @param x
/// @param y
/// @param w
/// @param h
function ShapeRectangle( _x, _y, _w, _h ) : Shape() constructor {
	static inside	= function( _x, _y ) {
		return ( point_in_rectangle( _x, _y, x, y, x + w, y + h ) );
		
	}
	static draw	= function( _x, _y, _outline ) {
		_x	= ( _x == undefined ? x : _x + x );
		_y	= ( _y == undefined ? y : _y + y );
		
		draw_rectangle( _x, _y, _x + w, _y + h, ( _outline != true ) );
		
	}
	x		= _x;
	y		= _y;
	w		= _w;
	h		= _h;
	
}
