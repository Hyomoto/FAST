/// @func ease_in_out_back
/// @param {float}	t	A float 0.0 - 1.0
/// @desc	An easing function.  Check <https://easings.net/> for examples on how these functions
///		behave.
/// @returns float
function ease_in_out_back( _x ) {
	if ( is_numeric( _x ) == false )
		throw new InvalidArgumentType( "ease_in_out_back", 0, _x, "real" );
	if ( _x < 0.0 || _x > 1.0 )
		throw new ValueOutOfBounds( "ease_in_out_back", _x, 0.0, 1.0 );
	
	static c1 = 1.70158;
	static c2 = c1 * 1.525;
	
	if (_x < 0.5) {
		return (power(2 * _x, 2) * ((c2 + 1) * 2 * _x - c2)) / 2;
		
	}
	return (power(2 * _x - 2, 2) * ((c2 + 1) * (_x * 2 - 2) + c2) + 2) / 2;
	
}
