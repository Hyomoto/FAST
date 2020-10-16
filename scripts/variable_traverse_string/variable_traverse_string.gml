/// @func variable_traverse_string
/// @param {struct/instance}	ref			The struct or instance to traverse
/// @param {string}				variable	The variable to return
/// @desc Retrieves the variable stored in `ref` whether it is an object or a structure. Will throw an
// exception if ref doesn't exist, or the value isn't found.
/// @returns mixed
/// @wiki Core-Index Functions
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
