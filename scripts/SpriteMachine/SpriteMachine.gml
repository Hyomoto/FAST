/// @param {Bool} _useDeltaTime
function SpriteMachine( _useDeltaTime = true ) constructor {
	/// @param {Asset.GMSprite} _sprite
	/// @param {Real} _speed Delta in seconds, Frames in frames
	/// @param {Array<Real>,Struct} _frames
	/// @param {Bool} _loop
	static create	= function( _sprite, _speed, _frames, _loop = true, _onEnd = undefined ) {
		if ( is_struct( _frames ))
			_frames	= array_create_ext( _frames.length, method(_frames, function( _i ) { return start + _i; }));
		
		static Animation	= function( _sprite, _speed, _frames, _loop, _onEnd ) constructor {
			sprite = _sprite;
			frames = _frames;
			speed	= _speed;
			onEnd	= _onEnd;
			loop	= _loop;
			loopTo	= 0;
			
		}
		return new Animation( _sprite, delta ? ( _speed * array_length( _frames )) : ( array_length( _frames ) / _speed ), _frames, _loop, _onEnd );
		
	}
	/// @param {Struct.SpriteMachine$$create$$Animation} _animation
	static set	= function( _animation, _reset = true ) {
		animation	= _animation;
		other.sprite_index = _animation.sprite;
		
		if ( _reset ) {
			frame	= 0;
			wait	= 0;
			
		}
		
	}
	static update	= function( _delta = delta ? delta_time : 1 ) {
		if ( is_undefined( animation ))
			return;
		if ( wait > 0 )
			return --wait;
		
		var _speed = animation.speed * ( delta ? _delta / 1000000 : _delta );
		
		frame	+= _speed;
		
		if ( frame >= array_length( animation.frames )) {
			if ( animation.loop )
				frame = ( frame % array_length( animation.frames )) + animation.loopTo;
			if ( not is_undefined( animation.onEnd ))
				animation.onEnd();
			
		}
		
	}
	static draw	= function( _x, _y ) {
		if ( is_undefined( animation ))
			return;
		var _frame = min( array_length( animation.frames ) - 1 , floor( frame ));
		
		draw_sprite_ext( sprite(), animation.frames[ _frame ], _x, _y, xScale, yScale, rotation, color, alpha );
		
	}
	static drawFlip	= function( _x, _y, _flipX = false, _flipY = false ) {
		if ( is_undefined( animation ))
			return;
		var _frame	= min( array_length( animation.frames ) - 1 , floor( frame ));
		var _fx		= _flipX ? _x + sprite_get_width( animation.sprite ) - sprite_get_xoffset( animation.sprite ) * 2 : _x;
		var _fy		= _flipY ? _y + sprite_get_height( animation.sprite) - sprite_get_yoffset( animation.sprite ) * 2 : _y;
		
		draw_sprite_ext( sprite(), animation.frames[ _frame ], _fx, _y, _flipX ? -1 : 1, _flipY ? -1 : 1, rotation, color, alpha );
		
	}
	static sprite	= function() {
		if ( is_undefined( animation ))
			return -1;
		if ( override > -1 )
			return override;
		return animation.sprite;
		
	}
	animation	= undefined;
	delta		= _useDeltaTime;
	frame		= 0;
	xScale		= 1;
	yScale		= 1;
	rotation	= 0;
	color		= c_white;
	alpha		= 1.0;
	override	= -1;
	wait		= 0;
	
}
