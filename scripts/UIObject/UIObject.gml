/// @param {Id.Instance} _id
/// @desc Calls the object draw event as part of the GUI.
function UIObject( _id ) : UIElement() constructor {
	static draw	= function( _x = 0, _y = 0 ) {
		if ( beforeDraw != undefined ) method_call( beforeDraw[ 0 ], beforeDraw, 1 );
		with( instance ) { event_perform( ev_draw, ev_draw_normal ); }
		if ( afterDraw != undefined ) method_call( afterDraw[ 0 ], afterDraw, 1 );
		
	}
	instance	= _id;
	
}
