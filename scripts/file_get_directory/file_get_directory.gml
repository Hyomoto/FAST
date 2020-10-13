/// @func file_get_directory
/// @param directory
/// @param mask
/// @param sub_directories
function file_get_directory( _directory, _mask, _sub ) {
	var _return	= new DsQueue();
	var _paths	= new DsStack();
	var _path, _file;
	
	_paths.push( _directory );
	
	do {
		_path	= _paths.pop();
		_file	= file_find_first( _path + "*", fa_directory );
		
		while ( _file != "" ) {
			// file_attributes is broken, this is a workaround
			if ( file_exists( _path + _file ) == false ) {
				if ( _sub ) {
					_paths.push( _path + _file + "/" );
					
				}
				
			} else {
				_return.enqueue( _path + _file );
				
			}
			_file	= file_find_next();
			
		}
		file_find_close();
		// file_attributes is broken, this doesn't actually work and pisses me off
		_file	= file_find_first(_path + _mask, 0);
		
		while ( _file != "" ) {
			if ( file_exists( _path + _file ) == false ) {
				_return.enqueue( _path + _file );
				
			}
			_file	= file_find_next();
			
		}
		file_find_close();
		
	} until ( _paths.empty() );
	
	delete _paths;
	
	return _return;
	
}
