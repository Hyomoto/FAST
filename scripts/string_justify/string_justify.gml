/// @desc string string_justify( string, spaces, alignment, *character )
/// @param {string}	string		the string to justify
/// @param {int}	spaces		the number of spaces to justify to
/// @param {int}	alignment	the alignment to use
/// @param {string}	*character	optional: the character to use for spacing
function string_justify( _string, _spaces, _alignment ) {
	var _char	= ( argument_count > 3 ? argument[ 3 ] : " " );
	var _length	= string_length( _string );
	
	_string = string_copy( string( _string ), 1, _spaces );
	
	switch ( _alignment ) {
		case fa_left :
			return _string + ( _spaces - _length ) * _char;
			
		case fa_center :
			return ( _spaces - _length ) div 2 * _char + _string;
			
		case fa_right :
			return ( _spaces - _length ) * _char + _string;
			
	}
	
}
