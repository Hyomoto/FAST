function Randomizer() constructor {
	static seed	= function( _seed ) {
		state	= _seed;
		
	}
	static between	= function( _start, _end ) {
		var _range	= _end - _start;
		
		return range( _range ) + _start;
		
	}
	/// @param {mixed}    range    The range value.
    /// @desc Returns a clamped integer in the range between 0 and the range value.  ie: 10 would return 0 - 9.
    /// @returns integer
	static range	= function( _range ) {
		return rand() % _range;
		
	}
	/// @desc Returns the next random integer from the generator.
    /// @returns integer
	static rand	= function() {
		return state;
		
	}
	state	= 0;
	
}
