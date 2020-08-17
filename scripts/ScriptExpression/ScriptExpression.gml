#macro SCRIPT_ASSIGNMENT	0
#macro SCRIPT_COMPARISON	1
#macro SCRIPT_OPERAND		2
#macro SCRIPT_EXPRESSION	3
#macro SCRIPT_FUNCTION		4
#macro SCRIPT_VARIABLE		5
#macro SCRIPT_VALUE			6

/// @func ScriptExpression
/// @param string
function ScriptExpression( _string ) : DsWalkable() constructor {
	static __assignment	= function( _value ) constructor {
		value	= _value;
		code	= SCRIPT_ASSIGNMENT;
		
	}
	static __comparison	= function( _value ) constructor {
		value	= _value;
		code	= SCRIPT_COMPARISON;
		
	}
	static __operand	= function( _value ) constructor {
		value	= _value;
		code	= SCRIPT_OPERAND;
		
	}
	static __expression	= function( _value ) constructor {
		value	= _value;
		code	= SCRIPT_EXPRESSION;
		
	}
	static __function	= function( _value ) constructor {
		var _args	=  string_pos( "(", _value );
	
		value	= string_copy( _value, 1, _args - 1 );
		code	= SCRIPT_FUNCTION;
		args	= string_explode( string_copy( _value, _args + 1, string_length( _value ) - _args - 1 ), ",", true );
		
		var _i = 0; repeat( array_length( args ) ) {
			args[ _i ]	= new ScriptExpression( args[ _i ] );
			
			_i++;
			
		}
		
	}
	static __variable	= function( _value ) constructor {
		value	= _value;
		code	= SCRIPT_VARIABLE;
		
	}
	static __value		= function( _value ) constructor {
		value	= _value;
		code	= SCRIPT_VALUE;
		
	}
	static last	= function() {
		if ( links == 0 ) { return undefined; }
		
		return step.value;
		
	}
	static toString	= function() {
		var _string	= "(";
		var _last	= step;
		
		step	= self;
		
		while ( has_next() ) {
			_string	+= string( next().value );
			
		}
		step	= _last;
		
		return _string + ")";
		
	}
	source	= _string;
	assign	= false;
	operate	= false;
	
	var _parser	= new ScriptParser( _string );
	var _read;
	
	while ( _parser.has_next() ) {
		_read	= _parser.next();
		
		if ( _read == "=" ) {
			add( new __assignment( _read ) );
			
			assign	= true;
			
		} else if ( string_find_first( "=<>&|", _read, 0 ) > 0 ) {
			add( new __comparison( _read ) );
			
		} else if ( string_pos( _read, "+/-*" ) ) {
			add( new __operand( _read ) );
			
		} else if ( string_char_at( _read, 1 ) == "(" ) {
			add( new __expression( new ScriptExpression( string_copy( _read, 2, string_length( _read ) - 2 ) ) ) );
			
		} else if ( string_pos( "(", _read ) > 0 ) {
			add( new __function( _read ) );
			
		} else if ( string_letters( string_char_at( _read, 1 ) ) != "" ) {
			add( new __variable( _read ) );
		
		} else if ( string_char_at( _read, 1 ) == "\"" ) {
			add( new __value( string_copy( _read, 2, string_length( _read ) - 2 ) ) );
			
		} else {
			add( new __value( string_to_real( _read ) ) );
			
		}
		
	}
	
}
