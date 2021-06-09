/// @func include
/// @param {int}	object_index	The object to inject the current event from.
/// @desc	Will run the current event from `object_index`.  For example, if called during the step event,
//		this would inject the step event from the given object into the current code.  This allows you to
//		treat objects like components, and share their code easily without relying on inheritance.
/// @example
//include( oInclude );
/// @wiki Core-Index Functions
function include( _object ){
	event_perform_object( _object, event_type, event_number );
	
}
