// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function runtime_version_as_struct() {
	static version	= undefined;
	
	if ( version == undefined ) {
		var _parser	= new Parser( GM_runtime_version );
		_parser.divider	= "."
		
		version	= {};
		version.major	= _parser.next();
		version.minor	= _parser.next();
		version.patch	= _parser.next();
		version.build	= _parser.next();
		
	}
	return version;
	
}
