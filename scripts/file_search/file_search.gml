/// @func file_search
/// @param {string}	filetype	The file extension to search for.
/// @param {string}	directory	The directory to start searching from.
/// @param {bool}	*sub		optional: If `true`, will include sub-directories.
/// @param {__Stream__} output	optional: If provided, this output stream will be used
/// @desc	Searches the given directory for files that match the mask.  If sub is true, all
///		sub directories will also be traversed.
/// @example
//var _files = file_earch( "txt", working_directory, false );
/// @output A list of all the files in the working directory that end with .txt
/// @returns LinkedList
/// @wiki Core-Index Functions
function file_search( _mask, _directory, _sub, _output ) {
	var _list	= _output == undefined ? new LinkedList() : _output;
	var _dirs	= new Stack();
	
	if ( struct_type( _output, __OutputStream__ ) == false )
			throw new InvalidArgumentType( "file_search", 0, _output, "__OutputStream__" );
	
	if ( _mask == undefined ) { _mask = "*"; }
	if ( _directory == undefined ) { _directory = ""; }
	if ( _sub = undefined ) { _sub = false; }
	
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
