/// @func Vec2
/// @param {real} x The x position in this vector
/// @param {real} y The y position in this vector
/// @desc A simple, garbage-collected two-dimensional vector.
/// @example
//var _vec2 = new Vec2( 32, 20 );
/// @output A new Vec2 is created with an x of 32 and a y of 20
/// @wiki Core-Index
function Vec2( _x, _y ) constructor {
	/// @param {real} x The x position to set this vector
	/// @param {real} y The y position to set this vector
	/// @desc Used to set both the x and y coordinates in this vector with a single method.
	static set	= function( _x, _y ) {
		x	= _x;
		y	= _y;
		
	}
	/// @returns real
	/// @desc Used to get the vectors length.
	static len	= function() {
		return 	sqrt( x * x + y * y );
	}
	/// @returns real
	/// @desc Used to get the vectors squared length.
	static lensqr	= function() {
		return (x * x + y * y);	
	}
	/// @param {Vec2} Vec2 The vector to subtract from this one.
	/// @returns Vec2
	static add	= function( _Vec2 ) { return new Vec2( x + _Vec2.x, y + _Vec2.y ); }
	/// @param {Vec2} Vec2 The vector to subtract from this one.
	/// @returns Vec2
	static subtract	= function( _Vec2 ) {
		return new Vec2(  x	- _Vec2.x, y - _Vec2.y );
		
	}
	/// @param {Vec2} Vec2 The vector to multiply this one component wise with.
	/// @returns Vec2
	static multiply	= function( _Vec2 ) {
		return new Vec2( x * _Vec2.x, y * _Vec2.y );
		
	}
	/// @param {Vec2} Vec2 The vector to divide this one one component wise by.
	/// @returns Vec2
	static divide	= function( _Vec2 ) {
		return new Vec2( x / _Vec2.x, y / _Vec2.y );
		
	}
	/// @param {Vec2} Vec2 The vector to get the dot product with.
	/// @returns real
	static dot	= function( _Vec2 ) {
		return x * _Vec2.x + y * _Vec2.y;
		
	}
	/// @param {Vec2} Vec2 The vector to get the cross product with.
	/// @returns Vec2
	static cross	= function( _Vec2 ) {
		return (x * _Vec2.x - y * _Vec2.y);
	}
	/// @param {Vec2} Vec2 The vector to get the distance to.
	/// @returns real
	static dist_to	= function( _Vec2 ) {
		return sqrt((x - _Vec2.x) * (x - _Vec2.x) + (y - _Vec2.y) * (y - _Vec2.y));
	}	
	/// @param {Vec2} Vec2 The vector to get the squared distance to.
	/// @returns real
	static dist_to_sqr	= function( _Vec2 ) {
		return ((x - _Vec2.x) * (x - _Vec2.x) + (y - _Vec2.y) * (y - _Vec2.y));
	}

	/// @returns Vec2
	/// @desc Used to normalise the vector to unit length.
	static normalize	= function() {
		var _len_sqr	= lensqr();
		
		if ( _len_sqr != 0 ) {
			var _len	= sqrt( _len_sqr );
			
			set( x / _len, y / _len);
		}
		
		return self;
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
