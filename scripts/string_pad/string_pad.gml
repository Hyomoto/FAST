/// @func string_pad
/// @param {string}	string		The string to justify
/// @param {int}	spaces		The number of spaces to justify to
/// @param {bool}	left?		The alignment to use
/// @param {string}	*character	optional: The character to use for spacing
/// @desc	Attempts to pad the given string the specified number of spaces.  By default spaces " " will
///		be added, but this can be changed by providing character(s) to use.  If left is true, padding is
///		added to the left side of the string, otherwise it will be added to the right.  If a non-string
///		is provided as the string or character, or a non-number is given for spaces or left? then
///		InvalidArgumentType will be thrown.
/// @example
//string_justify( "8125", 6, fa_right, "0" );
/// @output "008125"
/// @throws InvalidArgumentType
/// @returns string
/// @wiki Core-Index Functions
function string_pad( _string, _spaces, _left ) {
	if ( is_string( _string ) == false ) { throw new InvalidArgumentType( "string_justify", 0, _string, "string" ); }
	if ( is_numeric( _spaces ) == false ) { throw new InvalidArgumentType( "string_justify", 1, _spaces, "integer" ); }
	if ( is_numeric( _left ) == false ) { throw new InvalidArgumentType( "string_justify", 2, _left, "bool" ); }
	
	var _char	= ( argument_count > 3 ? argument[ 3 ] : " " );
	
	if ( is_string( _char ) == false ) { throw new InvalidArgumentType( "string_justify", 3, _char, "string" ); }
	
	var _length	= string_length( _string );
	
	if ( _length < _spaces ) {
		return _left ? ( _spaces - _length ) * _char + _string : _string + ( _spaces - _length ) * _char;
		
	}
	return _string;
	
}
