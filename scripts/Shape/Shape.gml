/// @func Shape
function Shape() constructor {
	static inside	= function( _x, _y ) { return true; }
	static draw		= function( _x, _y, _outline ) {}
	static set		= function( _x, _y ) {
		x	= _x;
		y	= _y;
		
	}
	static is	= function( _data_type ) {
		return _data_type == Shape;
		
	}
	x	= 0;
	y	= 0;
	
}
