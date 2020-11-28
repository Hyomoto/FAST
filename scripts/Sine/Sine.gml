function sine_ease_in( _x ) {
	return 1 - cos((_x * PI) / 2);
}

function sine_ease_out( _x ) {
	return sin((_x * PI) / 2);
}

function sine_ease_in_out( _x ) {
	return -(cos(PI * _x) - 1) / 2;
}