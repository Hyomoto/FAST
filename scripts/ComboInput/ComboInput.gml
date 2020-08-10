/// @func ComboInput
/// @param GenericInput...
function ComboInput() constructor {
	static raw		= function() {
		if ( down() ) {
			if ( event == undefined ) {
				event	= new Event( FAST.STEP, 0, undefined, function() {
					if ( down() == false ) {
						last		= false;
						event.once	= true;
						event		= undefined;
						
					}
					
				});
				
			}
			last	= true;
			
			return true;
			
		}
		return false;
		
	}
	static down	= function() {
		var _i = 0; repeat( size ) {
			if ( inputs[ _i++ ].down() == false ) {
				return false;
				
			}
			
		}
		return true;
		
	}
	inputs	= array_create( argument_count );
	event	= undefined;
	last	= false;
	
	var _i = 0; repeat( argument_count ) {
		inputs[ _i ]	= argument[ _i ];
		
		++_i;
		
	}
	size	= argument_count;
	
}
