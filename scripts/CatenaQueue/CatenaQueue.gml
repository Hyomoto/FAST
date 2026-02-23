/// @param {Struct.Catenable,Id.Instance,function,array,real} ... If passed as an array, has the format [ frames, call, [ args... ]]
/// @desc The ActionQueue calls the next item in the queue each frame.  If the
///		item is a _Action_, update() will be called on it, otherwise the
///		method will be called directly.  For convenience, you may push a real
///		which will insert a blank method for those many frames, creating a
///		simple wait.  You may also push a method directly, which will cause
///		it to be called once.
function CatenaQueue() : Catenable() constructor {
	/// @desc Calls update on this action, advances it by one frame.
	static update	= function() {
		if ( array_length( list ) > 0 ) {
			var _next	= array_first( list );
			if ( is_array( _next )) {
				method_call( _next[ 1 ], _next, 2 );
				
				if ( --_next[ 0 ] == 0 )
					array_delete( list, 0, 1 );
			
			} else if ( _next.update().isFinished())
				array_delete( list, 0, 1 );
		
			if ( array_length( list ) == 0 ) {
				if ( is_array( onEnd ))
					method_call( onEnd[ 0 ], onEnd, 1 );
				else
					onEnd();
				
			}
			
		}
		return self;
		
	}
	/// @desc Returns if execution has completed, ie: no more events remain.
	static isFinished	= function() {
		return array_length( list ) == 0;
		
	}
	/// @desc Returns the first item to run.
	static first= function() {
		return array_first( list );
		
	}
	/// @desc Returns the last item to run.
	static last	= function() {
		return array_last( list );
		
	}
	static next	= function() {
		array_delete( list, 0, 1 );
		
	}
	/// @param {Struct.Catenable,Id.Instance,function,array,real} ...
	/// @desc Push another action, wait, or a method to be executed.
	/// If a real is pushed, this will create a blank method that runs
	/// the given number of frames.  Pushing only a method will cause it
	/// to be run once.  Pushing an array has the format [ frames, call, args... ] and
	/// and will last the number of frames given.
	static push	= function() {
		var _i = 0; repeat( argument_count ) {
			var _item	= argument[ _i++ ];
			if ( is_real( _item ))
				array_push( list, CatenaWait( _item ));
			else if ( is_method( _item ))
				array_push( list, [ 1, _item ] );
			else if ( is_instanceof( _item, Catenable ) || is_array( _item ))
				array_push( list, _item );
			
		}
		return self;
		
	}
	/// @param {Struct.Catenable,Id.Instance,function,array,real} ...
	/// @desc Push another action, wait, or a method to be executed.
	/// If a real is pushed, this will create a blank method that runs
	/// the given number of frames.  Pushing only a method will cause it
	/// to be run once.  Pushing an array has the format [ frames, call, args... ] and
	/// and will last the number of frames given.
	static insert	= function() {
		var _i = 0; repeat( argument_count ) {
			var _item	= argument[ _i++ ];
			if ( is_real( _item ))
				array_insert( list, _i, CatenaWait( _item ));
			else if ( is_method( _item ))
				array_insert( list, _i, [ 1, _item ] );
			else if ( is_instanceof( _item, Catenable ) || is_array( _item ))
				array_insert( list, _i, _item );
			
		}
		return self;
		
	}
	list	= [];
	var _i = 0; repeat( argument_count ) {
		push( argument[ _i++ ] );
		
	}
	
}
