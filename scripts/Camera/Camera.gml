/// @func Camera
/// @param {int}	width	The width of the camera in pixels
/// @param {int}	height	The height of the camera in pixels
/// @param {int}	*view	optional: The view to assign the camera to
/// @desc	Creates a new camera with the given size and view.  If no view is provided, view 0
///		will be used.  The camera relies on FAST events to control itself and updates in the end
///		step.  When follow behavior is being used, the position will be updated at the end step
///		as well, and thus the target object should have stopped moving by then or the camera will
///		appear to lag behind it.  Cameras are persistent objects!  Therefore you should destroy
///		them when you are through with them, otherwise it could cause a memory leak!
/// @example
//camera = new Camera( 640, 480 ).follow( id );
/// @output Creates a new camera that will follow the current object.
function Camera( _width, _height, _view ) constructor {
	/// @param {mixed}	func_or_id	A function or id that can return [x, y] values to follow
	/// @desc	Sets the camera to follow based on the provided method or id.  If an instance
	///		id is provided, the camera will follow the x, y coordinates.  Otherwise, a method
	///		can return an array as [x, y] and this will instead guide the camera.
	/// @returns self
	static follow	= function( _func ) {
		if ( is_numeric( _func ) && instance_exists( _func )) {
			__Follow.parameter({
				f: function( _i ) { return [ _i.x, _i.y ]; },
				i: _func
			}).ignore( false );
			
		} else {
			__Follow.parameter({
				f: _func,
				i: undefined
			}).ignore( false );
			
		}
		__Event.ignore( false );
		
		return self;
		
	}
	/// @param {real}	x	A x coordinate
	/// @param {real}	y	A y coordinate
	/// @desc	Tells the camera to move to the given coordinates.  This will cancel follow
	///		behavior if it has been previously enabled.
	/// @returns self
	static move_to	= function( _x, _y ) {
		var _e	= __Event.__Param;
		var _cx	= camera_get_view_x( view_camera[ __View ] );
		var _cy	= camera_get_view_y( view_camera[ __View ] );
		
		_x	-= __Offset[ 0 ];
		_y	-= __Offset[ 1 ];
		
		_e.fx	= _cx;
		_e.fy	= _cy;
		_e.tx	= _x;
		_e.ty	= _y;
		_e.dx	= _x - _cx;
		_e.dy	= _y - _cy;
		_e.t	= 0;
		
		__Event.ignore( false );
		__Follow.ignore();
		
		return self;
		
	}
	/// @desc	Returns true if the camera is currently moving.
	/// @returns bool
	static is_moving	= function() {
		return __Event.__Ignore	== false;
		
	}
	/// @desc	Tells the camera to stop moving..
	/// @returns self
	static stop		= function() {
		__Follow.ignore();
		__Event.ignore();
		
		return self
		
	}
	/// @param {func}	*ease	optional: An easing function
	/// @desc	Sets the easing method to be used when moving the camera.  If no function
	///		is provided, the default instant movement will be used instead.
	/// @returns self
	static set_easing		= function( _f ) {
		if ( _f == undefined )	{ __Easing = __instant__; }
		else					{ __Easing	= _f; }
		
		return self;
		
	}
	/// @param {int}	speed	A value greater than 0
	/// @desc	Sets the speed in frames that camera movements should complete.
	/// @returns self
	static set_speed	= function( _speed ) {
		__Speed	= abs( _speed );
		
		return self;
		
	}
	/// @param {int}	width
	/// @param {int}	height
	/// @desc	Sets the horizontal and vertical offsets for the camera.
	/// @returns self
	static set_offset	= function( _width, _height ) {
		__Offset	= [ _width, _height ];
		
		return self;
		
	}
	/// @desc	Destroys the events powering the camera, allowing it to be safely garbage collected.
	/// @returns self
	static destroy	= function() {
		if ( __Event != undefined ) { __Event.discard(); }
		if ( __Follow != undefined ) { __Follow.discard(); }
		if ( __Start != undefined ) { __Start.discard(); }
		if ( __End	 != undefined ) { __End.discard(); }
		
		return self;
		
	}
	/// @ignore
	static __instant__	= function( _t ) { return 1.0; }
	
	/// @var {array}	The borders which the camera must stay inside of
	__Border	= [ 0, 0, 0, 0 ];
	/// @var {array}	The horizontal and vertical offsets
	__Offset	= [ 0, 0 ];
	/// @var {array}	The width of the camera
	__Width		= _width;
	/// @var {array}	The height of the camera
	__Height	= _height;
	/// @var {array}	The easing function being used by the camera
	__Easing	= __instant__;
	/// @var {array}	The width of the camera
	__Speed		= 60;
	__View		= _view == undefined ? 0 : _view;
	
	__Start	= new FrameEvent( FAST_EVENT_ROOM_START, 0, function() {
		camera_set_view_size( view_camera[ __View ], __Width, __Height );
		
		__Border	= [ 0, 0, room_width, room_height ];
		
	});
	__End	= new FrameEvent( FAST_EVENT_ROOM_END, 0, function() {
		__Event.ignore();
		__Follow.ignore();
		
	});
	__Follow	= new FrameEvent( FAST_EVENT_STEP_END, 0, function( _p ) {
		var _move_to	= _p.f( _p.i );
		var _cx	= camera_get_view_x( view_camera[ __View ] );
		var _cy	= camera_get_view_y( view_camera[ __View ] );
		var _x	= _move_to[ 0 ] - __Offset[ 0 ];
		var _y	= _move_to[ 1 ] - __Offset[ 1 ];
		
		var _e	= __Event.__Param;
		
		if ( _e.tx == _x && _e.ty == _y ) { return; }
		
		_e.fx	= _cx;
		_e.fy	= _cy;
		_e.tx	= _x;
		_e.ty	= _y;
		_e.dx	= _x - _cx;
		_e.dy	= _y - _cy;
		_e.t	= 0;
		
		__Event.ignore( false );
		
	}).ignore();
	__Event	= new FrameEvent( FAST_EVENT_STEP_END, 0, function( _d ) {
		var _mx	= __Easing( ++_d.t/__Speed ) * _d.dx;
		var _my	= __Easing(   _d.t/__Speed ) * _d.dy;
		
		var _x	= _d.fx + _mx;
		var _y	= _d.fy + _my;
		
		if		( _x < __Border[ 0 ] )				{ _x = __Border[ 0 ]; }
		else if ( _x + __Width > __Border[ 2 ] )	{ _x = __Border[ 2 ] - __Width; }
		if		( _y < __Border[ 1 ] )				{ _y = __Border[ 1 ]; }
		else if ( _y + __Height > __Border[ 3 ] )	{ _y = __Border[ 3 ] - __Height; }
		
		camera_set_view_pos( view_camera[ __View ], _x, _y );
		
		if ( _d.t >= __Speed ) {
			__Event.ignore();
			
		}
		
	}).parameter({tx: 0, ty: 0, fx: 0, fy: 0, dx: 0, dy: 0, t: 0}).ignore();
	
}
