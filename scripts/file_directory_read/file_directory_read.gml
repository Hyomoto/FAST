function file_directory_read( _path ) {
	var _list	= [];
	var _next	= file_find_first( _path, fa_none );
	while( _next != "" ) {
		array_push( _list, _next );
		_next	= file_find_next();
		
	}
	file_find_close();
	return _list;
	
}
