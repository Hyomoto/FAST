function quart_ease_in( _x ) {
	return _x * _x * _x * _x;
}

function quart_ease_out( _x ) {
	return 1 - power(1 - _x, 4);
}

function quart_ease_in_out( _x ) {
	return _x < 0.5 ? 8 * _x * _x * _x * _x : 1 - power(-2 * _x + 2, 4) / 2;
}