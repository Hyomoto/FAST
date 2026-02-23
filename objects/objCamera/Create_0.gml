/// @desc Allows setting up multiple camera values in one call.
setValues	= function( _x_or_id = follow, _y = undefined, _zoom = zoom, _angle = angle ) {
	if ( _x_or_id == noone ) {
		_x_or_id	= x;
		_y			= y;
		
	}
	zoom	= _zoom;
	angle	= _angle;
	pointAt( _x_or_id, _y );
	
	return self;
	
}
/// @desc {real} _time If useDeltaTime is true, in microseconds.  Otherwise in frames.
/// @desc Causes the camera to pan to the given location/instance.
panTo	= function( _time, _x_or_id, _y = undefined, _curve = "EaseOut" ) {
	if ( is_undefined( keyframe ))
		keyframe	= new KeyframeList().after( function() { keyframe = undefined });
	
	if ( useDeltaTime )
		_time *= game_get_speed( gamespeed_fps );
	
	if ( is_undefined( _y ))
		keyframe.push( new KeyframeTarget( _time, [ camera.rawX, camera.rawY ], _x_or_id, [ "x", "y" ], function( _x, _y ) {
			camera.setPosition( _x, _y );
			
		}, _curve ));
	else
		keyframe.push( new Keyframe( _time, [ camera.rawX, camera.rawY ], [ _x_or_id, _y ], function( _x, _y ) {
			camera.setPosition( _x, _y );
		
		}, _curve ));
	follow	= noone;
	
}
/// @desc {real} _time If useDeltaTime is true, in microseconds.  Otherwise in frames.
/// @desc Causes the camera to zoom to the given multiplier.
zoomTo	= function( _time, _zoom, _curve = "EaseOut" ) {
	if ( is_undefined( keyframe ))
		keyframe	= new KeyframeList().after( function() { keyframe = undefined });
	
	if ( useDeltaTime )
		_time *= game_get_speed( gamespeed_fps );
	
	keyframe.push( new Keyframe ( _time, camera.scale, _zoom, function( _v ) {
		camera.setScale( _v );
		
	}, _curve ));
	
}
/// @desc {real} _time If useDeltaTime is true, in microseconds.  Otherwise in frames.
/// @desc Causes the camera to change angle to the given value.
angleTo	= function( _time, _angle, _clockwise = true, _curve = "EaseOut" ) {
	if ( is_undefined( keyframe ))
		keyframe	= new KeyframeList().after( function() { keyframe = undefined });
	
	if ( useDeltaTime )
		_time *= game_get_speed( gamespeed_fps );
	
	_angle	= _angle < 360 ? _angle % 360 + 360 : _angle % 360; // normalize the angle
	
	if ( _clockwise )	_angle -= 360; // angle is smaller, rotates left
	else				_angle += 360; // angle is bigger, rotates right
	
	keyframe.push( new Keyframe ( _time, camera.angle, _angle, function( _v ) {
		camera.setAngle( _v );
		
	}, _curve ));
	
}
/// @desc Tells the camera to point at the given location or instance.
pointAt	= function( _x_or_id, _y = undefined ) {
	if ( is_undefined( _y ) == false ) {
		follow	= noone;
		
		camera.setPosition( _x_or_id, _y );
		x	= camera.x;
		y	= camera.y;
		
	} else if ( instance_exists( _x_or_id ))
		follow	= _x_or_id;
	
}
resize	= function( _w, _h ) {
	image_xscale	= _w / sprite_get_width( sprite_index );
	image_yscale	= _h / sprite_get_height( sprite_index );
	view			= new Viewport( viewport, 0, 0, sprite_width, sprite_height );
	camera			= view.camera;
	camera.offsetH	= offsetH;
	camera.offsetV	= offsetV;
	
	if ( keepInBounds )
		camera.setBounds( 0, 0, room_width, room_height );
	
	return self;
	
}
// state and behavior
keyframe= undefined;
follow	= noone;
angle	= 0;
zoom	= 1.0;

offsetH	= clamp( offsetH, 0.0, 1.0 );
offsetV	= clamp( offsetV, 0.0, 1.0 );
// make viewport
view	= undefined;
camera	= undefined;

// setup camera
resize( sprite_width, sprite_height );

pointAt( x + sprite_width * offsetH, y + sprite_height * offsetV );
