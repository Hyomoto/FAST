/// @func InputDevice
/// @param inputs...
/// @wiki Input-Handling-Index
function InputDevice() constructor { 
	static input	= function( _name ) constructor {
		static raw		= function() {
			var _i = 0; repeat( size ) {
				if ( inputs[ _i++ ].down() ){
					if ( event == undefined ) {
						event	= new FAST_Event( FAST.STEP, 0, undefined, function() {
							if ( raw() == false ) {
								last		= false;
								event.once	= true;
								event		= undefined;
								
							}
							
						});
						last	= true;
						
					}
					return true;
					
				}
				
			}
			return false;
			
		}
		static bind		= function( _input ) {
			inputs[ size++ ]	= _input;
			
		}
		static pressed	= function() {
			return ( last == false && raw() );
			
		}
		static held		= function() {
			return ( last == true && raw() );
			
		}
		static released	= function() {
			return ( last == true && raw() == false );
			
		}
		static toString	= function() {
			return name + "(" + string( raw() ) + ")";
			
		}
		name	= _name;
		inputs	= [];
		event	= undefined;
		last	= false;
		size	= 0;
		
	}
	static add_input	= function( _input, _index ) {
		_index	= ( is_undefined( _index ) ? array_length( inputs ) : _index );
		
		if ( variable_struct_exists( self, _input ) ) {
			log_nonfatal( undefined, "InputDevice.add_input", "Input \"", _input, "\" already defined!" );
			
			return;
			
		}
		inputs[ _index ]	= new input( _input );
		
		variable_struct_set( self, _input, inputs[ _index ] );
		
	}
	static is		= function( _data_type ) {
		return _data_type == InputDevice;
		
	}
	inputs	= array_create( argument_count );
	
	var _i = 0; repeat( argument_count ) {
		add_input( argument[ _i ], _i );
		
		++_i;
		
	}
	
}
