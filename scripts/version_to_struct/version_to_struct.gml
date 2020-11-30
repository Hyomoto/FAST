/// @func version_to_struct
/// @param {string}	version	The version to return as a struct
/// @desc	Returns the a struct with major, minor, patch and build fields.
function runtime_version_as_struct( _string ) {
	var _parser	= new Parser( _string );
	var _version	= {
		equal_to_or_greater	: function( _a, _b, _c, _d ) {
			if ( _a != undefined && _a < major ) { return false; }
			if ( _b != undefined && _b < minor ) { return false; }
			if ( _c != undefined && _c < patch ) { return false; }
			if ( _d != undefined && _d < build ) { return false; }
			return true;
			
		}
		
	};
	_parser.divider	= "."
	
	_version.major	= real( _parser.next() );
	_version.minor	= real( _parser.next() );
	_version.patch	= real( _parser.next() );
	_version.build	= real( _parser.next() );
	
	return _version;
	
}
