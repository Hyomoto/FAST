/// @func script_evaluate_traverse
/// @param engine
/// @param package
/// @param path
/// @param *stop
function script_evaluate_traverse( _engine, _package, _string ) {
	static __ref_get	= function( _ref, _string ) {
		if ( is_struct( _ref ) ) {
			if ( variable_struct_exists( _ref, _string ) ) {
				return variable_struct_get( _ref, _string ); }
				
			throw( "struct variable " + _string + " is undeclared." );
			
		} else if ( instance_exists( _ref ) ) {
			if ( variable_instance_exists( _ref, _string ) ) {
				return variable_instance_get( _ref, _string ) }
				
			throw( "instance variable " + object_get_name( _ref.object_index ) + "(" + string( _ref ) + ")." + _string + " is undeclared." );
			
		}
		throw( "reference " + string( _ref ) + " couldn't be found." );
		
	}
	var _path	= string_explode( _string, ".", false );
	var _stop	= ( argument_count == 3 ? array_length( _path ) : argument[ 3 ] );
	var _ref;
	
	if ( variable_struct_exists( _package.local, _path[ 0 ] ) ) {
		_ref	= _package.local;
		
	} else {
		_ref	= _engine.values;
		
	}
	try {
		var _i = 0; repeat( _stop ) {
			_ref	= __ref_get( _ref, _path[ _i++ ] );
			
		}
	} catch ( _ex ) {
		var _header	= ( _package.script == undefined ? "Expression failed because " : _package.script.source + " failed at line " + string( _package.statement.line + _package.script.isFunction ) + " because " );
		
		throw( _header + _ex );
		
	}
	return _ref;
	
}
