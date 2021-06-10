/// @func runtime_version_as_struct
/// @param {string}	version	The version to return as a struct
/// @desc	Returns the a struct with major, minor, patch and build fields.
function runtime_version_as_struct( _string ) {
	static __parser = new Parser();
	static __list	= [ "major", "minor", "patch", "build" ];
	
	__parser.parser( __parser );
	
	var _version	= {
		equal_to_or_greater	: function( _a, _b, _c, _d ) {
			if ( _a != undefined && _a < major ) { return false; }
			if ( _b != undefined && _b < minor ) { return false; }
			if ( _c != undefined && _c < patch ) { return false; }
			if ( _d != undefined && _d < build ) { return false; }
			return true;
			
		}
		
	};
	__parser.divider	= "."
	
	var _i = 0; repeat( array_length( __list ) ) {
		_version[$ __list[ _i++ ] ]	= __parser.has_next() ? real( __parser.next() ) : 0;
		
	}
	return _version;
	
}
