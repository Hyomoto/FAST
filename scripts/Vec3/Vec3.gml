/// @func Vec3
/// @param {real} x The x component in this vector
/// @param {real} y The y component in this vector
/// @param {real} z The z component in this vector
/// @desc A simple, garbage-collected three-dimensional vector.
/// @example
//var _vec = new Vec3( 32, 20, 12 );
/// @wiki Core-Index
function Vec3( _x, _y, _z ) : __Struct__() constructor {
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
	static sqr_len	= function() {
		return (x * x + y * y + z * z);	
	}
	/// @param {Vec3} Vec3 The vector to add to this one.
	/// @returns Vec3
	static add	= function( _vec ) {
		if (not struct_type(_vec, Vec3)) {
			throw new UnexpectedTypeMismatch("add", _vec, "Vec3");	
		}
		return set( x + _vec.x, y + _vec.y, z + _vec.z ); 
	}
	/// @param {Vec3} Vec3 The vector to subtract from this one.
	/// @returns Vec3
	static subtract	= function( _vec ) {
		if (not struct_type(_vec, Vec3)) {
			throw new UnexpectedTypeMismatch("subtract", _vec, "Vec3");	
		}
		return set(  x	- _vec.x, y - _vec.y, z - _vec.z );
	}
	/// @param {Vec3} Vec3 The vector to multiply this one component wise with.
	/// @returns Vec3
	static componentwise_multiply = function( _vec ) {
		if (not struct_type(_vec, Vec3)) {
			throw new UnexpectedTypeMismatch("componentwise_multiply", _vec, "Vec3");	
		}
		return set( x * _vec.x, y * _vec.y, z * _vec.z );
	}
	/// @param {Vec3} Vec3 The vector to divide this one one component wise by.
	/// @returns Vec3
	static componentwise_divide	= function( _vec ) {
		if (not struct_type(_vec, Vec3)) {
			throw new UnexpectedTypeMismatch("componentwise_divide", _vec, "Vec3");	
		}
		if (_vec.x == 0 || _vec.y == 0 || _vec.z == 0) {
			throw new DivisionByZero("componentwise_divide");
		}
		return new Vec3( x / _vec.x, y / _vec.y, z / _vec.z );
	}
	/// @param {Vec3} Vec3 The vector to get the dot product with.
	/// @returns real
	static dot	= function( _vec ) {
		if (not struct_type(_vec, Vec3)) {
			throw new UnexpectedTypeMismatch("dot", _vec, "Vec3");	
		}
		return x * _vec.x + y * _vec.y + z * _vec.z;
	}
	/// @param {Vec3} Vec3 The vector to get the cross product with.
	/// @returns Vec3
	static cross	= function( _vec ) {
		if (not struct_type(_vec, Vec3)) {
			throw new UnexpectedTypeMismatch("cross", _vec, "Vec3");	
		}
		var _x = y * _vec.z - z * _vec.y;
		var _y = z * _vec.x - x * _vec.z;
		var _z = x * _vec.y - y * _vec.x;
		return new Vec3(_x, _y, _z);
	}
	/// @param {Vec3} Vec3 The vector to get the distance to.
	/// @returns real
	static dist_to	= function( _vec ) {
		if (not struct_type(_vec, Vec3)) {
			throw new UnexpectedTypeMismatch("dist_to", _vec, "Vec3");	
		}
		return sqrt(
			(x - _vec.x) * (x - _vec.x) +
			(y - _vec.y) * (y - _vec.y) +
			(z - _vec.z) * (z - _vec.z)
		);
	}	
	/// @param {Vec3} Vec3 The vector to get the squared distance to.
	/// @returns real
	static sqr_dist_to	= function( _vec ) {
		if (not struct_type(_vec, Vec3)) {
			throw new UnexpectedTypeMismatch("sqr_dist_to", _vec, "Vec3");	
		}
		return ( 
			(x - _vec.x) * (x - _vec.x) +
			(y - _vec.y) * (y - _vec.y) +
			(z - _vec.z) * (z - _vec.z)
		);
	}

	/// @returns Vec3
	/// @desc Used to normalise the vector to unit length.
	static normalize	= function() {
		var _len		= sqr_len();
		if (_len == 0) 
			throw new DivisionByZero("normalize");
		}
		_len	= sqrt( _len );
		return set( x / _len, y / _len, z / _len);
	}
	/// @returns Vec3
	/// @desc Used to get the vectors as unit length.
	static normalized	= function() {
		if (not struct_type(_vec, Vec3)) {
			throw new UnexpectedTypeMismatch("normalized", _vec, "Vec3");	
		}
		var _len = sqr_len();
		if ( _len == 0 ) {
			throw new DivisionByZero("normalize");
		}
		_len = sqrt( _len );
			
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

	/// @desc the x component of this vector
	x	= 0;
	/// @desc the y component of this vector
	y	= 0;
	/// @desc the z component of this vector
	z	= 0;
	set( _x, _y, _z );
	
	__Type__.add( Vec3 );
}
