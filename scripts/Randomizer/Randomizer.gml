/// @func Randomizer
/// @desc	A template for creating psuedorandom number generators.  By itself it produces no output,
///		as it must be extended to produce a result.
function Randomizer() constructor {
	/// @param seed	The seed to set the number generator to.
	/// @desc	Sets the starting seed for the randomizer.
	/// @param returns self
	static seed	= function( _seed ) {
		state	= _seed;
		
		return self;
		
	}
	static between	= function( _start, _end ) {
		var _range	= _end - _start;
		
		return range( _range ) + _start;
		
	}
	/// @param {mixed}    range    The range value.
    /// @desc Returns a clamped integer in the range between 0 and the range value.  ie: 10 would return 0 - 9.
    /// @returns integer
	static range	= function( _range ) {
		return next() % _range;
		
	}
	/// @desc Returns the next random integer from the generator.
    /// @returns integer
	static next	= function() {
		return state;
		
	}
	state	= 0;
	
}
