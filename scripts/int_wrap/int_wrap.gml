/// @func int_wrap
/// @param value
/// @param min
/// @param max
/// @desc Returns the given integer "wrapped" around min and max. This can be used to get overflow behavior
//out of GML's integer type, but will properly wrap as long as min < max.
//
//>Note: Wrap happens at `max`, thus max is the value that wraps back to min
/// @example
//var _int = int_wrap( 16, 0, 16 );
//
//show_debug_message( _int );
/// @returns int
/// @wiki Core-Index Functions
function int_wrap( _value, _min, _max ) {
	var _range	= _max - _min;
	
	_value	= ( _value - _min ) % _range;
	
	return ( _value < 0 ? _max + ( _value ) : _value + _min );
	
}
