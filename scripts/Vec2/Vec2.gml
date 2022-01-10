/// @func Vec2
/// @param {real} x The x position in this vector
/// @param {real} y The y position in this vector
/// @desc A simple, two-dimensional garbage-collected vector.
/// @example
//var _vec2 = new Vec2( 32, 20 );
/// @output A new Vec2 is created with an x of 32 and a y of 20
/// @wiki Numbers-Index Constructors
function Vec2( _x, _y ) : __Struct__() constructor {
	/// @param {Vec2} Vec2	A vector
	/// @desc	Adds this vector to vec and returns the result.
	/// @returns Vec2
	static add	= function( _vec ) {
		if (not struct_type(_vec, Vec2)) {
			throw new InvalidArgumentType("add", _vec, "Vec2");	
		}
		return set(x + _vec.x, y + _vec.y); 
	}
	/// @param {Vec2} vec	A vector
	/// @desc	Substracts this vector from vec and returns the result.
	/// @returns Vec2
	static subtract	= function( _vec ) {
		if (not struct_type(_vec, Vec2)) {
			throw new InvalidArgumentType("subtract", _vec, "Vec2");	
		}
		return set(x - _vec.x, y - _vec.y); 
	}
	/// @param {Vec2} vec	A vector
	/// @desc	Multiplies this vector by vec and returns the result.
	/// @returns Vec2
	static componentwise_multiply	= function( _vec ) {
		if (not struct_type(_vec, Vec2)) {
			throw new InvalidArgumentType("componentwise_multiply", _vec, "Vec2");	
		}
		return set(x * _vec.x, y * _vec.y); 
	}
	/// @param {Vec2} vec	A vector
	/// @desc	Divides this vector by vec and returns the result.
	/// @returns Vec2
	static componentwise_divide	= function( _vec ) {
		if (not struct_type(_vec, Vec2)) {
			throw new InvalidArgumentType("componentwise_divide", _vec, "Vec2");	
		}
		if (_vec.x == 0 || _vec.y == 0) {
			throw new DivisionByZero("componentwise_divide");
		}
		return set(x / _vec.x, y / _vec.y); 
	}
	/// @param {Vec2} vec	A vector
	/// @desc	Returns the cross product this vector and vec.
	/// @returns Vec2
	static cross	= function( _vec ) {
		if (not struct_type(_vec, Vec2)) {
			throw new InvalidArgumentType("cross", _vec, "Vec2");	
		}
		return x * _vec.x - y * _vec.y;
	}
	/// @param {Vec2} vec	A vector
	/// @desc	Returns the dot product of this vector and vec.
	/// @returns real
	static dot	= function( _vec ) {
		if (not struct_type(_vec, Vec2)) {
			throw new InvalidArgumentType("dot", _vec, "Vec2");	
		}
		return x * _vec.x + y * _vec.y;
	}
	/// @desc	Returns this vector normallized to unit length.
	/// @returns Vec2
	static normalize	= function() {
		if (not struct_type(_vec, Vec2)) {
			throw new InvalidArgumentType("normalize", _vec, "Vec2");	
		}
		var _len = sqr_len();
		if ( _len == 0 ) {
			throw new DivisionByZero("normalize");
		}
		
		_len = sqrt( _len );
		return new Vec2( x / _len, y / _len );
	}
	/// @returns Vec3
	/// @desc Used to get the vectors as unit length.
	static normalized	= function() {
		if (not struct_type(_vec, Vec2)) {
			throw new InvalidArgumentType("normalized", _vec, "Vec2");	
		}
		var _len = sqr_len();
		if ( _len == 0 ) {
			throw new DivisionByZero("normalize");
		}
		_len = sqrt( _len );
			
		return new Vec2( x / _len, y / _len);
	}
	/// @param {Vec2} vec	A vector
	/// @desc	Returns the distance between this vector and vec.
	/// @returns real
	static dist_to	= function( _vec ) {
		if (not struct_type(_vec, Vec2)) {
			throw new InvalidArgumentType("dist_to", _vec, "Vec2");	
		}
		return sqrt((x - _vec.x) * (x - _vec.x) + (y - _vec.y) * (y - _vec.y));
	}	
	/// @param {Vec2} vec	A vector
	/// @desc	Returns the squared distance between this vector and vec.
	/// @returns real
	static sqr_dist_to	= function( _vec ) {
		if (not struct_type(_vec, Vec2)) {
			throw new InvalidArgumentType("sqr_dist_to", _vec, "Vec2");	
		}
		return ((x - _vec.x) * (x - _vec.x) + (y - _vec.y) * (y - _vec.y));
	}
	/// @desc	Returns the length of this vector.
	/// @returns real
	static len	= function() {
		return sqrt( x * x + y * y );
	}
	/// @desc	Returns the squared length of this vector.
	/// @returns real
	static sqr_len	= function() {
		return (x * x + y * y);
	}
	/// @param {real}	x	An x position
	/// @param {real}	y	An y position
	/// @desc	Set the x and y values of this vector.
	/// @returns self
	static set	= function( _x, _y ) {
		if (not (is_real(_x) && is_real(_y))) {
			throw new InvalidArgumentType("set", _vec, "real");	
		}
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
	
	
	__Type__.add( Vec2 );
}
