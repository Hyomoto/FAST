/// @func File
/// @param *read_only
/// @desc	generic File handling object
/// @example
// var _file = new File();
// 
// _file.write( "Hello World!" );
/// @wiki File-Handling-Index
function File( _readonly ) : GenericOutput() constructor {
// # Method Declaration
	static reset	= function() {
		next	= 0;
		
	}
	static size		= function() {
		return ds_list_size( contents );
		
	}
	static exists	= function() {
		if ( name == undefined || file_exists( name ) == false ) {
			return false;
			
		} else {
			return true;
			
		}
		
	}
	static read		= function() {
		if ( next < size() ) {
			return contents[| next++ ];
			
		}
		return undefined;
		
	}
	static peek		= function( _index ) {
		if ( _index >= 0 && _index < size() ) {
			return contents[|  _index  ];
			
		}
		return undefined;
		
	}
	static poke		= function( _index, _value ) {
		if ( writable == false ) { return; }
		
		if ( _index >= 0 && _index < size() ) {
			contents[| _index ]	= _value;
			
		}
		
	}
	static write	= function( _value ) {
		if ( writable == false ) { return; }
		
		ds_list_add( contents, _value );
		
	}
	static remaining= function() {
		return size() - next;
		
	}
	static eof		= function() {
		return next	== size();
		
	}
	// returns true if file is writable, inheritable by structs that inherit File
	static save			= function() {
		if ( writable ) {
			return true;
			
		} else {
			FileManager().log( undefined, instanceof( self ) + ".save", "Called on ", name, ", which is a read only file. Ignored." );
			
		}
		return false;
		
	}
	// saves and destroys the file
	static close	= function() {
		save();
		discard();
		
	}
	// closes the file without saving it
	static discard		= function() {
		ds_list_destroy( contents );
		
	};
	static clear	= function() {
		ds_list_clear( contents );
		
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
	writable	= ( _readonly == undefined ? true : _readonly == false );
	contents	= ds_list_create();
	next		= 0;
	saveIndex	= 0;
	
}
