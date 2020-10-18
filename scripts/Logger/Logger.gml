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
	/// @param {mixed}	value	The value to write to the output. Will be converted to a string.
	/// @desc	Writes `value` to the outputs. If the string to be written is longer than the max
	//		length of the Logger, the string will be split at the nearest space, tab or hyphen.
	static write	= function( _value ) {
		var _start	= 0;
		
		_value	= name + " :: " + string( _value );
		
		while ( string_length( _value ) - _start > length ) {
			_start	= string_find_first( " \t-", _value, _start + length );
			
			if ( string_char_at( _value, _start ) == "-" ) {
				_value	= string_insert( "\n", _value, _start + 1 );
				
			} else {
				_value	= string_copy( _value, 1, _start - 1 ) + "\n" + string_delete( _value, 1, _start );
			
			}
			
		}
		if ( ++written >= writeAt && writeAt > 0 ) {
			var _i = 0; repeat( array_length( outputs ) ) {
				outputs[ _i ].write( _value );
				outputs[ _i ].save( true );
				++_i;
			}
			written	= 0;
			
		} else {
			var _i = 0; repeat( array_length( outputs ) ) {
				outputs[ _i ].write( _value );
				++_i;
				
			}
			
		}
		
	}
	/// @desc Calls close() on all of the provided outputs. 
	static close	= function() {
		var _i = 0; repeat( array_length( outputs ) ) {
			outputs[ _i++ ].close();
			
		}
		LogManager().log( "Logger ", name, " has been closed." );
		
	}
	/// @desc Returns the name of this Logger, for debugging purposes.
	static toString	= function() {
		return name;
		
	}
	static is		= function( _data_type ) {
		return _data_type == Logger;
		
	}
	/// @desc An array of the outputs this Logger writes to.
	outputs	= array_create( argument_count - 2 );
	
	var _i = 2; repeat( argument_count - 2 ) {
		outputs[ _i - 2 ]	= argument[ _i ];
		
		++_i;
		
	}
	/// @desc The name of this Logger.
	name	= _name;
	/// @desc The max characters before a string should be split to a new line.
	length	= _length;
	/// @desc How many entries before save() is called on the outputs. Settings this to 0 will disable this behavior.
	writeAt	= 40;
	/// @desc How many entries have been written to this Logger since the last save
	written	= 0;
	
	write( "log opened: " + date_datetime_string(date_current_datetime()) );
	
	LogManager().add( self );
	
}
