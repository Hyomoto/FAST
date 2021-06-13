/// @func struct_type
/// @param {struct}	struct	The struct to compare
/// @param {type}	type	The type to compare it against
/// @desc	Returns true if the provided struct was of the type given.  If the provided value was not a
///		struct, false is returned.  If the struct inherited from __Struct__ then __Type__ will be checked,
///		otherwise a direct string comparison is used.
/// @retuns bool
/// @wiki Core-Index Functions
function struct_type( _struct, _type ) {
	if ( is_struct( _struct ) == false ) { return false; }
	
	var _is	= _struct[$ "__Type__" ];
	
	if ( _is == undefined ) {
		if ( instanceof( _struct ) == script_get_name( _type ) ) { return true; }
		
	}
	return _is[$ string( _type ) ] == 1;
	
}
