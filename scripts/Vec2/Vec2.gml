/// @func Vec2
/// @param {real} x The x position in this vector
/// @param {real} y The y position in this vector
/// @desc A simple, garbage-collected two-dimensional vector.
/// @example
//var _vec2 = new Vec2( 32, 20 );
/// @wiki Core-Index
function Vec2( _x, _y ) constructor {
	/// @param {real} x The x position to set this vector
	/// @param {real} y The y position to set this vector
	/// @desc Used to set both the x and y coordinates in this vector with a single method.
	static set	= function( _x, _y ) {
		x	= _x;
		y	= _y;
		
	}
	/// @param {Vec2} Vec2 The vector to subtract from this one.
	/// @returns Vec2
	static add	= function( _Vec2 ) { return new Vec2( x + _Vec2.x, y + _Vec2.y ); }
	/// @param {Vec2} Vec2 The vector to subtract from this one.
	/// @returns Vec2
	static subtract	= function( _Vec2 ) {
		return new Vec2(  x	- _Vec2.x, y - _Vec2.y );
		
	}
	/// @param {Vec2} Vec2 The vector to multiply this one with.
	/// @returns Vec2
	static multiply	= function( _Vec2 ) {
		return new Vec2( x * _Vec2.x, y * _Vec2.y );
		
	}
	/// @param {Vec2} Vec2 The vector to divide this one by.
	/// @returns Vec2
	static divide	= function( _Vec2 ) {
		return new Vec2( x / _Vec2.x, y / _Vec2.y );
		
	}
	/// @param {Vec2} Vec2 The vector to get the dot product with.
	/// @returns real
	static dot	= function( _Vec2 ) {
		return x * _Vec2.x + y * _Vec2.y;
		
	}
	/// @desc Returns this vector as an array.
	/// @returns array `[ x, y ]`
	static toArray	= function() {
		return [ x, y ];
		
	}
	/// @desc Returns this vector as a comma-separated string value pair.
	/// @returns string "x, y"
	static toString	= function() {
		return string( x ) + ", " + string( y );
		
	}
	static is		= function( _data_type ) {
		return _data_type == Vec2;
		
	}
	/// @desc the x position of this vector
	x	= 0;
	/// @desc the y position of this vector
	y	= 0;
	
	set( _x, _y );
	
}
