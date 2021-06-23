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
		static __input__	= function( _name ) constructor {
			static state	= function() {
				var _i = 0; repeat( array_length( inputs ) ) {
					if ( inputs[ _i++ ].down() == false ) { return false; }
					
				}
				if ( event == undefined ) {
					last	= true;
					event	= new FrameEvent( FAST.STEP_END, 0, function() {
						if ( state() == false ) {
							event.discard();
							
							last	= false;
							event	= undefined;
							
						}
						
					});
					
				}
				return true;
				
			}
			static bind		= function( _input ) {
				inputs[ size++ ]	= _input;
				
			}
			static pressed	= function() {
				return last == false && state();
				
			}
			static held		= function() {
				return ( state() &&  last == true );
				
			}
			static released	= function() {
				return ( state() == false && last == true );
				
			}
			static toString	= function() {
				return name + "(" + string( state() ) + ")";
				
			}
			name	= _name;
			inputs	= [];
			event	= undefined;
			last	= false;
			size	= 0;
			
		}
		if ( variable_struct_exists( self, _input ) ) {
			log_nonfatal( undefined, "InputDevice.add_input", "Input \"", _input, "\" already defined!" );
			
			return;
			
		}
		variable_struct_set( self, _input, new __input__( _input ) );
		
	}
	var _i = 0; repeat( argument_count ) {
		__add_input( argument[ _i++ ] );
		
	}
	
}
