/// @func file_get_directory
/// @param directory
function file_get_directory( _directory ) {
	var _return	= new DsStack();
	var _paths	= new DsStack();
	var _path, _file;
	
	_paths.push( _directory );
	
	do {
		_path	= _paths.pop();
		_file	= file_find_first( _path + "*", fa_directory );
		
		while ( _file != "" ) {
			// file_attributes is broken, this is a workaround
			if ( file_exists( _path + _file ) == false ) {
				_paths.push( _path + _file + "/" );
				
			} else {
				_return.push( _path + _file );
				
			}
			_file	= file_find_next();
			
		}
		file_find_close();
		
	} until ( _paths.empty() );
	
	delete _paths;
	
	return _return;
	
}
