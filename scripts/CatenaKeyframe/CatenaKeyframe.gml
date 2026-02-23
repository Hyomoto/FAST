/// @param {Real} _time				    How long this tween should take
/// @param {Array<Real>,Real} _start	The starting value(s)
/// @param {Array<Real>,Real} _end		The ending value(s)
/// @param {String,undefined} _ease		Optional: The name of a channel in animEase
/// @param {Function} _function			Optional: The function to pass the keyframe into.
/// @param {Bool} _use_delta            Optional: Whether to use frames (false) or seconds (true)
/// @desc The tween is used to generate procedural keyframes with added
///		easing.  Each time update is called, new keyframe data will be
///		generated from the start and end positions and passed into the
///		function.  If you want to change multiple values over the same
///		period, use an array for start and end values.
function CatenaKeyframe( _time, _start, _end, _ease = undefined, _function = function() {}, _use_delta = CATENA_USE_DELTA_BY_DEFAULT) : Catenable() constructor {
	/// @desc Calls update on this tween, advances it by one frame.
	static update	= function() {
        if use_delta
            is_at += delta_time;
        else
            is_at += 1;
        var _p = min( 1.0, is_at / end_at );
		progress = animcurve_channel_evaluate( curve, _p );
		var _a	= array_create_ext( array_length( from ), function( _i ) {
			return lerp( from[ _i ], to[ _i ], progress );
			
		});
		method_call( onUpdate, _a );
		
		if ( isFinished()) {
			if ( is_array( onEnd ))
				method_call( onEnd[ 0 ], onEnd, 1 );
			else
				onEnd();
			
		}
		return self;
		
	}
	/// @desc Returns if this tween has finished.
	static isFinished	= function() {
		return progress == 1.0;
		
	}
	from	= is_array( _start ) == false ? [ _start ] : _start;
	to		= is_array( _end ) == false ? [ _end ] : _end;
    use_delta = _use_delta;
    if ( _use_delta )
        _time *= 1_000_000;
	end_at	= _time;
	is_at	= 0;
	progress= 0;
	onUpdate= _function;
	isArray	= is_array( _start );
	
	curve	= animcurve_get_channel( animEase, _ease ?? "Linear" );
	
}
