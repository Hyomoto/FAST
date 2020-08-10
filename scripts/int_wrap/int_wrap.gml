/// @func int_wrap
/// @param value
/// @param min
/// @param max
function int_wrap( _value, _min, _max ) {
	var _range	= _max - _min;
		
	_value	= ( _value - _min ) % _range;
		
	return ( _value < 0 ? _max + ( _value ) : _value + _min );
		
}
