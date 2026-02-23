#macro CATENA_USE_DELTA_BY_DEFAULT false

/// @desc Catenable is an abstract constructor to unify catena structures.
function Catenable() constructor {
	/// @desc Calls update on this action, advances it by one frame.
	static update		= function() { return self; }
	/// @desc Returns if this action has finished.
	static isFinished	= function() { return true; }
	/// @param {function,array} _function
	/// @desc Assigns a method to be called after the action finishes.
	static after		= function( _function ) {
		onEnd	= _function;
		return self;
		
	}
	/// @ignore
	onEnd	= function() {};
	
}
