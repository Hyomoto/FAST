/// @func FileText
/// @param filename
/// @param *read_only
function FileText( _filename, _readonly ) : File( _filename, _readonly ) constructor {
	// closes the file, preserving changes
	static closeSuper	= close;
	static close	= function() {
		if ( writable ) {
			var _file	= file_text_open_write( name );
			
			if ( _file == -1 ) {
				log_notify( undefined, instanceof( self ) + ".close", "Could not write to ", name, ". Ignored." );
				
			} else {
				var _i = 0; repeat( ds_list_size( list ) ) {
					file_text_write_string( _file, list[| _i++ ] );
					file_text_writeln( _file );
				
				}
				file_text_close( _file );
				
				syslog( name );
				
			}
			
		} else {
			log_notify( undefined, instanceof( self ) + ".close", "Called on ", name, ", which is a read only file. Ignored." );
			
		}
		closeSuper();
		
	}
	if ( exists( _filename ) == false ) {
		return;
		
	}
	var _file	= file_text_open_read( _filename );
	var _string, _last;
	
	while ( file_text_eof( _file ) == false ) {
		_string	= file_text_read_string( _file ); file_text_readln( _file );
		_last	= 0;
		
		ds_list_add( list, _string );
		
	}
	file_text_close( _file );
	
	lines	= ds_list_size( list );
	
}
