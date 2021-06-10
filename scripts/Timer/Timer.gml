/// @func Timer
/// @param {string}	format		The display format, $H, $M and $S will be replaced with hours, minutes, and seconds
/// @param {int}	decimals	How many decimals each time unit should contain
/// @desc Timer provides the difference between two times in your program, when it is created
//		and when it is checked. It can be used to get the elapsed time or as a formatted string.
/// @example
//var _timer = new Timer( "$S seconds", 2 );
//
//if ( _timer.elapsed() > 100000 ) {
//  show_debug_message( string( _timer ) );
//}
/// @wiki Core-Index
function Timer() constructor {
	/// @desc Resets the elapsed time to the current moment.
	static reset	= function() {
		start	= get_timer();
		
	}
	/// @desc Returns the time elapsed between the start time and now, in microseconds.
	/// @returns intp
	static elapsed	= function() {
		return get_timer() - start;
		
	}
	/// @desc Returns the elapsed time as a formatted StringTime-formatted string.
	static toString	= function() {
		var _passed	= elapsed() / 1000000;
		
		return time_to_string( _passed, decimals, format );
		
	}
	static is		= function( _data_type ) {
		return _data_type == Timer;
		
	}
	/// @var {string}	The formatting string to use to display the elapsed time
	/// @ouput "$S"
	format		= ( argument_count > 0 ? argument[ 0 ] : "$S" );
	/// @var {int} The number of decimals to show in the result
	/// @output 1
	decimals	= ( argument_count > 1 ? argument[ 1 ] : 1 );
	/// @var {int} The number of microseconds since the timer was last started
	start	= 0;
	
	reset();
	
}
