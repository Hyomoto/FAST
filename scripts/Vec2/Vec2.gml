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
	static toString	= function() {
		return string( x ) + ", " + string( y );
		
	}
	set( _x, _y );
	
}
