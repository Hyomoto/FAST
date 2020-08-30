/// @func script_evaluate_traverse
/// @param engine
/// @param package
/// @param path
/// @param *set
function script_evaluate_traverse( _engine, _package, _string ) {
	static __internal_seek	= function( _engine, _ref, _target ) {
		
		return undefined;
		
	}
	var _path	= string_explode( _string, ".", false );
	var _ref, _i = 0;
	
	// seek
	if ( variable_struct_exists( _package, _path[ 0 ] ) ) {
		_ref	= _package;
		
	} else {
		if ( array_length( _path ) == 1 ) {
			return _engine.get_value( _path[ 0 ] );
			
		}
		_ref	= _engine.get_value( _path[ 0 ] );
		_i		= 1;
		
	}
	// then ref
	repeat( max( 0, array_length( _path ) - _i ) ) {
		if ( _ref == undefined ) {
			_engine.errors.push( [ "script_evaluate_traverse", "Path could not be traversed at \"" + _path[ _i ] + "\". Failed." ] );
			
			return;
			
		}
		// recurse
		if ( is_struct( _ref ) && variable_struct_exists( _ref, _path[ _i ] ) ) {
			_ref	= variable_struct_get( _ref, _path[ _i ] );
			
		} else if ( instance_exists( _ref ) && variable_instance_exists( _ref, _path[ _i ] ) ) {
			_ref	= variable_instance_get( _ref, _path[ _i ] );
			
		} else {
			_engine.errors.push( [ "script_evaluate_traverse", "Path could not be traversed at \"" + _path[ _i ] + "\". Failed." ] );
			
			return;
			
		}
		++_i;
		
	}
	return _ref;
	
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
