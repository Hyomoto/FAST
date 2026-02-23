function file_text_read( _filename ) {
	if ( file_exists( _filename ) == false )
		throw new Exception( $"file_text_read: filename '{_filename}' doesn't exist." );
	var _buffer	= buffer_load( _filename );
	var _text	= buffer_read( _buffer, buffer_text );
	buffer_delete( _buffer );
	return string_replace_all( _text, "\r", "" );
	
}
