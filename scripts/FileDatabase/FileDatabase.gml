/// @func FileDatabase
/// @param filename
/// @param *read_only
/// @wiki Database-Index File
function FileDatabase( _filename, _readonly, _new ) : File( _readonly ) constructor {
	static fragment	= function( _string, _file, _line ) constructor {
		static toString	= function() {
			return value;
			
		}
		value	= _string;
		file	= _file;
		line	= _line;
		
	}
	static write_File	= write;
	static write	= function( _value ) {
		write_File( new fragment( _value, name, size() ) );
		
	}
	static read_File	= read;
	static read		= function() {
		var _read	= read_File();
		
		if ( _read != undefined ) {
			line	= _read.line;
			name	= _read.file;
			
			return _read.value;
			
		}
		return undefined;
		
	}
	// closes the file, preserving changes
	static save_File	= close;
	static save	= function() {
		if ( save_File() ) {
			var _file	= file_text_open_write( name );
			
			var _i = 0; repeat( ds_list_size( contents ) ) {
				file_text_write_string( _file, contents[| _i++ ].value );
				file_text_writeln( _file );
				
			}
			file_text_close( _file );
			
		}
		
	}
	static toString	= function() {
		return name + " (line " + string( line ) + ")";
		
	}
	includes	= 0;
	line		= 0;
	
	if ( _new != true ) {
		if ( exists() == false ) { return; }
		
		var _formatter	= DatabaseManager().formatter;
		var _name	= filename_name( _filename );
		var _file	= file_text_open_read( _filename );
		var _line	= 0;
		var _read, _last, _pos;
		
		while ( file_text_eof( _file ) == false ) {
			_read	= file_text_read_string( _file ); file_text_readln( _file );
			_last	= 0;
			++_line;
			
			if ( string_copy( _read, 1, 9 ) == "#include " ) {
				var _path	= filename_path( _filename );
				
				if ( string_char_at( _read, 10 ) == "\\" ) {
					_path	+= string_delete( _read, 1, 10 );
					
				} else {
					_path	= string_delete( _read, 1, 9 );
					
				}
				if ( load( _path ) ) {
					++includes;
					
				}
				continue;
				
			}
			_read	= _formatter.format( _read );
			
			while ( _read != "" ) {
				_pos	= string_pos( "\n", _read );
				
				if ( _pos == 0 ) {
					ds_list_add( contents, new fragment( _read, _name, _line ) );
					
					break;
					
				} else if ( _pos > 1 ) {
					ds_list_add( contents, new fragment( string_copy( _read, 1, _pos - 1 ), _name, _line ) );
					
				}
				_read	= string_delete( _read, 1, _pos );
				
			}
			
		}
		file_text_close( _file );
		
	}
	
}
