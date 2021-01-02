function elastic_ease_in( _x ) {
	static c = (2 * PI) / 3;

	return	_x  == 0 ? 0
			: ( _x == 1 ? 1
			: -power(2, 10 * _x - 10) * sin((_x * 10 - 10.75) * c) );
}

function elastic_ease_out( _x ) {
	static c = (2 * PI) / 3;

	return	_x   == 0 ? 0
			: ( _x == 1 ? 1
			: power(2, -10 * _x) * sin((_x * 10 - 0.75) * c) + 1 )
}

function elastic_ease_in_out( _x ) {
	static c = (2 * PI) / 4.5;

	return	_x == 0 ? 0
			: ( _x == 1 ? 1
				: ( _x < 0.5
				? -(pow(2, 20 * _x - 10) * sin((20 * _x - 11.125) * c)) / 2
			: (pow(2, -20 * _x + 10) * sin((20 * _x - 11.125) * c)) / 2 + 1 ) );
}