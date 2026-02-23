function string_fill( _tpose, _string, _right = true ) {
	_string	= string( _string );
	if ( not _right )
		return _string + string_delete( _tpose, 1, string_length( _string ));
	return string_copy( _tpose, 1, string_length( _tpose ) - string_length( _string )) + _string;
	
}
