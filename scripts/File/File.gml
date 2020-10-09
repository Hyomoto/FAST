/// @func File
/// @param {string}	filename	the name of the file to load
/// @param *read_only
/// @desc	generic File handling object
function File( _filename, _readonly ) : GenericOutput() constructor {
// # Method Declaration
	static reset	= function() {
		last	= 0;
		
	}
	static size		= function() {
		return lines;
		
	}
	static exists	= function( _filename ) {
		if ( _filename == undefined || file_exists( _filename ) == false ) {
			return false;
			
		} else {
			return true;
			
		}
		
	}
	static read		= function() {
		if ( last < lines ) {
			return contents[| last++ ];
			
		}
		return undefined;
		
	}
	static peek		= function( _index ) {
		if ( _index >= 0 && _index < lines ) {
			return contents[|  _index  ];
			
		}
		return undefined;
		
	}
	static poke		= function( _index, _value ) {
		if ( _index >= 0 && _index < lines ) {
			contents[| _index ]	= _value;
			
		}
		
	}
	static write	= function( _value ) {
		ds_list_add( contents, _value );
		++lines;
		
	}
	static remaining= function() {
		return lines - last;
		
	}
	static eof		= function() {
		return last	== lines;
		
	}
	// writes the file to disk
	static save			= function( _append ) {
		if ( writable ) {
			return true;
			
		} else {
			log_notify( undefined, instanceof( self ) + ".close", "Called on ", name, ", which is a read only file. Ignored." );
			
		}
		return false;
		
	}
	// saves and closes the file
	static close	= function() {
		save();
		destroy();
		
	}
	// closes the file without saving it
	static destroy		= function() {
		ds_list_destroy( contents );
		
	};
	static clear	= function() {
		ds_list_clear( contents );
		
	}
	static is		= function( _data_type ) {
		return _data_type == File;
		
	}
	static toArray	= function() {
		var _array	= array_create( lines );
		
		var _i = 0; repeat( lines ) {
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
	name		= _filename;
	contents	= ds_list_create();
	last		= 0;
	lines		= 0;
	saveIndex	= 0;
	
}
