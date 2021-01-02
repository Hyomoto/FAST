/// @func LRand
/// @param {int}	seed	The starting seed for this randomizer.
function LRand( _seed ) constructor {
	seed	= function( _seed ) {
		lehmer	= ( is_undefined( _seed ) ? 0x0 : round( _seed ) );
		
	}
	/// @param {mixed}	range	The range value.
	/// @desc Returns a clamped integer in the range between 0 and the range value.  ie: 10 would return 0 - 9.
	/// @returns integer
	integer	= function( _range ) {
		return rand() % _range;
		
	}
	/// @desc Returns the next random integer from the generator.
	/// @returns integer
	rand	= function() {
		var _temp, _m1, _m2;
	
		lehmer	+= 0xe120fc15;
	
		_temp	= ( lehmer * 0x4a39b70d ) % 0xFFFFFFFF;
		_m1		= ( _temp >> 32 ) ^ _temp;
		_temp	= ( _m1 * 0x12fad5c9 );
		_m2		= ( _temp >> 32 ) ^ _temp;
		
		return _m2;
		
	}
	seed( _seed );
	
}
