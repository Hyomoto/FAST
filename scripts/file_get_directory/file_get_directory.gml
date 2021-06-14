/// @func file_get_directory
/// @param {string}	directory	The directory to start searching from.
/// @param {string}	mask		The mask to search with
/// @param {bool}	*sub		optional: If `true`, will include sub-directories.
/// @returns LinkedList
/// @desc	Searches the given directory for files that match the mask.  If sub is true, all
///		sub directories will also be traversed.
/// @example
//var _files = file_get_directory( working_directory, "*.txt", false );
/// @output A list of all the files in the working directory that end with .txt
/// @returns array
/// @wiki Core-Index Files
function file_get_directory( _directory, _mask, _sub ) {
	var _return	= new LinkedList(); // queue
	var _paths	= new Stack(); // stack
	
	_paths.push( _directory );
	
	do {
		var _path	= _paths.pop();
		var _file	= file_find_first( _path + "*", fa_directory );
		
		while ( _file != "" ) {
			// file_attributes is broken, this is a workaround
			if ( file_exists( _path + _file ) == false ) {
				if ( _sub == true )
					_paths.push( _path + _file + "/" );
				
			} else {
				_return.push( _path + _file );
				
			}
			_file	= file_find_next();
			
		}
		file_find_close();
		// file_attributes is broken, this doesn't actually work and pisses me off
		_file	= file_find_first( _path + _mask, 0);
		
		while ( _file != "" ) {
			if ( file_exists( _path + _file ) == false ) {
				_return.enqueue( _path + _file );
				
			}
			_file	= file_find_next();
			
		}
		file_find_close();
		
	} until ( _paths.is_empty() );
	
	delete _paths;
	
	return _return.to_array();
	
}
