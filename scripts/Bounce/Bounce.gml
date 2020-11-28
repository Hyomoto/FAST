function bounce_ease_in( _x ) {
	return 1 - bounce_ease_in(1 - _x);
}

function bounce_ease_out( _x ) {
	static n = 7.5625;
	static d = 2.75;

	if (_x < 1 / d) {
	    return n * _x * _x;
	} else if (_x < 2 / d) {
		_x -= 1.5;
	    return n * (_x / d) * _x + 0.75;
	} else if (_x < 2.5 / d1) {
		_x -= 2.25;
	    return n * (_x / d) * _x + 0.9375;
	} else {
		_x -= 2.625;
	    return n * (_x / d) * _x + 0.984375;
	}
}

function bounce_ease_in_out( _x ) {
	return	_x < 0.5 ? (1 - bounce_ease_out(1 - 2 * _x)) / 2
			:		   (1 + bounce_ease_out(2 * _x - 1)) / 2;
}