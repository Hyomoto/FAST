/// @func File
/// @param {string}	filename	the name of the file to load
/// @param *read_only
/// @desc	generic File handling object
function File( _filename, _readonly ) : GenericOutput() constructor {
// # Method Declaration
	static reset	= function() {
		last	= 0;
		
	}
	static exists	= function( _filename ) {
		if ( _filename == undefined || file_exists( _filename ) == false ) {
			log_notify( undefined, "File", "\"", _filename, "\" not found." );
			
			return false;
			
		} else {
			return true;
			
		}
		
	}
	static read		= function() {
		if ( last < lines ) {
			return list[| last++ ];
			
		}
		return undefined;
		
	}
	static peek		= function( _index ) {
		if ( _index >= 0 && _index < lines ) {
			return list[|  _index  ];
			
		}
		return undefined;
		
	}
	static poke		= function( _index, _value ) {
		if ( _index >= 0 && _index < lines ) {
			list[| _index ]	= _value;
			
		}
		
	}
	static write	= function( _value ) {
		if ( writable == false ) {
			log_notify( undefined, instanceof( self ) + ".write", "Called on ", name, ", which is a read only file. Ignored." );
			
			return;
			
		}
		ds_list_add( list, _value );
		
	}
	static remaining= function() {
		return lines - last;
		
	}
	static eof		= function() {
		return last	== lines;
		
	}
	// closes the file, preserving changes
	static close	= function() {
		discard();
		
	}
	// closes the file, discarding changes
	static discard		= function() {
		ds_list_destroy( list );
		
	};
	static clear	= function() {
		ds_list_clear( list );
		
	}
	static toArray	= function() {
		var _array	= array_create( lines );
		
		var _i = 0; repeat( lines ) {
			_array[ _i ] = list[| _i ];
			
			++_i;
			
		}
		return _array;
		
	}
	static toString	= function() {
		return name + " (lines " + string( lines ) + ")";
		
	}
// # Variable Declaration
	writable	= ( _readonly == undefined ? true : _readonly == false );
	name		= _filename;
	list		= ds_list_create();
	last		= 0;
	lines		= 0;
	
}
