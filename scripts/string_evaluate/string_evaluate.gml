/// @func evaluate_string
/// @param {string}	string	An expression
/// @desc	Evaluates the given string and returns the result.
/// @returns real
function evaluate_string( _string ) {
	// Function to find precedence of operators.
	static __precedence__	= function( _op ) {
		switch ( _op ) {
			case "+" : case "-" : return 1;
			case "*" : case "/" : return 2;
		}
	    return 0;
		
	}
	// Function to perform arithmetic operations.
	static __get_operation__	= function( _op ) {
	    switch ( _op ) {
			case "+" : return function( _a, _b ) { return _a + _b; };
			case "-" : return function( _a, _b ) { return _a - _b; };
			case "*" : return function( _a, _b ) { return _a * _b; };
			case "/" : return function( _a, _b ) { return _a / _b; };
		}
		throw new __Error__().from_string( "Expression evaluation failed, no operation found for " + string( _op ) + "." );
		
	}
	static __parser__	= new Parser();
	static __values__	= new Stack();
	static __ops__		= new Stack();
	
	__parser__.open( _string );
	
	while ( __parser__.finished() == false ) {
		var _c	= __parser__.read();
	    // Current token is a whitespace, skip it.
	    if ( _c == " " || _c == "\t" ) {
			continue;
			
		} else if ( _c == "(" ) {
	    // Current token is an opening brace, push it to 'ops'
	        __ops__.push( _c );
			
		} else if ( char_is_numeric( _c )) {
			// Current token is a number, push it to stack for numbers.
	        __parser__.unread().mark();
			
			if ( __parser__.peek(2) == "0x" ) { _i += 2; __parser__.advance(2); }
	        // There may be more than one digits in the number.
	        var _i = 0; while ( __parser__.finished() == false ) {
				if ( char_is_numeric( __parser__.read()) == false )
					break;
	            ++_i;
			}
			__parser__.reset();
			
			__values__.push( real( __parser__.peek( _i )) );
            
			__parser__.advance( _i );
	        
		} else if ( _c == ")" ) {
			// Closing brace encountered, solve entire brace.
			while ( __ops__.size() > 0 && __ops__.peek() != "(" ) {
				var _v2		= __values__.pop();
				var _v1		= __values__.pop();
				var _result	= __get_operation__( __ops__.pop() )( _v1, _v2 );
				
				__values__.push( _result );
				
			}
	        __ops__.pop();
			
		} else {
			// Current token is an operator.
	        // While top of 'ops' has same or greater precedence to current token, which is
			// an operator. Apply operator on top of 'ops' to top two elements in values stack.
			while( __ops__.size() > 0 && __precedence__( __ops__.peek() ) >= __precedence__( _c )) {
				var _v2		= __values__.pop();
				var _v1		= __values__.pop();
				var _result	= __get_operation__( __ops__.pop() )( _v1, _v2 );
				
				__values__.push( _result );
				
			}
	        // Push current token to 'ops'.
			__ops__.push( _c );
			
		}
	    
	}
	// Entire expression has been parsed at this point, apply remaining ops to remaining values.
	while( __ops__.size() > 0 ) {
	    var _v2		= __values__.pop();
		var _v1		= __values__.pop();
		var _result	= __get_operation__( __ops__.pop() )( _v1, _v2 );
		
		__values__.push( _result );
		
	}
	// Top of 'values' contains result, return it.
	return __values__.pop();
	
}
