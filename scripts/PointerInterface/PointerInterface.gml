/// @func PointerInterface
/// @param {(#InputShape)}	shape	The shape of this input interface
/// @desc	An abstract interface for building pointers, see (#PointerSimpleMouse) for an example of how
//		to extend it into a concrete implementation.
function PointerInterface( _shape ) constructor {
	static change_state	= function( _state, _event, _x, _y ) {
		if ( state != _state ) {
			state	= _state;
			
			if ( _event != undefined ) {
				_event( _x, _y );
				
			}
			
		}
		
	}
	static update	= function( _x, _y, _force ) {
		if ( _force != undefined ) { return _force == true; }
		if ( shape.inside( _x, _y ) ) {
			return true;
			
		} else {
			return false;
			
		}
		
	}
	static draw		= function( _x, _y ) {
		shape.draw( _x, _y, true )
		
	}
	static is	= function( _data_type ) {
		return _data_type == PointerInterface;
		
	}
	/// @desc The internal Shape.
	shape	= undefined;
	/// @desc The state of the interface.
	state	= undefined;
	
	if ( is_struct_of( _shape, Shape ) ) {
		shape	= _shape;
		
	} else {
		PointerManager().log( instanceof( self ), ": Invalid type provided, must be a Shape." );
		shape	= new Shape();
		
	}
	
}
