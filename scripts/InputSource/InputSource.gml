function InputSource() constructor {
	static double	= function( _speed ) {
		var _time	= ( get_timer() - last ) / 1000000;
		if ( pressed() && _time < _speed ) {
			last	= 0;
			return true;
			
		}
		return false;
		
	}
	static pressed	= function() {
		var _i = 0; repeat( array_length( bindings )) {
			if ( bindings[ _i++ ].pressed()) {
				last	= get_timer();
				return true;
				
			}
			
		}
		return false;
		
	}
	static released	= function() {
		var _i = 0; repeat( array_length( bindings )) {
			if ( bindings[ _i++ ].released())
				return true;
				
		}
		return false;
		
	}
	static held	= function() {
		var _i = 0; repeat( array_length( bindings )) {
			if ( bindings[ _i++ ].held())
				return true;
			
		}
		return false;
		
	}
	static bind	= function() {
		bindings	= [];
		
		var _i = 0; repeat( argument_count ) {
			array_push( bindings, argument[ _i++ ]);
			
		}
		
	}
	bindings	= [];
	last		= 0;
	
}
