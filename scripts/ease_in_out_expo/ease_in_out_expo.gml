/// @func ease_in_out_expo
/// @param {float}	t	A float 0.0 - 1.0
/// @desc	An easing function.  Check <https://easings.net/> for examples on how these functions
///		behave.
/// @returns float
function ease_in_out_expo( _x ) {
	if ( is_numeric( _x ) == false )
		throw new InvalidArgumentType( "ease_in_out_expo", 0, _x, "real" );
	if ( _x < 0.0 || _x > 1.0 )
		throw new ValueOutOfBounds( "ease_in_out_expo", _x, 0.0, 1.0 );
	
	switch _x {
		case 0	: return 0;
		case 1	: return 1;
	}
	if (_x < 0.5) { return power(2, 20 * _x - 10) / 2; }
	return (2 - power(2, -20 * _x + 10)) / 2;
	
}
