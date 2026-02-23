function string_header( _header, _length = 80, _pattern = "=-" ) {
	static header	= function( _length, _pattern ) {
		if ( _length & 1 )
			return string_repeat( _pattern, _length - 1 ) + string_char_at( _pattern, 1 );
		return string_repeat( _pattern, _length );
		
	}
	var _half	= ( _length - string_length( _header ) - 2 ) / 2 / string_length( _pattern );
	var _left	= floor( _half );
	var _right	= ceil( _half );
	return header( _left, _pattern ) + " " + _header + " " + header( _right, _pattern );
	
}
