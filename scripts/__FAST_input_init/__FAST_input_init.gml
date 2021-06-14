// # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//								User-definable Macros
// # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//		The number of virtual ports to connect gamepads to.  If another gamepad is
//	discovered and there is no free port, it will be ignored until a port is freed.
#macro FAST_GAMEPAD_VIRTUAL_PORTS	4

//		This is the event that controller events will be checked for clearing.  It is
//	suggested that you do not set this to the same event you intend to check for
//	inputs as that could cause unexpected behaviors.
#macro FAST_GAMEPAD_UPDATE_EVENT	FAST_EVENT_STEP_BEGIN

// # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// #							End of User Defines
// # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#macro FAST_BUTTON_FREE		0x0
#macro FAST_BUTTON_PRESSED	0x1
#macro FAST_BUTTON_CHECK	0x3
#macro FAST_BUTTON_RELEASED	0x4

FAST.feature( "FIOM", "Input", (1 << 32 ) + (1 << 16), "6/12/2021" );

function __FAST_input_init() {
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
	static instance	= new manager();
	return instance;
	
}
