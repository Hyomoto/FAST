/// @func string_con
/// @params {mixed}	values...	The values to concantate
/// @desc	Combines the provided values together into one string and returns it.  Will call
///		string() on any value provided, so the outcome will always be a string.
/// @example
//string_con( "Hello", " ", "World!" );
/// @output "Hello World!"
/// @returns string
/// @wiki Core-Index Functions
function string_con() {
	var _string = "";
	
	for ( var _i = 0; _i < argument_count; _i++ ) {
		_string	+= string( argument[ _i ] );
		
	}
	return _string;
	
}
