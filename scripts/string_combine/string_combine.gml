#macro stc	string_combine
/// @func string_combine
/// @params {mixed}	values...	The values to concantate
/// @desc	Combines the provided values together into one string and returns it.  Will call
///		string() on any value provided, so the outcome will always be a string.
/// @example
//string_combine( "Hello", " ", "World!" );
/// @output "Hello World!"
/// @returns string
/// @alias stc
/// @wiki Core-Index Functions
function string_combine() {
	var _string = "";
	
	for ( var _i = 0; _i < argument_count; _i++ ) {
		_string	+= string( argument[ _i ] );
		
	}
	return _string;
	
}
