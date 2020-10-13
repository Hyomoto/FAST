/// @func FileText
/// @param filename
/// @param *read_only
/// @param *new?
/// @wiki File-Handling-Index
function FileText( _filename, _readonly, _new ) : File( _readonly ) constructor {
	// @override
	static save_File	= save;
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
