function quad_ease_in( _x ) {
	return _x * _x;	
}
function quad_ease_out( _x ) {
	return 1 - (1 - _x) * (1 - _x);
}
function quad_ease_in_out( _x ) {
	return _x < 0.5 ? 2 * _x * _x : 1 - power(-2 * _x + 2, 2) / 2;
}