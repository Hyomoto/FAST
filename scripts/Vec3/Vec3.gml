/// @func Vec3
/// @param {real} x The x component in this vector
/// @param {real} y The y component in this vector
/// @param {real} z The z component in this vector
/// @desc A simple, garbage-collected three-dimensional vector.
/// @example
//var _vec3 = new Vec3( 32, 20, 12 );
/// @wiki Core-Index
function Vec3( _x, _y, _z ) constructor {
	/// @param {real} x The x component to set this vector
	/// @param {real} y The y component to set this vector
	/// @param {real} z The z component to set this vector
	/// @desc Used to set the vector components with a single method.
	static set	= function( _x, _y, _z ) {
		x	= _x;
		y	= _y;
		z	= _z;
	}
	/// @returns real
	/// @desc Used to get the vectors length.
	static len	= function() {
		return 	sqrt( x * x + y * y + z * z );
	}
	/// @returns real
	/// @desc Used to get the vectors squared length.
	static lensqr	= function() {
		return (x * x + y * y + z * z);	
	}
	/// @param {Vec3} Vec3 The vector to add to this one.
	/// @returns Vec3
	static add	= function( _Vec3 ) { return new Vec3( x + _Vec3.x, y + _Vec3.y, z + _Vec3.z ); }
	/// @param {Vec3} Vec3 The vector to subtract from this one.
	/// @returns Vec3
	static subtract	= function( _Vec3 ) {
		return new Vec3(  x	- _Vec3.x, y - _Vec3.y, z - _Vec3.z );
		
	}
	/// @param {Vec3} Vec3 The vector to multiply this one component wise with.
	/// @returns Vec3
	static multiply	= function( _Vec3 ) {
		return new Vec3( x * _Vec3.x, y * _Vec3.y, z * _Vec3.z );
		
	}
	/// @param {Vec3} Vec3 The vector to divide this one one component wise by.
	/// @returns Vec3
	static divide	= function( _Vec3 ) {
		return new Vec3( x / _Vec3.x, y / _Vec3.y, z / _Vec3.z );
		
	}
	/// @param {Vec3} Vec3 The vector to get the dot product with.
	/// @returns real
	static dot	= function( _Vec3 ) {
		return x * _Vec3.x + y * _Vec3.y + z * _Vec3.z;
		
	}
	/// @param {Vec3} Vec3 The vector to get the cross product with.
	/// @returns Vec3
	static cross	= function( _Vec3 ) {
		var _x = y * _Vec3.z - z * _Vec3.y;
		var _y = z * _Vec3.x - x * _Vec3.z;
		var _z = x * _Vec3.y - y * _Vec3.x;
		return new Vec3(_x, _y, _z);
	}
	/// @param {Vec3} Vec3 The vector to get the distance to.
	/// @returns real
	static dist_to	= function( _Vec3 ) {
		return sqrt(
			(x - _Vec3.x) * (x - _Vec3.x) +
			(y - _Vec3.y) * (y - _Vec3.y) +
			(z - _Vec3.z) * (z - _Vec3.z)
		);
	}	
	/// @param {Vec3} Vec3 The vector to get the squared distance to.
	/// @returns real
	static dist_to_sqr	= function( _Vec3 ) {
		return ( 
			(x - _Vec3.x) * (x - _Vec3.x) +
			(y - _Vec3.y) * (y - _Vec3.y) +
			(z - _Vec3.z) * (z - _Vec3.z)
		);
	}

	/// @returns Vec3
	/// @desc Used to normalise the vector to unit length.
	static normalize	= function() {
		var _len		= 0;
			_len	= sqrt( _len );
			
			set( x / _len, y / _len, z / _len);

		return self;
	}
	/// @returns Vec3
	/// @desc Used to get the vectors unit length.
	static normalized	= function() {
		var _len		= 0;
			_len	= sqrt( _len );
			
		return new Vec3( x / _len, y / _len, z / _len);
	}
	/// @desc Returns this vector as an array.
	/// @returns array `[ x, y ]`
	static toArray	= function() {
		return [ x, y, z ];
		
	}
	/// @desc Returns this vector as a comma-separated string value pair.
	/// @returns string "x, y"
	static toString	= function() {
		return string( x ) + ", " + string( y ) + ", " + string( z );
		
	}
	static is		= function( _data_type ) {
		return _data_type == Vec3;
		
	}
	/// @desc the x component of this vector
	x	= 0;
	/// @desc the y component of this vector
	y	= 0;
	/// @desc the z component of this vector
	z	= 0;
	set( _x, _y, _z );
	
}
