/// @func InputManager
/// @desc	InputManager is a wrapper for internal file system functions.
/// @wiki Input-Handling-Index
function InputManager() {
	static manager	= function() constructor {
		static log	= function() {
			if ( FAST_DEBUGGER_ENABLE == false ) { return; }
			
			static logger	= new Logger( "input", FAST_LOGGER_DEFAULT_LENGTH, System );
			
			var _string	= "";
			
			var _i = 0; repeat( argument_count ) {
				_string	+= string( argument[ _i++ ] );
				
			}
			logger.write( _string );
			
		}
		/// @param {string}	name	The name of this input.
		/// @desc Inputs are an internal structure that is used to wrap inputs. They contain the state
		//		information, as well as the methods to bind and check that state.
		static input	= function( _name ) constructor {
			static state	= function() {
				var _i = 0; repeat( array_length( inputs ) ) {
					if ( inputs[ _i++ ].down() == false ) { return false; }
					
				}
				if ( event == undefined ) {
					last	= true;
					event	= new FrameEvent( FAST_EVENT_STEP_END, 0, function() {
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
		
	}
	static instance	= new Feature( "FAST Input Handling", "1.0a", "10/18/2020", new manager() );
	return instance.struct;
	
}
