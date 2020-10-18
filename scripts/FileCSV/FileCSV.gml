/// @func FileCSV
/// @param {string}	filename	the name of the file to open
/// @param {bool}	read_only?	optional: whether this file should allow writing to. Default: true
/// @param {bool}	new?		optional: whether this file should be blank. Default: false
/// @desc	Used for creating, reading and saving to CSV files. Files are written on a per-column basis, and
//		you must use writeln() to advance to a new row.  Reading is also on a per-column basis, and you can
//		check if you have reached the end of the row by calling eol().
/// @example
// // writing
//var _csv = new FileCSV( "my.csv", true, true );
//
//_csv.write( "Sword", 10, 10 );
//_csv.writeln( "Armor", 20, 30 );
//
//_csv.close();
//
// // reading
//var _csv	= new FileCSV( "my.csv", true, false );
//
//show_debug_message( _csv.read() );
//// Sword
//_csv.readln();
//// Armor
//show_debug_message( _csv.red() );
/// @wiki Core-Index Files
function FileCSV( _filename, _readonly, _new ) : File( _readonly ) constructor {
	/// @returns real || string || null
	/// @desc Reads the next value in the file, if it exists, otherwise returns `undefined`.
	static read		= function() {
		while ( next < size() && eol() ) {
			readln();
			
		}
		if ( next < size() ) {
			var _value	= array_get( contents[| next ], readIndex++ );
			
			if ( string_byte_at( _value, 1 ) >= 0x30 && string_byte_at( _value, 1 ) <= 0x39 ) {
				return string_to_real( _value );
				
			}
			return _value;
			
		}
		return undefined;
		
	}
	/// @desc Advances the read position to the next line
	static readln	= function() {
		if ( eof() == false ) {
			readIndex	= 0;
			++next;
			
		}
		
	}
	/// @param {mixed}	values...	The values to write to the file
	/// @desc	Writes `value` to the end of the file
	static write	= function( _value ) {
		var _i = 0; repeat( argument_count ) {
			var _point	= array_length( contents[| writeIndex ] );
			
			array_set( contents[| writeIndex ], _point, argument[ _i++ ] );
			
		}
		
	}
	/// @desc	Starts a new line in the file.
	static writeln	= function() {
		ds_list_add( contents, [] );
		
		writeIndex = size() - 1;
		
	}
	/// @desc Returns `true` if the end of the current line has been reached
	/// @returns bool
	static eol	= function() {
		return eof() || readIndex == array_length( contents[| next ] );
		
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
			writeln();
			
			_parser.parse( string_trim( file_text_read_string( _file ) ) ); file_text_readln( _file );
			
			if ( _parser.has_next() == false ) { continue; }
			
			while ( _parser.has_next() ) {
				write( _parser.next() );
				
			}
			
		}
		file_text_close( _file );
		
		saveIndex	= size();
		writeIndex	= size();
		
	} else {
		writeln();
		
	}
	
}