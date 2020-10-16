/// @func Logger
/// @param {string}			name		The name of the logger, will be used to differentiate its output
/// @param {intp}			length		The maximum length of a line before it should wrap
/// @param {GenericOutput}	Outputs...	The outputs that this Logger will write to
/// @desc	Logger is used to write custom debug and logging routines.  You simply give it a name,
//		a truncation length, and a list of outputs.  The outputs should inherit from (#GenericOutput) to
//		ensure compatibility.  A common use is to write something that should appear in the GMS Output
//		window, as well as be written to an external file.  Additionally, the use of multiple loggers
//		allows separating where messages are coming from easily.
/// @example
//global.debug	= new Logger( "debug", FAST_LOGGER_DEFAULT_LENGTH, System, new FileText( "log/debug.text" ) )
//
//debug.write( "Hello World!" );
/// @wiki Core-Index Logging
function Logger( _name, _length, _output ) constructor {
	static toString	= function() {
		return name;
		
	}
	static write	= function( _value ) {
		var _start	= 0;
		
		_value	= name + " :: " + string( _value );
		
		while ( string_length( _value ) - _start > length ) {
			_start	= string_find_first( "	 -", _value, _start + length );
			
			if ( string_char_at( _value, _start ) == "-" ) {
				_value	= string_insert( "\n", _value, _start + 1 );
				
			} else {
				_value	= string_copy( _value, 1, _start - 1 ) + "\n" + string_delete( _value, 1, _start );
			
			}
			
		}
		var _i = 0; repeat( array_length( outputs ) ) {
			outputs[ _i ].write( _value );
			
			if ( outputs[ _i ].size() >= writeAt ) {
				outputs[ _i ].save();
				
			}
			++_i;
			
		}
		
	}
	static close	= function( _value ) {
		var _i = 0; repeat( array_length( outputs ) ) {
			outputs[ _i++ ].close( _value );
			
		}
		System.write( "Logger ", name, " has been closed." );
		
	}
	static clear	= function( _value ) {
		var _i = 0; repeat( array_length( outputs ) ) {
			outputs[ _i++ ].clear( _value );
			
		}
		
	}
	static is		= function( _data_type ) {
		return _data_type == Logger;
		
	}
	outputs	= array_create( argument_count - 2 );
	
	var _i = 2; repeat( argument_count - 2 ) {
		outputs[ _i - 2 ]	= argument[ _i ];
		
		++_i;
		
	}
	name	= _name;
	length	= _length;
	writeAt	= 40;
	
	clear();
	write( "log opened: " + date_datetime_string(date_current_datetime()) );
	
	LogManager().add( self );
	
}
