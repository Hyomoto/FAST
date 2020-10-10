/// @desc PointerManager
function PointerManager() {
	static manager	= function() constructor {
		static set_input	= function( _input ) {
			if ( is_struct( _input ) == false || variable_struct_exists( _input, "inputs" ) == false ) {
				log_nonfatal( undefined, "GUIManager", "Provided input was not recognized as an InputDevice." );
				
			}
			device	= _input;
			
		}
		static set_shape	= function( _shape ) {
			if ( is_struct( _shape ) == false || variable_struct_exists( _shape, "inside" ) == false ) {
				var _type	= ( is_struct( _shape ) == false ? typeof( _shape ) : instanceof( _shape ) );
				
				log_critical( undefined, "GUIManager", "Provided shape was not recognized! Was ", _type, ". Exception thrown." );
				throw( "See output log." );
			}
			interface.shape	= _shape;
			
		}
		static disable		= function() { interface.disable(); }
		static enable		= function() { interface.enable(); }
		static set_enter	= function( _id, _enter ) { interface.set_enter( _id, _enter ) }
		static set_leave	= function( _id, _leave ) { interface.set_leave( _id, _leave ) }
		static set_step		= function( _id, _step )  { interface.set_step( _id, _step ) }
		static set_depth	= function( _id, _depth ) { interface.change( _id, _depth, _sort ); }
		static remove		= function( _id )		  { interface.remove( _id ); }
		static add			= function( _id, _depth, _interface ) { interface.add( _id, _depth, _interface ); }
		static toString		= function()			  { return interface.toString(); }
		interface	= new PointerInterface();
		event		= new FAST_Event( FAST.STEP_BEGIN, 0, undefined, function() {
			if ( device == undefined ) { return; }
			
			if ( interface.inside( device.get_x(), device.get_y() ) ) {
				if ( interface.active = false ) {
					interface.enter();
					
				}
				target	= interface.update( device.get_x(), device.get_y() );
				
			} else if ( interface.active ) {
				interface.leave();
				
			}
			
		});
		device		= undefined;
		target		= noone;
		
	}
	static instance	= new Feature( "FAST Pointer", "1.0", "08/03/2020", new manager() );
	return instance.struct;
	
}
