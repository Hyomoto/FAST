/// @func char_is_numeric
/// @param {string}	char	A single character
/// @desc	Returns if the given character is numeric
function char_is_numeric( _char ) {
	return "0" <= _char && _char <= "9";
	
}
