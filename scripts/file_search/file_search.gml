function file_search( _mask = "*", _directory = "", _sub = false ) {
	var _list	= new LinkedList();
	var _dirs	= new Stack();
	
	_dirs.push( _directory );
	
	while ( _dirs.size() > 0 ) {
		var _dir	= _dirs.pop();
		var _file	= file_find_first( _dir + "*", _sub ? fa_directory : 0 );
		
		while ( _file != "" ) {
			if ( !file_exists( _dir + _file ) )
				_dirs.push( _file + "\\" );
			else if ( _mask == "*" || string_last_pos( _mask, _file ) == string_length( _file ) - string_length( _mask ) + 1)
				_list.push( _dir + _file );
			_file	= file_find_next();
			
		}
		file_find_close();
		
	}
	return _list;
	
}
