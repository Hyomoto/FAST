/// @func ScriptFile
/// @param filename
/// @param *read_only
function ScriptFile( _filename, _readonly ) : File( _filename, _readonly ) constructor {
	static formatter	= ScriptManager().formatter;
	static discard		= function() {
		ds_list_destroy( list );
		
	};
	static readSuper	= read;
	static read		= function() {
		var _read	= readSuper();
		
		if ( _read != undefined ) {
			line	= _read.line;
			//name	= _read.file;
			
			return _read.value;
			
		}
		return undefined;
		
	}
	// closes the file, preserving changes
	static closeSuper	= close;
	static close	= function() {
		if ( writable ) {
			var _file	= file_text_open_write( name );
			
			var _i = 0; repeat( ds_list_size( list ) ) {
				file_text_write_string( _file, list[| _i++ ] );
				file_text_writeln( _file );
				
			}
			file_text_close( _file );
			
		} else {
			log_notify( undefined, "ScriptFile.close", "Close called on read only file. Ignored." );
			
		}
		closeSuper();
		
	}
	static toString	= function() {
		return name + " (line " + string( line ) + ")";
		
	}
	static load	= function( _filename ) {
		static fragment	= function( _string, _line ) constructor {
			static toString	= function() {
				return value;
				
			}
			value	= _string;
			line	= _line;
			
		}
		formatter.comment	= false;
		
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
			
			_read	= formatter.format( string_trim( _read ) );
			
			while ( _read != "" ) {
				_pos	= string_pos( "\n", _read );
				
				if ( _pos == 0 && _read != "" ) {
					ds_list_add( list, new fragment( _read, _line ) );
					
					break;
					
				} else if ( _pos > 1 ) {
					ds_list_add( list, new fragment( string_copy( _read, 1, _pos - 1 ), _line ) );
					
				}
				_read	= string_delete( _read, 1, _pos );
				
			}
			
		}
		file_text_close( _file );
		
		lines	= ds_list_size( list );
		name	= _filename;
		
	}
	includes	= 0;
	line		= 0;
	startAt		= 0;
	local		= {};
	
	load( _filename );
	
	var _i = 0; repeat( lines ) {
		list[| _i ].value	= new ScriptExpression( list[| _i ].value );
		
		++_i;
		
	}
	
}
