/// @func char_is_linebreak
/// @param {string}	char	A single character
/// @desc	Returns if the given character is a line break
function char_is_linebreak( _char ) {
	return _char == "\n" || _char == "\r";
	
}
