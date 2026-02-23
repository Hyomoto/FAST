/// @param {function} _function
/// @param {real} _frames
function delay_call( _function, _frames = 1 ){
	return call_later( _frames, time_source_units_frames, _function );
	
}
