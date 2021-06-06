/// @ func StringFormatter
function StringFormatter() constructor {
	static format	= function( _string ) {
		if ( not is_string( _string ) ) { return; }
		
		content	= _string;
		ignore	= false;
		read	= 1;
		
		var _rule; repeat( string_length( _string ) ) {
			_rule	= ds_map_find_value( rules, string_char_at( content, read ) );
			
			if ( _rule == undefined ) { advance(); continue }
			
			_rule( read );
			
		}
		return content;
		
	}
	static strip	= function( _i ) {
		if ( ignore ) { advance(); return; }
		
		content	= string_delete( content, _i, 1 );
		
	}
	static insert	= function( _i, _v ) {
		if ( ignore ) { advance(); return; }
		
		content	= string_insert( _v, content, _i );
		
		advance();
		
	}
	static advance	= function() {
		++read;
		
	}
	static safexor	= function() {
		if ( ignore ) { unsafe(); } else { safe(); }
		
	}
	static safe	= function() {
		ignore	= true;
		
	}
	static unsafe	= function() {
		ignore	= false;
		
	}
	static rule		= function( _char, _lambda ) {
		static __allowedRules	= new Array( [ "advance", "insert", "strip" ] );
		
		var _i = 1; repeat( string_length( _char ) ) {
			if ( is_string( _lambda ) ) {
				if ( not __allowedRules.contains( _lambda ) ) { continue; }
				
				rules[? string_char_at( _char, _i++ ) ]	= variable_struct_get( self, _lambda );
				
			} else {
				rules[? string_char_at( _char, _i++ ) ]	= method( self, _lambda );
				
			}
			
		}
		
	}
	static destroy	= function() {
		ds_map_destroy( rules );
		
	}
	rules	= ds_map_create();
	content	= undefined;
	ignore	= false;
	read	= 0;
	
}
