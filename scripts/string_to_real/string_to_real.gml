/// @func string_to_real
/// @param {string}	value	the string to be converted
/// @desc	Attempts to convert the provided string to a number.  Works on hexidecmial numbers, as well
///		as 
/// @returns real
/// @wiki Core-Index Functions
function string_to_real( _value ) {
	if ( is_string( _value ) == false ) { throw new InvalidArgumentType( "string_to_real", 0, _value, "string" ); }
	
	try {
		return real( _value );
		
	} catch ( _ ) {
		throw new BadValueFormat( "string_to_real", "real", "Could not convert " + _value + " to a number." );
		
	}
	
}
