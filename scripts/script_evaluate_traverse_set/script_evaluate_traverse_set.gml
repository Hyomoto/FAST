/// @func script_evaluate_traverse_set
/// @param engine
/// @param package
/// @param path
/// @param *set
function script_evaluate_traverse_set( _engine, _package, _string, _set ) {
	var _path	= string_explode( _string, ".", false );
	var _ref, _i = 0;
	// seek
	if ( variable_struct_exists( _package, _path[ 0 ] ) || local ) {
		_ref	= _package;
		
	} else {
		if ( array_length( _path ) == 1 ) {
			return _engine.set_value( _path[ 0 ], _set );
			
		}
		_ref	= _engine.get_value( _path[ 0 ] );
		_i		= 1;
		
	}
	// then ref
	repeat( max( 0, array_length( _path ) - 1 - _i ) ) {
		if ( _ref == undefined ) {
			if ( _package.script != undefined ) {
				throw( _package.script.source + " failed at line " + string( _package.statement.line + _package.script.isFunction ) + " because " + string( _path[ _i ] ) + " could not be found!" );
				
			}
			throw( "Expression could not be evaluated because " + string( _path[ _i ] ) + " could not be found!" );
			
		}
		// recurse
		if ( is_struct( _ref ) ) {
			_ref	= variable_struct_get( _ref, _path[ _i++ ] );
			
		} else if ( instance_exists( _ref ) ) {
			_ref	= variable_instance_get( _ref, _path[ _i++ ] );
			
		} 
		
	}
	if ( is_struct( _ref ) ) {
		variable_struct_set( _ref, _path[ _i ], _set );
		
	} else if ( _ref != undefined && instance_exists( _ref ) ) {
		variable_instance_set( _ref, _path[ _i ], _set );
		
	} else {
		if ( _package.script != undefined ) {
			throw( _package.script.source + " failed at line " + string( _package.statement.line + _package.script.isFunction ) + " because " + string( _path[ _i ] ) + " could not be found!" );
			
		}
		throw( "Expression could not be evaluated because " + string( _path[ _i ] ) + " could not be found!" );
		
	}
	
}
//	var _set	= ( argument_count > 3 ? argument[ 3 ] : undefined );
//	var _rep	= array_length( _path ) - 1;
//	var _lookup = undefined;
	
//	if ( _rep == 0 ) {
//		if ( variable_struct_exists( _package.local, _path[ _i ] ) || local ) {
//			if ( argument_count > 3 ) {
//				variable_struct_set( _package.local, _path[ _i ], _set );
				
//			} else { 
//				return variable_struct_get( _package.local, _path[ _i ] );
				
//			}
			
//		} else {
//			if ( argument_count > 3 ) {
//				_engine.set_value( _path[ _i ], _set );
				
//			} else {
//				return _engine.get_value( _path[ _i ] )
			
//		}
	
//	} else {
//		if ( variable_struct_exists( _package.local, _path[ _i ] ) || local ) {
//			_lookup	= variable_struct_get( _package.local, _path[ _i ] );
			
//		}
//		_lookup	= _engine.get_value( _path[ _i ] );
		
//		var _i = 0; repeat( _rep ) {
//			if ( is_struct( _lookup ) == false && instance_exists( _lookup ) == false ) {
//				_engine.errors.push( [ "script_evaluate_traverse", "Could not traverse " + array_to_string( _path, "." ) + ". Failed." ] );
				
//				return;
				
//			}
			
//		}
		
//	}
	
//}
