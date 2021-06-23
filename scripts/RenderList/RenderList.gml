/// @func RenderList
/// @params {int}	ids...	The instances to add to this list.
/// @desc Used to control the draw order of objects.  Objects will be drawn in the order
//		they are added to the list.
/// @example
//render = new RenderList( instance_id );
//
//render.draw();
/// @wiki Render-Index
function RenderList() constructor {
	/// @param {int}	ids...	The instances to add to this list.
	/// @desc	Adds the provided instance ids to the render list.
	add	= function( _id ) {
		var _i = 0; repeat( argument_count ) {
			array_push( argument[ _i++ ] );
			
		}
		
	}
	/// @param {int}	ids...	The instances to remove from this list.
	/// @desc	Removes the given ids from the list, if they exist.
	remove	= function( _id ) {
		var _i = 0; repeat( array_length( content ) ) {
			var _find	= array_contains( content, argument[ _i++ ] );
			
			if ( _find > -1 ) {
				array_delete( content, _id, 1 );
				
			}
			
		}
		
	}
	/// @desc	Calls the draw event on each object in the list, in the order they were added.
	draw	= function() {
		if ( event_type != ev_draw ) { return; }
		
		var _i = 0; repeat( array_length( content ) ) {
			with( content[ _i++ ] ) { event_perform( ev_draw, event_number ); }
			
		}
		
	}
	/// @desc An array. Contains the list of objects which have been added to this list.
	content	= array_create( argument_count );
	
	var _i = 0; repeat( argument_count ) {
		content[ _i ]	= argument[ _i ];
		++_i;
		
	}
	
}
