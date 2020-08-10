/// @func include
/// @param object_index
/// @param *__include
function include( _object, _param ){
	gml_pragma( "forceinline" );
	
	__include	= _param;
	
	event_perform_object( _object, event_type, event_number );
	
}
#macro __include	global.__include_param