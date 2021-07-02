/// @func TextFile
/// @desc	A wrapper for text file handling.
/// @example
//var _file = new TextFile().open( "text.txt" );
//
//list.from_input( _file );
/// @output Will open text.txt and read its contents into list
/// @wiki Core-Index Constructors
function TextFile( _new ) : __Stream__() constructor {
	/// @desc	Reads the next portion of the text file and returns it.  If the file is not open,
	///		or the file is not opened for reading, IllegalFileOperation will be thrown.
	/// @throws IllegalFileOperation
	/// @returns mixed or EOF
	static read	= function() {
		if ( is_open() && struct_type( self, __InputStream__ )) {
			if ( finished() ) { return EOF; }
			
			__Buffer	= file_text_read_string( __Id );
			
			file_text_readln( __Id );
			
			return __Buffer;
			
		}
		throw new IllegalFileOperation( "read", "the file is not open for reading." );
		
	}
	/// @param {mixed}	values...	The values to write
	/// @desc	Writes the given values to the file.  If the values are not strings, they will be
	///		converted.  If the file is not open, or the file is not open for writing,
	///		IllegalFileOperation will be thrown.
	/// @throws IllegalFileOperation
	/// @returns self
	static write	= function() {
		if ( is_open() == false || struct_type( self, __OutputStream__ )) {
			var _i = 0; repeat( argument_count ) {
				__Buffer	= argument[ _i++ ];
				
				file_text_write_string( __Id, __Buffer );
				
			}
			return self;
			
		}
		throw new IllegalFileOperation( "close", "the file is not open for writing." );
		
	}
	/// @param {string}	filename	The name and path to the file to open
	/// @param {int}	action		The type of action to take
	/// @desc	Opens the specified file for futher processing.  If action is not specified, the file
	///		will be opened for reading, otherwise FAST_FILE_* should be specified.  If a file is
	///		already opened, it will be closed first.  If the filename is not a string, or action is an
	///		invalid type, InvalidArgumentType will be thrown.  If the file does not exist, FileNotFound
	///		will be thrown.  If too many files are currently open, an IllegalFileOperation will be thrown.
	/// @throws InvalidArgumentType, FileNotFound, IllegalFileOperation
	/// @returns self
	static open	= function( _filename, _action ) {
		if ( _filename == undefined ) { _filename = __Filename; _action = __Operation }
		
		if ( __Id != undefined ) { close(); }
		
		if ( is_string( _filename ) == false ) { throw new InvalidArgumentType( "open", 0, _filename, "string" ); }
		
		var _f	= undefined;
		
		switch ( _action ) {
			case undefined: _action = FAST_FILE_READ;
			case FAST_FILE_READ	: _f = file_text_open_read; break;
			case FAST_FILE_WRITE	: _f = file_text_open_append; break;
			case FAST_FILE_NEW		: _f = file_text_open_write; _action = FAST_FILE_WRITE; break;
			default:
				throw new InvalidArgumentType( "open", 1, _action, "FAST_FILE_*" );
			
		}
		if ( _action == FAST_FILE_READ && file_exists( _filename ) == false ) { throw new FileNotFound( "open", _filename ); }
		
		try {
			__Id	= _f( _filename );
			
		} catch ( _ ) {
			throw new IllegalFileOperation().from_error(_);
			
		}
		switch ( _action ) {
			case FAST_FILE_READ:	__Type__.add( __InputStream__ ); break;
			default:				__Type__.add( __OutputStream__ ); break;
		}
		__Source	= _filename;
		__Operation	= _action;
		
		return self;
		
	}
	/// @desc	Closes this file.  No further processing can take place once closed, and will generate
	///		an error if attempted.  If a file is not current open, IllegalFileOperation is thrown.
	/// @throws IllegalFileOperation
	/// @returns self
	static close	= function() {
		if ( is_open() == false ) { throw new IllegalFileOperation( "close", "the file is not open." ); }
		
		file_text_close( __Id );
		
		switch ( __Operation ) {
			case FAST_FILE_READ:	variable_struct_remove( __Type__, string( __InputStream__ )); break;
			default:					variable_struct_remove( __Type__, string( __OutputStream__ )); break;
		}
		__Id		= undefined;
		
		return self;
		
	}
	/// @desc	Returns true if the end of the file has been reached.  If the file isn't open, or the
	///		file isn't open for reading, IllegalFileOperation will be thrown.
	/// @throws IllegalFileOperation
	/// @returns bool
	static finished		= function() {
		if ( is_open() && struct_type( self, __InputStream__ ) ) {
			return file_text_eof( __Id );
			
		}
		throw new IllegalFileOperation( "finished", "the file isn't open for reading." );
		
	}
	/// @var {struct}	The pointer that is returned when the end of file is reached
	/// @output constant
	static EOF	= {}
	/// @var {int}		The type of operation being performed on this file
	__Operation	= undefined;
	
	__Type__.add( TextFile );
	
}
