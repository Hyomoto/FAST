/// @func FileText
/// @param filename
/// @param new?
/// @param *read_only
function FileText( _filename, _new, _readonly ) : File( _filename, _readonly ) constructor {
	static save_File	= save;
	static save	= function( _append ) {
		if ( save_File() ) {
			var _file	= ( _append == true ? file_text_open_append( name ) : file_text_open_write( name ) );
			
			if ( _file == -1 ) {
				log_notify( undefined, instanceof( self ) + ".close", "Could not write to ", name, ". Ignored." );
				
			} else {
				var _i = ( _append == true ? saveIndex : 0 ); repeat( lines - _i ) {
					file_text_write_string( _file, string( contents[| _i++ ] ) );
					file_text_writeln( _file );
					
				}
				saveIndex	= _i;
				
				file_text_close( _file );
				
			}
			
		}
		
	}
	if ( _new == true ) {
		if ( exists( _filename ) ) {
			file_delete( _filename );
			
		}
		
	} else {
		if ( exists( _filename ) == false ) {
			return;
			
		}
		var _file	= file_text_open_read( _filename );
		var _string, _last;
		
		while ( file_text_eof( _file ) == false ) {
			_string	= file_text_read_string( _file ); file_text_readln( _file );
			_last	= 0;
			
			ds_list_add( contents, _string );
			
		}
		file_text_close( _file );
		
		lines	= ds_list_size( contents );
		
	}
	
}
