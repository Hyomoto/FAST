/// @func string_from_time
/// @param {real}	seconds	The number of seconds to convert
/// @param {string}	format	The format to use
/// @desc	Given a number of seconds, formats the time using the given formatting string.	If seconds
///		is not a number, or format is not a string, InvalidArgumentType will be thrown.
/// @example
//string_from_time( 2410623, "$H hours $M.MM minutes" );
/// @output 669 hours 37.05 minutes
/// @throws InvalidArgumentType
/// @returns string
function string_from_time( _sec, _format ) {
	if ( is_numeric( _sec ) == false ) { throw new InvalidArgumentType( "string_from_time", 0, _sec, "integer" ); }
	if ( is_string( _format ) == false ) { throw new InvalidArgumentType( "string_from_time", 1, _format, "string" ); }
	
	static __get__	= function( _format, _start, _char, _time ) {
		static __format__	= function( _start, _char, _format ) {
			var _i		= _start;
			var _pos	= [ 0, 0, "" ];
			var _index	= 0;
			
			while( _i <= string_length( _format ) ) { ++_i;
				var _c	= string_char_at( _format, _i );
				
				if ( _c == "." ) {
					if ( _index == 1 ) { break; }
					_index	= 1;
					
				} else if ( _c == _char )
					_pos[ _index ]	+= 1;
				else
					break;
				
			}
			_pos[ 2 ]	= string_copy( _format, _start, _i - _start );
			
			return _pos;
			
		}
		var _pos	= __format__( _start, _char, _format );
		var _l		= string( floor( _time ) );
		var _r		= string_format( _time % 1, 0, _pos[ 1 ] );
		
		var _string	= ( max( _pos[ 0 ] - string_length( _l ), 0 ) * "0" ) + _l + 
			string_copy( _r, 2, _pos[ 1 ] + 1 );
		
		_format	= string_replace( _format, _pos[ 2 ], _string );
		
		return _format;
		
	}
	static __Seek	= [
		["$H", 3600 ],
		["$M", 60 ],
		["$S", 1 ]
	];
	// $H.HH
	var _i = -1; repeat( array_length( __Seek ) ) { ++_i;
		var _time	= string_pos( __Seek[ _i ][ 0 ], _format );
		
		if ( _time == 0 ) { continue; }
		
		_format	= __get__( _format, _time, string_char_at( __Seek[ _i ][ 0 ], 2 ), _sec / __Seek[ _i ][ 1 ] );
		
		_sec	= _sec mod __Seek[ _i ][ 1 ];
		
	}
	return _format;
	
}
