/// @func ease_in_out_quad
/// @param {float}	t	A float 0.0 - 1.0
/// @desc	An easing function.  Check <https://easings.net/> for examples on how these functions
///		behave.
/// @returns float
function ease_in_out_quad( _x ) {
	if ( is_numeric( _x ) == false )
		throw new InvalidArgumentType( "ease_in_out_quad", 0, _x, "real" );
	if ( _x < 0.0 || _x > 1.0 )
		throw new ValueOutOfBounds( "ease_in_out_quad", _x, 0.0, 1.0 );
	
	if (_x < 0.5) { return 2 * _x * _x; }
	return 1 - power(-2 * _x + 2, 2) / 2;
	
}
