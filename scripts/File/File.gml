/// @func File
/// @param {string}	filename	the name of the file to load
/// @param *read_only
/// @desc	generic File handling object
function File( _filename, _readonly ) : Output() constructor {
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
	static write	= function( _value ) {
		if ( writable == false ) {
			log_notify( undefined, instanceof( self ) + ".write", "Called on ", name, ", which is a read only file. Ignored." );
			
			return;
			
		}
		ds_list_add( list, _value );
		
	}
	static get_line	= function( _line ) {
		if ( _line >= 0 && _line < lines ) {
			return list[| _line ];
			
		}
		return undefined;
		
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
	static toString	= function() {
		return name + " (lines " + string( lines ) + ")";
		
	}
	writable	= ( _readonly == undefined ? true : _readonly == false );
	name		= _filename;
	list		= ds_list_create();
	last		= 0;
	lines		= 0;
	
}
