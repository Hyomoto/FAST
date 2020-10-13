/// @description write indexes
trace( "Writing indexes..." );

var _files	= file_get_directory( path, "*.md", false );

repeat( _files.size() ) {
	var _file	= _files.dequeue();
	
	if ( string_pos( "-Index", _file ) > 0 ) {
		file_delete( _file );
		
	}
	
}
var _index_key	= ds_map_find_first( table.pages );
var _file, _trim;

while ( _index_key != undefined ) {
	var _index	= table.pages[? _index_key ];
	var _header_key	= ds_map_find_first( _index );
	var _filename	= path + _index_key + ".md";
	
	syslog( _index_key, " found." );
	
	if ( overwrite || file_exists( _filename ) == false ) {
		_trim	= string_replace( _index_key, "-Index", "" )
		
		_file	= new FileText( _filename, false, true );
		_file.write( "|Jump To|[`back`](https://github.com/Hyomoto/FASTv33/wiki/" + _trim + ")|" );
		_file.write( "|---|---|\n\n" );
		
		while ( _header_key != undefined ) {
			var _header	= _index[? _header_key ];
			
			_file.write( "### " + _header_key );
			
			syslog( "    ", _header_key, " found..." );
			
			for ( var _i = ds_list_size( _header ) - 1; _i >= 0; --_i ) {
				var _meta	= _header[| _i ];
				_file.write( "* [" + _meta.name + "](" + _meta.path + ")" );
				syslog( "        ", _meta, " found." );
				
			}
			_header_key	= ds_map_find_next( _index, _header_key );
			
		}
		_file.close();
		
	}
	_index_key	= ds_map_find_next( table.pages, _index_key );
	
}