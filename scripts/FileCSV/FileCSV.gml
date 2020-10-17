/// @func FileCSV
/// @param {string}	filename	the name of the file to open
/// @param {bool}	read_only?	optional: whether this file should allow writing to. Default: true
/// @param {bool}	new?		optional: whether this file should be blank. Default: false
/// @wiki Core-Index Files
function FileCSV( _filename, _readonly, _new ) : File( _readonly ) constructor {
	/// @returns string || null
	/// @desc Reads the next value in the file, if it exists, otherwise returns `undefined`.
	static read		= function() {
		while ( next < size() && readIndex == array_length( contents[| next ] ) ) {
			readIndex = 0;
			++next;
			
		}
		if ( next < size() ) {
			return array_get( contents[| next ], readIndex++ );
			
		}
		return undefined;
		
	}
	/// @param {mixed}	values...	The values to write to the file
	/// @desc	Writes `value` to the end of the file
	static write	= function( _value ) {
		if ( size() == 0 ){ ds_list_add( contents, [] ); }
		
		var _i = 0; repeat( argument_count ) {
			var _point	= array_length( contents[| writeIndex ] );
			
			array_set( contents[| writeIndex ], _point, argument[ _i++ ] );
			
		}
		
	}
	/// @desc	Starts a new line in the file.
	static writeln	= function() {
		ds_list_add( contents, [] );
		
		++writeIndex;
		
	}
	/// @override
	static poke_File	= poke;
	/// @override
	static poke	= function( _index, _value ) {
		poke_File( _index, _value );
		
		++writeIndex;
		
	}
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
				var _string, _source;
				
				var _i = ( _append == true ? saveIndex : 0 ); repeat( size() - _i ) {
					_source	= contents[| _i++ ];
					_string	= "";
					
					var _j = 0; repeat( array_length( _source ) ) {
						if ( _j > 0 ) { _string += ", "; }
						
						_string	+= string( _source[ _j++ ] );
						
					}
					file_text_write_string( _file, _string );
					file_text_writeln( _file );
					
				}
				saveIndex	= _i;
				
				file_text_close( _file );
				
			}
			
		}
		
	}
	/// @override
	name	= _filename;
	/// @desc The point at which the file is currently being written to.
	writeIndex	= 0;
	/// @desc The index at which the file is currently being read from.
	readIndex	= 0;
	
	if ( _new != true && exists() ) {
		var _parser	= new Parser();
		// @ignore
		_parser.divider	= ",";
		
		var _file	= file_text_open_read( _filename );
		
		while ( file_text_eof( _file ) == false ) {
			_parser.parse( string_trim( file_text_read_string( _file ) ) ); file_text_readln( _file );
			
			if ( _parser.has_next() == false ) { continue; }
			
			while ( _parser.has_next() ) {
				write( _parser.next() );
				
			}
			writeln();
			
		}
		file_text_close( _file );
		
		saveIndex	= size();
		writeIndex	= size();
		
	}
	
}