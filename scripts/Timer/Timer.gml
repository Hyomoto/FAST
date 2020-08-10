/// @func Timer
/// @param *format
/// @param *decimals
function Timer() constructor {
	static elapsed	= function() {
		return get_timer() - start;
		
	}
	static toString	= function() {
		var _passed	= elapsed() / 1000000;
		
		text.set( _passed );
		
		return text.toString();
		
	}
	var _format		= ( argument_count > 0 ? argument[ 0 ] : "$S" );
	var _decimals	= ( argument_count > 1 ? argument[ 1 ] : 1 );
	
	start	= get_timer();
	text	= new StringTime( 0, _decimals, _format );
	
}
