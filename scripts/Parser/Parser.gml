/// @func Parser
/// @param *string
/// @wiki Core-Index Parsing
function Parser() constructor {
	static parse	= function( _string ) {
		value	= string_trim( _string );
		length	= string_length( value );
		reset();
		
	}
	static clear	= function() {
		last	= 0;
		length	= 0;
		value	= "";
		
	}
	static reset	= function() {
		last	= 0;
		
	}
	static has_next	= function() {
		return ( last < length );
		
	}
	static peek	= function() {
		var _next	= string_find_first( " \t", value, last );
		
		if ( _next == 0 ) {
			return [ string_trim( string_copy( value, last, length - last + 1 ) ), length ];
			
		}
		return [ string_trim( string_copy( value, last, _next - last ) ), _next + 1 ];
		
	}
	static next		= function() {
		if ( has_next() == false ) {
			return undefined;
			
		}
		var _string;
		
		do {
			var _peek	= peek();
			
			_string	= _peek[ 0 ];
			last	= _peek[ 1 ];
			
		} until ( _string != "" );
		
		return _string;
		
	}
	static next_line	= function() {
		if ( has_next() == false ) {
			return undefined;
			
		}
		var _string	= string_copy( value, last, length - last + 1 );
		
		last	= length;
		
		return _string;
		
	}
	static toArray	= function() {
		var _queue	= new DsQueue();
		var _last	= last;
		
		last	= 0;
		
		while ( has_next() ) {
			_queue.enqueue( next() );
			
		}
		var _array	= array_create( _queue.size() );
		
		var _i = 0; repeat( array_length( _array ) ) {
			_array[ _i++ ]	= _queue.dequeue();
			
		}
		last	= _last;
		
		return _array;
		
	}
	static toString	= function() {
		return value;
		
	}
	static is		= function( _data_type ) {
		return _data_type == Parser;
		
	}
	value	= "";
	length	= 0;
	last	= 0;
	
	if ( argument_count > 0 && string( argument[ 0 ] ) != "" ) {
		parse( argument[ 0 ] );
		
	}
	
}
