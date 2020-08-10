/// @func Output
/// @param *function
/// @desc	a generic Output template object
function Output() constructor {
	static write	= function() {};
	static close	= function() {};
	static clear	= function() {};
	
	if ( argument_count > 0 ) {
		write	= argument[ 0 ];
		
	}
	
}
