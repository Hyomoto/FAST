/// @func ShapeCircle
/// @param x
/// @param y
/// @param radius
function ShapeCircle( _x, _y, _radius ) : Shape() constructor {
	static inside	= function( _x, _y ) {
	    return point_in_circle( _x, _y, x, y, radius );
		
	}
	static draw	= function( _x, _y, _outline ) {
		_x	= ( _x == undefined ? x : _x + x );
		_y	= ( _y == undefined ? y : _y + y );
		
		draw_circle( _x, _y, radius, ( _outline == false ) );
		
	}
	x	= _x;
	y	= _y;
	radius	= _radius;
	
}
