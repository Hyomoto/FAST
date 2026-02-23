/// @func file_search
/// @param {string}	_path		The file extension to search for.
/// @param {bool}	_sub		optional: If `true`, will include sub-directories.
/// @desc	Searches the given directory for files that match the mask.  If sub is true, all
///		sub directories will also be traversed.
function file_search( _path = "*.*", _sub = true ) {
	static read	= function( _mask, _attr, _test = file_exists ) {
		var _file	= file_find_first( _mask, _attr );
		var _path	= filename_path( _mask );
		var _out	= [];
		
		while( _file != "" ) {
			if ( _test( _path + _file ))
				array_push( _out, _path + _file );
			_file	= file_find_next();
			
		}
		file_find_close();
		
		return _out;
		
	}
	var _mask		= filename_name( _path );
	var _list		= [];
	var _dirs		= [];
	
	if ( _mask == "" )
		_mask	= "*.*";
	
	array_push( _dirs, filename_dir( _path ));
	
	while ( array_length( _dirs ) > 0 ) {
		var _dir	= array_pop( _dirs );
		if ( _dir != "" )
			_dir	+= "/";
		
		if ( _sub )
			_dirs = array_union( _dirs, read( _dir + "*", fa_directory, directory_exists ));
		_list = array_union( _list, read( _dir + _mask, fa_none ));
		
	}
	array_sort( _list, function( _a, _b ) {
		var _sa = string_count( "/", _a );
		var _sb = string_count( "/", _b );
		
		if ( _sa == _sb ) // slashes match, alphabetical
			return _a > _b ? 1 : - 1;
		return _sa > _sb ? 1 : -1; // otherwise more slashes is later
		
	});
	return _list;
	
}
