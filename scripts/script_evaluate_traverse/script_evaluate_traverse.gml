/// @func script_evaluate_traverse
/// @param engine
/// @param package
/// @param path
/// @param *stop
/// @wiki Scripting-Index
function script_evaluate_traverse( _engine, _package, _string ) {
	var _path	= string_explode( _string, ".", false );
	var _stop	= ( argument_count == 3 ? array_length( _path ) : argument[ 3 ] );
	var _ref, _i = 0;
	
	if ( _path[ 0 ] == "global" ) {
		if ( array_length( _path ) < 2 ) {
			throw( ( _package.script == undefined ? "Expression failed because " : _package.script.source + " failed at line " + string( _package.statement.line + _package.script.isFunction ) + " because " ) + "global can not be used as a variable!" );
			
		}
		if ( _stop < 2 ) { return; }
		
		_ref	= variable_global_get( _path[ 1 ] );
		_i		= 2;
		
	} else if ( variable_struct_exists( _package.local, _path[ 0 ] ) ) {
		_ref	= _package.local;
		
	} else {
		_ref	= _engine.values;
		
	}
	try {
		repeat( _stop - _i ) {
			_ref	= variable_traverse_string( _ref, _path[ _i ] );
			
			++_i;
			
		}
	} catch ( _ex ) {
		var _header	= ( _package.script == undefined ? "Expression failed because " : _package.script.source + " failed at line " + string( _package.statement.line + _package.script.isFunction ) + " because " );
		
		if ( is_struct( _ex ) ) {
			throw( _header + _ex.longMessage );
		 
		}
		throw( _header + _ex );
		
	}
	return _ref;
	
}
