/// @func ease_in_linear
/// @param {float}	t	A float 0.0 - 1.0
/// @desc	A linear easing function, returns x.
/// @returns float
function ease_in_linear( _x ) {
	if ( is_numeric( _x ) == false )
		throw new InvalidArgumentType( "ease_in_linear", 0, _x, "real" );
	if ( _x < 0.0 || _x > 1.0 )
		throw new ValueOutOfBounds( "ease_in_linear", _x, 0.0, 1.0 );
	
	return _x;
	
}
