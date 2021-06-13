/// @func include
/// @param {int}	object_index	The object to inject from
/// @desc	Will run the currently running event from `object_index`.  For example, if called during the
//		step event, this would inject the step event from the given object into the current code.
/// @example
//include( oMonsterAI );
/// @wiki Core-Index Functions
function include( _object ){
	event_perform_object( _object, event_type, event_number );
	
}
