/// @func variable_traverse_string
/// @param struct/instance
/// @param path
function variable_traverse_string( _ref, _string ) {
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
