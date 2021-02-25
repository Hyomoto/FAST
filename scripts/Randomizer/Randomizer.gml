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
	static next_range	= function( _start, _end ) {
		var _range	= _end - _start + 1;
		
		return next() % _range + _start;
		
	}
	/// @desc Returns the next random integer from the generator.
    /// @returns integer
	static next	= function() {
		return state;
		
	}
	state	= 0;
	
}
