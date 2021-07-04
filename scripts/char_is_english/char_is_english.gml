/// @func char_is_english
/// @param {string}	char	A single character
/// @desc	Returns true if the given character is part of the English alphabet
function char_is_english( _c ) {
	return ( _c >= "a" && _c <= "z" ) || ( _c >= "A" && _c <= "Z" );
	
}
