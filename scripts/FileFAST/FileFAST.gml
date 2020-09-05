/// @func FileFAST
/// @param filename
/// @param *read_only
function FileFAST( _filename, _readonly ) : File( _filename, _readonly ) constructor {
	static FASTformatter	= new StringFormatter( " :strip,	:strip,\":save,{:push,}:pull+push,;:strip+push,+:pull", {
		setup : function( _input ) {
			flag = 0;
			
			if ( string_pos( "//", _input.value ) > 0 ) {
				_input.value	= string_copy( _input.value, 1, string_pos( "//", _input.value ) - 1 );
				
			}
			if ( string_pos( "/*", _input.value ) > 0 ) {
				comment	= true;
				
				_input.value	= string_copy( _input.value, 1, string_pos( "/*", _input.value ) - 1 );
				
			}
			if ( string_pos( "*/", _input.value ) > 0 ) {
				comment	= false;
				
				_input.value	= string_delete( _input.value, 1, string_pos( "*/", _input.value ) + 1 );
				
			} 
			if ( comment ) {
				return "";
				
			}	
			
		},
		pre : function( _rules ) {
			if ( string_pos( "save", _rules ) > 0 ) {
				flag |= 2;
				
			} else {
				flag ^= flag & 2;
				
			}
			
		},
		strip : function( _input ) {
			if ( flag & 1 && flag & 2 == 0 ) { return; }
			
			_input.value	= string_delete( _input.value, last--, 1 );
			
		},
		skip : function( _input ) {
			if ( flag & 1 && flag & 2 == 0 ) { return; }
			
			last++;
			
		},
		push : function( _input ) {
			if ( flag > 0 && flag & 2 == 0 ) { return; }
			
			_input.value	= string_insert( "\n", _input.value, ++last );
			
		},
		pull : function( _input ) {
			if ( flag > 0 && flag & 2 == 0 ) { return _input; }
			
			_input.value	= string_insert( "\n", _input.value, last++ );
			
		},
		save : function() {
			flag	^= 1;
			
		}
		
	});
	FASTformatter.comment	= false;
	
	static readSuper	= read;
	static read		= function() {
		var _read	= readSuper();
		
		if ( _read != undefined ) {
			line	= _read.line;
			name	= _read.file;
			
			return _read.value;
			
		}
		return undefined;
		
	}
	// closes the file, preserving changes
	static closeSuper	= close;
	static close	= function() {
		if ( writable ) {
			var _file	= file_text_open_write( name );
			
			var _i = 0; repeat( ds_list_size( contents ) ) {
				file_text_write_string( _file, contents[| _i++ ] );
				file_text_writeln( _file );
				
			}
			file_text_close( _file );
			
		} else {
			log_notify( undefined, "FileFAST.close", "Close called on read only file. Ignored." );
			
		}
		closeSuper();
		
	}
	static toString	= function() {
		return name + " (line " + string( line ) + ")";
		
	}
	static load	= function( _filename ) {
		static fragment	= function( _string, _file, _line ) constructor {
			static toString	= function() {
				return value;
				
			}
			value	= _string;
			file	= _file;
			line	= _line;
			
		}
		if ( exists( _filename ) == false ) {
			return false;
			
		}
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
			_read	= FASTformatter.format( _read );
			
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
	includes	= 0;
	line		= 0;
	
	load( _filename );
	
	lines	= ds_list_size( contents );
	name	= _filename;
	
}
