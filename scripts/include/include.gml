/// @param {Asset.GMObject}	_object the object index to include
/// @desc	Includes the current event from the specified object.
function include( _object ) {
	gml_pragma( "forceinline" );
	event_perform_object( _object, event_type, event_number );
	
}
