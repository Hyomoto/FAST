/// @param {Struct.Catenable,Id.Instance,function,array,real} ... A sequence, function, array or real.
/// @desc The ActionList calls every item in the list each frame.  If the
///		item is a _Action_, update() will be called on it, otherwise the
///		method will be called directly.  For convenience, you may push a
///		method directly, which will cause it to be called once.
function CatenaList() : CatenaQueue() constructor {
	/// @desc Calls update on this action, advances it by one frame.
	static update	= function() {
		if ( array_length( list ) > 0 ) {
			var _i = 0; repeat( array_length( list )) {
				var _next	= list[ _i ];
				if ( is_array( _next )) {
					method_call( _next[ 1 ], _next, 2 );
					
					if ( --_next[ 0 ] == 0 )
						array_delete( list, _i, 1 );
					else
						_i += 1;
					
				} else {
					if ( _next.update().isFinished())
						array_delete( list, _i, 1 );
					else
						_i	+= 1;
					
				}
			
			}
			if ( array_length( list ) == 0 ) {
				if ( is_array( onEnd ))
					method_call( onEnd[ 0 ], onEnd, 1 );
				else
					onEnd();
				
			}
			
		}
		return self;
		
	}
	var _i = 0; repeat( argument_count ) {
		push( argument[ _i++ ] );
		
	}
	
}