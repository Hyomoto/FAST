/// @func InputDevice
/// @param {string}	inputs...	The names of the inputs to create on this InputDevice.
/// @desc	Creates a new input device with the given input characteristics. While most names are
//		not reserved, because of how the internal variables must be assigned.
/// @wiki Input-Handling-Index
function InputDevice() constructor { 
	/// @oaram {string}	input	The name of the input to add.
	/// @param {int}	index	optional: The internal index to bind this input to. Using this argument could cause unexpected crashes.
	/// @desc While the normal way of declaring inputs is to do so when the InputDevice is created,
	//		calling add_input() after creation will create the specified input.
	static __add_input	= function( _input, _index ) {
		if ( variable_struct_exists( self, _input ) ) {
			log_nonfatal( undefined, "InputDevice.add_input", "Input \"", _input, "\" already defined!" );
			
			return;
			
		}
		variable_struct_set( self, _input, new ( InputManager() ).input( _input ) );
		
	}
	static is		= function( _data_type ) {
		return _data_type == InputDevice;
		
	}
	var _i = 0; repeat( argument_count ) {
		__add_input( argument[ _i++ ] );
		
	}
	
}
