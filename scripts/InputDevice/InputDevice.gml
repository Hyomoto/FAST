/// @param {string} [bindings...]
function InputDevice() constructor {
	var _i = 0; repeat( argument_count ) {
		variable_struct_set( self, argument[ _i++ ], new InputSource());
		
	}
	
}
