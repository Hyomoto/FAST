/// @func string_con( values... );
/// @params values...
/// @returns string
/// @wiki Core-Index Functions
function string_con() {
	var _string = "";
	
	for ( var _i = 0; _i < argument_count; _i++ ) {
		_string	+= string( argument[ _i ] );
		
	}
	return _string;
	
}
