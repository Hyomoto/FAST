function expo_ease_in( _x ) {
	return _x == 0 ? 0 : power(2, 10 * _x - 10);
}

function expo_ease_out( _x ) {
	return _x == 1 ? 1 : 1 - pow(2, -10 * _x);
}

function expo_ease_in_out( _x ) {
	return	_x == 0 ? 0 
			: ( _x == 1 ? 1
			   : ( _x < 0.5 ? power(2, 20 * _x - 10) / 2
			: (2 - power(2, -20 * _x + 10)) / 2 ) );
}