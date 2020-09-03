/// @func Vec2
/// @param a
/// @param b
function Vec2( _x, _y ) constructor {
	static set	= function( _x, _y ) {
		x	= _x;
		y	= _y;
		
	}
	static add	= function( _vec ) {
		x	+= _vec.x;
		y	+= _vec.y;
		
	}
	static subtract	= function( _vec ) {
		x	-= _vec.x;
		y	-= _vec.y;
		
	}
	static multiply	= function( _vec ) {
		x	*= _vec.x;
		y	*= _vec.y;
		
	}
	static divide	= function( _vec ) {
		x	/= _vec.x;
		y	/= _vec.y;
		
	}
	static dot	= function( _vec ) {
		return x * _vec.x + y * _vec.y;
		
	}
	static toArray	= function() {
		return [ x, y ];
		
	}
	static toString	= function() {
		return string( x ) + ", " + string( y );
		
	}
	static is		= function( _data_type ) {
		return _data_type == Vec2;
		
	}
	set( _x, _y );
	
}
