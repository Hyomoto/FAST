/// @param {Any} _state
/// @param {Function} _func
/// @desc	A template for creating psuedorandom number generators.
function Generator( _state, _func ) constructor {
	/// @desc Returns the next random number from the generator.
	next	= method( self, _func );
	
	/// @param {real}	_end	The end number
	/// @desc	Returns a number between 0 and end exclusive.
	static range	= function( _end ) {
		return next() % _end;
		
	}
	/// @param {real}	_low	The low number
	/// @param {real}	_high	The high number
	/// @desc	Returns a number between low and high inclusive.
	static between	= function( _low, _high ) {
		return range( _high - _low + 1 ) + _low;
		
	}
	/// @var {int}	The internal state of the randomizer
	state	= _state;
	
}
