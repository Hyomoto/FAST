/// @func ease_in_out_elastic
/// @param {float}	t	A float 0.0 - 1.0
/// @desc	An easing function.  Check <https://easings.net/> for examples on how these functions
///		behave.
/// @returns float
function ease_in_out_elastic( _x ) {
	if ( is_numeric( _x ) == false )
		throw new InvalidArgumentType( "ease_in_out_elastic", 0, _x, "real" );
	if ( _x < 0.0 || _x > 1.0 )
		throw new ValueOutOfBounds( "ease_in_out_elastic", _x, 0.0, 1.0 );
	
	/// Code cleaned up by Julien's Mom, apparently
	static c = (2 * pi) / 4.5;
	
	switch (_x == 0) {
		case 0	: return 0;
		case 1	: return 1;
	}
	if (_x < 0.5) { return -(power(2, 20 * _x - 10) * sin((20 * _x - 11.125) * c)) / 2; }
	return (power(2, -20 * _x + 10) * sin((20 * _x - 11.125) * c)) / 2 + 1;
	
}
