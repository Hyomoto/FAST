/// @func ease_out_back
/// @param {float}	t	A float 0.0 - 1.0
/// @desc	An easing function.  Check <https://easings.net/> for examples on how these functions
///		behave.
/// @returns float
function ease_out_back( _x ) {
	if ( is_numeric( _x ) == false )
		throw new InvalidArgumentType( "ease_out_back", 0, _x, "real" );
	if ( _x < 0.0 || _x > 1.0 )
		throw new ValueOutOfBounds( "ease_out_back", _x, 0.0, 1.0 );
	
	static c1 = 1.70158;
	static c3 = c1 + 1;
	
	return 1 + c3 * power(_x - 1, 3) + c1 * power(_x - 1, 2);
	
}
