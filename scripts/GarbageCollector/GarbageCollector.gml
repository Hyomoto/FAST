/// @func GarbageCollector
/// @param {mixed}	pointer		The pointer you wish to operate on.
/// @param {method}	on_clean	The method to be called when this pointer should be cleaned up.
/// @desc	Using GarbageCollector you can create references that will be cleaned up when they fall out
///		of scope.  You provide the pointer
function GarbageCollector( _value, _on_clean ) constructor {
	GarbageManager().add( self, _value, _on_clean );
	
	pointer		= _value;
	
}
