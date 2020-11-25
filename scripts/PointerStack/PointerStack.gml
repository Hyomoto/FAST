/// @func PointerStack
/// @param {int}	x		
/// @param {int}	y		
/// @param {int}	width	
/// @param {int}	height	
/// @desc	The PointerStack is used to create a list of (#PointerInterface)s that will be traversed in
//		descending order to ensure only the top-most element is called. Thus, interfaces that are added
//		later will be "above" those that were added earlier.  In the given example, the second simple
//		mouse pointer would be called rather than the first where the two overlap.
/// @example
//pointer = new PointerStack( 0, 0, room_width, room_height )
//
//pointer.add( new PointerSimpleMouse( new ShapeRectangle( 10, 10, 20, 20 ) );
//pointer.add( new PointerSimpleMouse( new ShapeRectangle( 20, 20, 20, 20 ) );
function PointerStack( _x, _y, _w, _h ) constructor {
	/// @desc Calls for this PointerInterface to be updated, will check all instances and update the
	//		top-most interface that it finds. Any previous interactions will have their exit code
	//		called as well.
	static update	= function( _x, _y ) {
		if ( hold != undefined ) {
			hold.update( _x, _y, true );
			
			return true;
			
		}
		if ( point_in_rectangle( _x, _y, x, y, x + width - 1, y + height - 1 ) ) {
			var _i = array_length( content ); repeat( array_length( content ) ) {
				if ( content[ --_i ].update( _x, _y ) ) {
					if ( last != undefined && last != content[ _i ] ) {
						last.update( _x, _y, false );
						
					}
					last	= content[ _i ];
					
					break;
					
				}
				
			}
			active	= true;
			
			return true;
			
		} else if ( last != undefined ) {
			last.update( _x, _y, false );
			last	= undefined;
			
		}
		active	= false;
		
		return false;
		
	}
	/// @param {mixed}	interface	A (#PointerInterface) or (#PointerStack).
	/// @desc Removes the specified interface from the stack.
	static remove	= function( _value ) {
		var _i = 0; repeat( array_length( content ) ) {
			if ( content[ _i++ ] == _value ) {
				array_delete( content, _i - 1, 1 );
				
				return;
				
			}
			
		}
		PointerManager().log( "PointerStack.remove() : The provided value was not found." );
		
	}
	/// @param {mixed}	interface	A (#PointerInterface) or (#PointerStack).
	/// @desc Adds the specified interface to the stack.
	static add		= function( _value ) {
		if ( is_struct_of( _value, PointerInterface ) || is_struct_of( _value, PointerStack ) ) {
			array_push( content, _value );
			
		} else {
			PointerManager().log( "PointerStack.add() : Invalid type provided, must be a PointerInterface or PointerStack." );
			
		}
		return _value;
		
	}
	static draw		= function( _x, _y, _color ) {
		draw_set_color( _color ); 
		
		draw_rectangle( x + _x, y + _y, x + _x + width - 1, y + _y + height - 1, true );
		
		var _i = 0; repeat( array_length( content ) ) {
			content[ _i++ ].draw( _x, _y );
			
		}
		
	}
	static is	= function( _data_type ) {
		return _data_type == PointerStack;
		
	}
	/// @desc The last interface to be interacted with.
	last	= undefined;
	/// @desc The internal array of Interfaces being used.
	content	= [];
	/// @desc The x position of the PointerStack.
	x		= _x;
	/// @desc The y position of the PointerStack.
	y		= _y;
	/// @desc The width of the PointerStack.
	width	= _w;
	/// @desc The height of the PointerStack.
	height	= _h;
	/// @desc Whether or not this stack is currently active
	active	= false;
	/// @desc When set to an interface element, it will not be released.
	hold	= undefined;
	
}
