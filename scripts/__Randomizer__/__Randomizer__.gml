/// @func __Randomizer__
/// @desc	A template for creating psuedorandom number generators.  By itself it produces no output,
///		as it must be extended to produce a result.
function __Randomizer__() : __Struct__() constructor {
	/// @desc Returns the next random integer from the generator.
    /// @returns int
	static next	= function() { return 0; } // override
	/// @param {int}	seed	The seed to set the number generator to.
	/// @desc	Sets the starting seed for the randomizer.
	/// @returns self
	static seed	= function( _seed ) {
		__State	= _seed;
		
		return self;
		
	}
	/// @param {int}	end		The end number
	/// @desc	Returns a number between 0 and end inclusive.
	/// @returns int
	static next_int		= function( _end ) {
		return next() % _end;
		
	}
	/// @param {int}	start	The start number
	/// @param {int}	end		The end number
	/// @desc	Returns a number between start and end inclusive.
	/// @returns int
	static next_range	= function( _start, _end ) {
		var _range	= _end - _start + 1;
		
		return ( next() % _range ) + _start;
		
	}
	/// @var {int}	The internal state of the randomizer
	__State	= 0;
	
	__Type__.add( __Randomizer__ );
	
}
