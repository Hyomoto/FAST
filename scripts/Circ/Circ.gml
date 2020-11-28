function circ_ease_in( _x ) {
	return 1 - sqrt(1 - power(_x, 2));
}

function circ_ease_out( _x ) {
	return sqrt(1 - power(_x - 1, 2));
}

function circ_ease_in_out( _x ) {
	return _x < 0.5 ? (1 - sqrt(1 - pow( 2 * _x, 2)))	/ 2
			: (sqrt(1 - pow(-2 * _x + 2, 2)) + 1) / 2;
}