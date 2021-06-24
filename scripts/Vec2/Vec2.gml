/// @func Vec2
/// @param {real} x The x position in this vector
/// @param {real} y The y position in this vector
/// @desc A simple, two-dimensional garbage-collected vector.
/// @example
//var _vec2 = new Vec2( 32, 20 );
/// @output A new Vec2 is created with an x of 32 and a y of 20
/// @wiki Numbers-Index Constructors
function Vec2( _x, _y ) constructor {
	/// @param {Vec2} Vec2	A vector
	/// @desc	Adds this vector to vec and returns the result.
	/// @returns Vec2
	static add	= function( _vec ) {
		return new Vec2( x + _vec.x, y + _vec.y );
		
	}
	/// @param {Vec2} vec	A vector
	/// @desc	Substracts this vector from vec and returns the result.
	/// @returns Vec2
	static subtract	= function( _vec ) {
		return new Vec2(  x	- _vec.x, y - _vec.y );
		
	}
	/// @param {Vec2} vec	A vector
	/// @desc	Multiplies this vector by vec and returns the result.
	/// @returns Vec2
	static multiply	= function( _vec ) {
		return new Vec2( x * _vec.x, y * _vec.y );
		
	}
	/// @param {Vec2} vec	A vector
	/// @desc	Divides this vector by vec and returns the result.
	/// @returns Vec2
	static divide	= function( _vec ) {
		return new Vec2( x / _vec.x, y / _vec.y );
		
	}
	/// @param {Vec2} vec	A vector
	/// @desc	Returns the cross product this vector and vec.
	/// @returns Vec2
	static cross	= function( _vec ) {
		return x * _vec.x - y * _vec.y;
		
	}
	/// @desc	Returns this vector normallized to unit length.
	/// @returns Vec2
	static normalize	= function() {
		var _len_sqr	= lensqr();
		
		if ( _len_sqr != 0 ) {
			var _len	= sqrt( _len_sqr );
			
			return new Vec2( x / _len, y / _len );
			
		}
		throw new __Error__().from_string( "Vec2 length must be greater than 0 to normalize!" );
		
	}
	/// @param {Vec2} vec	A vector
	/// @desc	Returns the dot product of this vector and vec.
	/// @returns real
	static dot	= function( _vec ) {
		return x * _vec.x + y * _vec.y;
		
	}
	/// @param {Vec2} vec	A vector
	/// @desc	Returns the distance between this vector and vec.
	/// @returns real
	static dist_to	= function( _vec ) {
		return sqrt((x - _vec.x) * (x - _vec.x) + (y - _vec.y) * (y - _vec.y));
		
	}	
	/// @param {Vec2} vec	A vector
	/// @desc	Returns the squared distance between this vector and vec.
	/// @returns real
	static dist_to_sqr	= function( _vec ) {
		return ((x - _vec.x) * (x - _vec.x) + (y - _vec.y) * (y - _vec.y));
		
	}
	/// @desc	Returns the length of this vector.
	/// @returns real
	static len	= function() {
		return sqrt( x * x + y * y );
		
	}
	/// @desc	Returns the squared length of this vector.
	/// @returns real
	static lensqr	= function() {
		return (x * x + y * y);
		
	}
	/// @param {real}	x	An x position
	/// @param {real}	y	An y position
	/// @desc	Set the x and y values of this vector.
	/// @returns self
	static set	= function( _x, _y ) {
		x	= _x;
		y	= _y;
		
		return self;
		
	}
	/// @desc Returns this vector as an array.
	/// @returns array
	static to_array	= function() {
		return [ x, y ];
		
	}
	/// @desc Returns this vector as a comma-separated string value pair.
	/// @returns string
	static toString	= function() {
		return string( x ) + ", " + string( y );
		
	}
	/// @var {real} the x position of this vector
	x	= _x;
	/// @var {real} the y position of this vector
	y	= _y;
	
}
