/// @func int_overflow
/// @param {int}	value	An integer
/// @param {int}	low		The low value to wrap around
/// @param {int}	high	The high value to wrap around
/// @desc	Allows "overflow" behavior with GML's integers. The value will be wrapped around the
///		low and high values and returned.
//>Note: Wrap happens at `max`, thus max is the value that wraps back to min
/// @example
//var _int = int_wrap( 16, 0, 16 );
//
//show_debug_message( _int );
/// @returns int
/// @wiki Numbers-Index Functions
function int_overflow( _value, _low, _high ) {
	if ( is_numeric( _value ) == false )
		throw new InvalidArgumentType( "int_overflow", 0, _value, "integer" );
	if ( is_numeric( _low ) == false )
		throw new InvalidArgumentType( "int_overflow", 1, _low, "integer" );
	if ( _high == undefined ) { _high = _low; _low = 0; }
	if ( is_numeric( _high ) == false )
		throw new InvalidArgumentType( "int_overflow", 2, _high, "integer" );
	
	var _len	= _high - _low;
	
	_value	= ( _value - _low ) % _len;
	
	return ( _value < 0 ? _high + ( _value ) : _value + _low );
	
}
