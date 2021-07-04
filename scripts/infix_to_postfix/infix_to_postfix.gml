// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function infix_to_postfix( _string ) {
	// To check if the input character
	// is an operator or a '('
	static __is_operator__	= function( _c ) {
	    switch( _c ) {
			case "+" : case "-" : case "*" : case "/" : case "%" : case "(" :
		        return true;
	    }
		return false;
		
	}
	// To check if the input character is an operand
	static __is_operand__	= function( _c ) {
		if (( _c >= "A" && _c <= "Z" ) || ( _c >= "a" && _c <= "z" ))
		    return true;
		return false;
	}
  
	// Function to return precedence value
	// if operator is present in stack
	static __in_precedence__	= function( _c ) {
		switch( _c ) {
			case "+" : case "-" :
				return 2;
		    case "*" : case "/" : case "%" :
				return 4;
		}
		return 0;
		
	}
  
	// Function to return precedence value
	// if operator is present outside stack.
	static __out_precedence__	= function( _c ) {
	    switch( _c ) {
			case "+" : case "-" :
				return 1;
			case "*" : case "/" : case "%" :
				return 3;
		}
		return 100;
		
	}
	// Function to convert infix to postfix
	var _i	= 0;
	var _s	= new Stack();
	var _output	= "";
	
	// While input is not undefined iterate
	while( _i < string_length( _string )) {
		var _c	= string_char_at( _string, ++_i )
	    // If character an operand
	    if ( __is_operand__( _c ) ) {
	        _output	+= _c;
		
	    // If input is an operator, push
		} else if ( __is_operator__( _c ) ) {
	        if ( _s.is_empty() || __out_precedence__( _c ) > __in_precedence__( _s.peek() )) {
	            _s.push( _c );
				
			} else {
	            while( _s.size() > 0 && __out_precedence__( _c ) <  __in_precedence__( _s.peek() )) {
	                _output += _s.pop();
	                
				}
	            _s.push( _c );
				
			}
	    // Condition for opening bracket
		} else if ( _c == ")" ) {
	        while( _s.peek() != "(" ) {
	            _output	+= _s.pop();
	            
	            // If opening bracket not present
	            if ( _s.is_empty() )
	                throw new __Error__().from_string("infix_to_postfix failed because ')' did not have a matching bracket");
			}
	        // pop the opening bracket.
	        _s.pop()
		} 
	    
	}
	// pop the remaining operators
	while( _s.size() > 0 ) {
	    if( _s.peek() == "(" )
	        throw new __Error__().from_string("infix_to_postfix failed because '(' did not have a matching bracket");
	    _output	+= _s.pop();
	    
	}
	return _output;
	
}