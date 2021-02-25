/// @func File
/// @param {bool}	read_only	optional: whether or not this file should be written to, default: false
/// @desc	A generic file handling interface, should be inherited by new file types to ensure compatibility
//		with FAST file handling functions.
/// @example
// var _file = new File();
// 
// _file.write( "Hello World!" );
/// @wiki Core-Index Files
function File( _readonly ) : GenericOutput() constructor {
	/// @desc Resets the read position of the file back to the start.
	static reset	= function() {
		next	= 0;
		
	}
	/// @returns inp
	/// @desc Returns the "size" of the file. Context relies on the type of file.
	static size		= function() {
		if ( contents != undefined ) { return ds_list_size( contents ); }
		
	}
	/// @returns bool
	/// @desc Returns `true` if the source file exists.
	static exists	= function() {
		if ( contents == undefined || name == undefined || file_exists( name ) == false ) {
			return false;
			
		} else {
			return true;
			
		}
		
	}
	/// @returns mixed || null
	/// @desc Advances the position in the file and returns the next piece of it, or `undefined` if
	//		the end of file has been reached.
	static read		= function() {
		if ( contents != undefined && next < size() ) {
			return contents[| next++ ];
			
		}
		return undefined;
		
	}
	/// @returns mixed || null
	/// @desc Returns the data located in the file a the given index, or `undefined` if it doesn't exist.
	static peek		= function( _index ) {
		if ( contents != undefined && _index >= 0 && _index < size() ) {
			return contents[|  _index  ];
			
		}
		return undefined;
		
	}
	/// @desc Inserts the given value into the file at the given index.
	static poke		= function( _index, _value ) {
		if ( writable == false || contents == undefined ) { return; }
		
		if ( _index >= 0 && _index < size() ) {
			contents[| _index ]	= _value;
			
		}
		
	}
	/// @returns mixed
	/// @desc Writes the given value to the end of the file.
	static write	= function( _value ) {
		if ( writable == false || contents == undefined ) { return; }
		
		ds_list_add( contents, _value );
		
	}
	/// @returns inp
	/// @desc Returns how many more reads() until the end of file.
	static remaining= function() {
		return size() - next;
		
	}
	/// @desc Returns whether or not the end of the file has been reached.
	/// @returns bool
	static eof		= function() {
		return next	== size();
		
	}
	/// @returns bool
	/// @desc Returns `true` if file is writable, otherwise logs a file handling error. Inheritable
	//		by child structs to check if the file is wirtable.
	static save			= function() {
		if ( exists() && writable && contents != undefined ) {
			return true;
			
		}
		FileManager().log( instanceof( self ) + ".save() called on ", name, ", which ", ( contents == undefined ? "has been closed" : "is a read only file" ), ". Ignored." );
		
		return false;
		
	}
	/// @desc Saves and cleans up the internal structures so the File can be garbage-collected safely.
	static close	= function() {
		save();
		discard();
		
	}
	/// @desc Cleans up the internal structures so the File can be garbage-collected safely.
	static discard		= function() {
		if ( contents != undefined ) { ds_list_destroy( contents ); }
		
		contents	= undefined;
		
	};
	/// @desc Clears the file, thus making it "empty".
	static clear	= function() {
		if ( contents != undefined ) { ds_list_clear( contents ); }
		
	}
	static is		= function( _data_type ) {
		return _data_type == File;
		
	}
	static toArray	= function() {
		var _array	= array_create( size() );
		
		var _i = 0; repeat( size() ) {
			_array[ _i ] = contents[| _i ];
			
			++_i;
			
		}
		return _array;
		
	}
	static toString	= function() {
		return name;
		
	}
// # Variable Declaration	
	writable	= ( _readonly != true ? true : false );
	contents	= ds_list_create();
	next		= 0;
	saveIndex	= 0;
	
}
