/// @func ShapeEllipses
/// @param x
/// @param y
/// @param w
/// @param h
function ShapeEllipses( _x, _y, _w, _h ) : Shape() constructor {
	static inside	= function( _x, _y ) {
		return ( power( ( _x - ex ), 2) / ea ) + ( power( ( _y - ey ), 2) / eb ) <= 1;
		
	}
	static draw	= function( _x, _y, _outline ) {
		_x	= ( _x == undefined ? x : _x + x );
		_y	= ( _y == undefined ? y : _y + y );
		
		draw_ellipse( _x, _y, _x + w, _y + h, ( _outline == false ) );
		
	}
	x	= _x;
	y	= _y;
	w	= _w;
	h	= _h;
	
	ex	= x + w div 2;
	ey	= y + h div 2;
	ea	= power( w div 2, 2 );
	eb	= power( h div 2, 2 );
	
}
