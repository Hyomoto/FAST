/// @func Timer
/// @param {string}	*format		The display format, $H, $M and $S will be replaced with hours, minutes, and seconds
/// @desc Timer provides the difference between two times in your program, when it is started
//		and when it is checked.
/// @example
//:create event
//timer = new Timer( "$S second", 2 );
//
//:step event
//if ( timer.elapsed() >= 1000000 ) {
//  show_debug_message( timer );
//	timer.reset()
//}
/// @output	"1 second" is displayed once every second.
/// @wiki Core-Index Constructors
function Timer() : __Struct__() constructor {
	/// @desc Resets the elapsed time to the current moment.
	/// @returns self
	static reset	= function() {
		__Start	= get_timer();
		
		return self;
		
	}
	/// @desc Returns the time elapsed between the start time and now, in microseconds.
	/// @returns int
	static elapsed	= function() {
		return get_timer() - __Start;
		
	}
	/// @desc Returns the elapsed time as a formatted StringTime-formatted string.
	/// @returns string
	static toString	= function() {
		var _passed	= elapsed() / 1000000;
		
		return string_from_time( _passed, __Format );
		
	}
	/// @var {string}	The format string to use to display the elapsed time
	/// @output "$S"
	__Format	= ( argument_count > 0 ? argument[ 0 ] : "$S" );
	/// @var {int} The time at which the timer was started
	__Start		= get_timer();
	
	if ( is_string( __Format ) == false ) { throw new InvalidArgumentType( "Timer", 0, __Format, "string" ); }
	
	__Type__.add( Timer );
	
}
