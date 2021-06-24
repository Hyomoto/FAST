function Camera( _width, _height ) constructor {
	static follow	= function( _width, _height, _func ) {
		if ( _func == undefined ) {
			__Follow.ignore();
			
		} else {
			if ( __Follow.__Ignore == false ) {
				__Follow.__param.w	= _width;
				__Follow.__param.h	= _height;
				__Follow.__param.f	= _func;
				
			} else {
				__Follow.parameter({
					w: _width,
					h: _height,
					f: _func
				}).ignore( false );
				
			}
			
		}
		return self;
		
	}
	static move_to	= function( _x, _y, _f ) {
		if ( __Event.__Ignore == false ) {
			var _p	= __Event.__Param;
			if ( _p.tx = _x && _p.ty == _y && _p.f == _f )
				return;
			
		}
		__Event.parameter({
			fx: camera_get_view_x( view_camera[ 0 ] ),
			fy: camera_get_view_y( view_camera[ 0 ] ),
			tx: _x - camera_get_view_x( view_camera[ 0 ] ) - __Offset[ 0 ],
			ty: _y - camera_get_view_y( view_camera[ 0 ] ) - __Offset[ 1 ],
			f: _f == undefined ? __ease__ : _f,
			t: 0,
		}).ignore( false );
		
		return self;
		
	}
	static ease		= function( _f ) {
		if ( _f == undefined ) { __Easing = __ease__; }
		else { __Easing	= _f; }
		
		return self;
		
	}
	static set_speed	= function( _speed ) {
		__Speed	= abs( _speed );
		
	}
	static set_offset	= function( _width, _height ) {
		__Offset	= [ _width, _height ];
		
	}
	static destroy	= function() {
		if ( __Event != undefined ) { __Event.discard(); }
		if ( __Start != undefined ) { __Start.discard(); }
		
		return self;
		
	}
	static __ease__	= function( _t ) { return 1.0; }
	__Border	= [ 0, 0, 0, 0 ];
	__Offset	= [ 0, 0 ];
	__Width		= _width;
	__Height	= _height;
	__Easing	= __ease__;
	__Speed		= 60;
	
	__Start	= new FrameEvent( FAST_EVENT_ROOM_START, 0, function() {
		camera_set_view_size( view_camera[ 0 ], __Width, __Height );
		
		__Border	= [ 0, 0, room_width, room_height ];
		
	});
	__Follow	= new FrameEvent( FAST_EVENT_STEP_END, 0, function( _p ) {
		var _move_to	= _p.f();
		var _x			= _move_to[ 0 ] - _p.w;
		var _y			= _move_to[ 1 ] - _p.h;
		
		move_to( _x, _y );
		
	}).ignore();
	__Event	= new FrameEvent( FAST_EVENT_STEP_END, 0, function( _d ) {
		var _mx	= _d.f( ++_d.t/__Speed ) * _d.tx;
		var _my	= _d.f(   _d.t/__Speed ) * _d.tx;
		
		var _x	= _d.fx + _mx;
		var _y	= _d.fy + _my;
		
		if		( _x < __Border[ 0 ] ) { _x = __Border[ 0 ]; }
		else if ( _x > __Border[ 2 ] ) { _x = __Border[ 2 ]; }
		if		( _y < __Border[ 1 ] ) { _y = __Border[ 1 ]; }
		else if ( _y > __Border[ 3 ] ) { _y = __Border[ 3 ]; }
		
		camera_set_view_pos( view_camera[ 0 ], _x, _y );
		
		if ( _d.t >= __Speed ) {
			__Event.ignore();
			
		}
		
	}).ignore();
	
}
