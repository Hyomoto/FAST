function Camera( _view, _width, _height, _visible = true ) constructor {
	static setPosition	= function( _x, _y ) {
		var _w	= width / scale;
		var _h	= height/ scale;
		var _ol	= round( _w * offsetH );
		var _ot	= round( _h * offsetV );
		var _or = _w - _ol;
		var _ob	= _h - _ot;
		
		rawX	= _x - _ol;
		rawY	= _y - _ot;
		
		x	= clamp( rawX, bbox_left, bbox_right - _w );
		y	= clamp( rawY, bbox_top , bbox_bottom- _h );
		
		camera_set_view_pos( camera, x, y );
		camera_set_view_size( camera, _w, _h );
		
		return self;
		
	}
	static setAngle	= function( _value ) {
		angle	= _value < 0 ? _value % 360 + 360 : _value % 360;
		camera_set_view_angle( camera, _value );
		
		return self;
		
	}
	static changeAngle	= function( _amount ) {
		return setAngle( angle + _amount );
		
	}
	static setScale	= function( _value ) {
		scale	= _value;
		
		return setPosition( rawX, rawY );
		
	}
	static mulScale	= function( _amount ) {
		scale	*= _amount;
		
		return setPosition( rawX, rawY );
		
	}
	static divScale	= function( _amount ) {
		scale	/= _amount;
		
		return setPosition( rawX, rawY );
		
	}
	static setBounds	= function( _left, _top = -infinity, _right = infinity, _bottom = infinity ) {
		bbox_left	= _left ?? -infinity;
		bbox_top	= _top;
		bbox_right	= _right;
		bbox_bottom	= _bottom;
		
		return setPosition( rawX, rawY );
		
	}
	view_enabled	= true;
	view_set_visible( _view, _visible );
	
	view	= _view;
	camera	= view_get_camera( _view );
	
	x		= camera_get_view_x( camera );
	y		= camera_get_view_y( camera );
	
	rawX	= x;
	rawY	= y;
	
	width	= _width;
	height	= _height;
	
	scale	= 1.0;
	
	angle	= 0;
	
	bbox_left	= -infinity;
	bbox_top	= -infinity;
	bbox_right	= infinity;
	bbox_bottom	= infinity;
	
	offsetH		= 0.0;
	offsetV		= 0.0;
	
}