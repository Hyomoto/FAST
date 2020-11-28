function back_ease_in( _x ) {
	static c1 = 1.70158;
	static c3 = c1 + 1;

	return c3 * _x * _x * _x - c1 * _x * _x;
}

function back_ease_out( _x ) {
	static c1 = 1.70158;
	static c3 = c1 + 1;

	return 1 + c3 * power(_x - 1, 3) + c1 * power(_x - 1, 2);
}

function back_ease_in_out( _x ) {
	static c1 = 1.70158;
	static c2 = c1 * 1.525;

	return	_x < 0.5 ? (power(2 * _x, 2) * ((c2 + 1) * 2 * _x - c2)) / 2
			: (power(2 * _x - 2, 2) * ((c2 + 1) * (_x * 2 - 2) + c2) + 2) / 2;
}