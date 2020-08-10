/// @func ShapeGrid
/// @param x
/// @param y
/// @param width
/// @param height
/// @param columns
/// @param rows
/// @desc	Returns -1 if point is outside of Shape, otherwise returns the index of the grid point
function ShapeGrid( _x, _y, _w, _h, _c, _r ) : ShapeRectangle( _x, _y, _w, _h ) constructor {
	static insideSuper	= inside;
	static inside	= function( _x, _y ) {
		if ( insideSuper ) {
			var _px	= ( x - _x ) mod gw;
			var _py	= ( y - _y ) mod gh;
			
			return _py * col + _px;
			
		}
		return -1;
		
	}
	col	= _c;
	row	= _r;
	
	gw	= _w / _c;
	gh	= _h / _r;
	
}
