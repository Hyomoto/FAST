/// @func FileText
/// @param {string}	filename	the name of the file to open
/// @param {bool}	read_only?	optional: whether this file should allow writing to. Default: true
/// @param {bool}	new?		optional: whether this file should be blank. Default: false
/// @desc	Used for creating, reading and saving text files. Files are written on a per-line basis, and
//		calling read() will return the next line in the file.
/// @wiki Core-Index Files
function FileText( _filename, _readonly, _new ) : File( _readonly ) constructor {
	/// @ignore
	static save_File	= save;
	/// @param {bool}	append	Whether to append or rewrite the file.
	/// @desc Saves the file to disk.  If append is `true`, entries will be appended after the last position
	//		the file was written from.
	static save	= function( _append ) {
		if ( save_File() ) {
			var _file	= ( _append == true && saveIndex > 0 ? file_text_open_append( name ) : file_text_open_write( name ) );
			
			if ( _file == -1 ) {
				FileManager().log( undefined, instanceof( self ) + ".close", "Could not write to ", name, ". Ignored." );
				
			} else {
				var _i = ( _append == true ? saveIndex : 0 ); repeat( size() - _i ) {
					file_text_write_string( _file, string( contents[| _i++ ] ) );
					file_text_writeln( _file );
					
				}
				saveIndex	= _i;
				
				file_text_close( _file );
				
			}
			
		}
		
	}
	/// @override
	name	= _filename;
	
	if ( _new != true && exists() ) {
		var _file	= file_text_open_read( _filename );
		var _string, _last;
		
		while ( file_text_eof( _file ) == false ) {
			_string	= file_text_read_string( _file ); file_text_readln( _file );
			_last	= 0;
			
			ds_list_add( contents, _string );
			
		}
		file_text_close( _file );
		
		saveIndex	= size();
		
	}
	
}
