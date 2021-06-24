/// @func Vec2
/// @param {real} x The x position in this vector
/// @param {real} y The y position in this vector
/// @desc A simple, two-dimensional garbage-collected vector.
/// @example
//var _vec2 = new Vec2( 32, 20 );
/// @output A new Vec2 is created with an x of 32 and a y of 20
/// @wiki Numbers-Index Constructors
function Vec2( _x, _y ) constructor {
	/// @param {Vec2} Vec2 The vector to subtract from this one.
	/// @returns Vec2
	static add	= function( _Vec2 ) {
		return new Vec2( x + _Vec2.x, y + _Vec2.y );
		
	}
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
	/// @param {Vec2} Vec2 The vector to get the cross product with.
	/// @returns Vec2
	static cross	= function( _Vec2 ) {
		return x * _Vec2.x - y * _Vec2.y;
		
	}
	/// @param {real}	x	An x position
	/// @param {real}	y	An y position
	/// @desc Used to set both the x and y coordinates in this vector with a single method.
	/// @returns self
	static set	= function( _x, _y ) {
		x	= _x;
		y	= _y;
		
		return self;
		
	}
	/// @desc Used to get the vectors length.
	/// @returns real
	static len	= function() {
		return sqrt( x * x + y * y );
		
	}
	/// @desc Used to get the vectors squared length.
	/// @returns real
	static lensqr	= function() {
		return (x * x + y * y);
		
	}
	/// @param {Vec2} Vec2 The vector to get the dot product with.
	/// @returns real
	static dot	= function( _Vec2 ) {
		return x * _Vec2.x + y * _Vec2.y;
		
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
	/// @desc Used to normalise the vector to unit length.
	/// @returns Vec2
	static normalize	= function() {
		var _len_sqr	= lensqr();
		
		if ( _len_sqr != 0 ) {
			var _len	= sqrt( _len_sqr );
			
			return new Vec2( x / _len, y / _len );
			
		}
		throw new __Error__().from_string( "Vec2 length must be greater than 0 to normalize!" );
		
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
