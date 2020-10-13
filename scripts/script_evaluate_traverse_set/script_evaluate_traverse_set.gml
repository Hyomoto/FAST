/// @func script_evaluate_traverse_set
/// @param engine
/// @param package
/// @param path
/// @param *set
/// @wiki Scripting-Index
function script_evaluate_traverse_set( _engine, _package, _string, _set ) {
	var _path	= string_explode( _string, ".", false );
	var _header	= ( _package.script == undefined ? "Expression could not be evaluated because " : _package.script.source + " failed at line " + string( _package.statement.line + _package.script.isFunction ) + " because " );
	var _ref	= script_evaluate_traverse( _engine, _package, _string, array_length( _path ) - 1 );
	var _key	= _path[ array_length( _path ) - 1 ];
	
	if ( array_length( _path ) == 1 && local ) {
		_ref	= _package.local;
		
	}
	if ( _path[ 0 ] == "global" ) {
		variable_global_set( _key, _set );
		
	} else if ( is_struct( _ref ) ) {
		variable_struct_set( _ref, _key, _set );
		
	} else if ( instance_exists( _ref ) ) {
		variable_instance_set( _ref, _key, _set );
		
	} else {
		throw( _header + "instance " + string( _ref ) + " doesn't exist!" );
		
	}
		
}
