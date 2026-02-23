/// @param {function,array} _callback
function UIInteraction( _callback = undefined ) : UIElement() constructor {
	static isInside	= function( _x, _y ) { return false; }
	static call	= function( _what, _x = 0, _y = 0 ) {
		if ( self[$ _what ] == undefined )
			return false;
		_x	-= x;
		_y	-= y;
		var _call	= self[$ _what ];
		if ( is_array( _call ))	return method_call( _call[ 0 ], _call, 1 ) ?? true;
		else					return _call( _x, _y ) ?? true;
		
	}
	static onEnter	= function( _enter ) {
		enter	= _enter;
		return self;
		
	}
	static onLeave	= function( _leave ) {
		leave	= _leave;
		return self;
		
	}
	static onLeftClick	= function( _left ) {
		left	= _left;
		return self;
		
	}
	static onRightClick	= function( _right ) {
		right	= _right;
		return self;
		
	}
	static onMiddleClick	= function( _middle ) {
		middle	= _middle;
		return self;
		
	}
	static onWheelUp	= function( _wheel ) {
		wheelUp	= _wheel;
		return self;
		
	}
	static onWheelDown	= function( _wheel ) {
		wheelDown	= _wheel;
		return self;
		
	}
	static onStep	= function( _step ) {
		step	= _step;
		return self;
		
	}
	static onEvent	= function( _name, _callback ) {
		self[$ _name ]	= _callback;
		return self;
		
	}
	/// @ignore
	left		= _callback;
	/// @ignore
	right		= undefined;
	/// @ignore
	middle		= undefined;
	/// @ignore
	enter		= undefined;
	/// @ignore
	leave		= undefined;
	/// @ignore
	wheelUp		= undefined;
	/// @ignore
	wheelDown	= undefined;
	/// @ignore
	step		= undefined;
	
}
