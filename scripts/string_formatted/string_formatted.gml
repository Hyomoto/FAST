#macro strf	string_formatted
/// @func string_formatted
/// @param {string}	string		The string to format
/// @param {mixed}	values...	optional: The values to add to the string
/// @desc	Formats the provided string with the given values. Insertion points are denoted with
///		{}, and you can escape with \{.  The format is {[[fill]align][width][.precision][type]}
///		where fill is the character used to fill in space when width is greater than the value
///		length.  Alignments are <,^,> for left, center and right justify.  Precision is only
///		valid for number types and will be ignored for strings.  Lastly, the only type currently
///		supported is 'f' for floating point.  Integers can be used by omitting precision.
/// @example
//string_format("{} World!", "Hello");
/// @output Hello World!
/// @alias strf
/// @returns string
function string_formatted( _string ) {
	// replace segment of internal string
	static __replace__	= function( _sub, _str, _l, _r ) {
		return string_copy( _str, 1, _l - 1 ) + _sub + string_delete( _str, 1, _r );
		
	}
	// retrieve formatting info
	static __get_format__	= function( _string, _f, _start, _epos ) {
		static __is_align__	= function( _c ) {
			switch ( _c ) {
				case "<" : case ">" : case"=" : case "^" :
					return true;
				default:
					return false;
			}
			
		}
		static __is_sign__	= function( _c ) {
			switch ( _c ) {
				case " " : case "+" : case "-" :
					return true;
				default:
					return false;
			}
		
		}
		static __get_integer__	= function( _string, _pos ) {
			var _end	= string_length( _string );
			var _digits	= 0;
		    
		    repeat ( _end - _pos + 1 ) {
				var _dv	= string_char_at( _string, _pos );
		        
				if ( _dv < "0" || "9" < _dv )
		            break;
				++_digits;
				++_pos;
				
		    }
		    return _digits;
			
		}
		var _pos		= _start;
		var _adv		= 0;
		var _char		= string_char_at( _string, _pos );
		
		// parse alignment and fill
		if ( _epos >= 2 && __is_align__(string_char_at( _string, _pos+1 )) ) {
			_f.align	= string_char_at( _string, _pos+1 );
			_f.fill		= _char;
			_pos	+= 2;
			_epos	-= 2;
			
		} else if ( _epos >= 1 && __is_align__(string_char_at( _string, _pos )) ) {
			_f.align	= string_char_at( _string, _pos );
			_pos	+= 1;
			_epos	-= 1;
			
		}
		_adv	= __get_integer__( _string, _pos );
		
		if ( _adv > 0 ) {
			_f.width	= real( string_copy( _string, _pos, _adv ));
			_pos	+= _adv;
			_epos	-= _adv;
			
		}
		if ( _epos && string_char_at( _string, _pos ) == "." ) {
			_adv	= __get_integer__( _string, ++_pos );
			
			if ( _adv > 0 ) {
				_f.prec	= real( string_copy( _string, _pos, _adv ));
				_pos	+= _adv;
				_epos	-= _adv;
				
			}
			
		}
		if ( _epos )
			_f.type = string_char_at( _string, _pos );
		
		return _pos;
		
	}
	static __get_id__	= function( _string, _start ) {
		var _len	= 0;
		repeat( string_length( _string ) - _start ) {
			var _dv	= string_char_at( _string, _start + _len );
			
			if ( _dv == "}" || _dv == ":" )
				break;
			++_len;
		}
		return _len;
		
	}
	static __pad__	= function( _string, _f ) {
		var _num	= string_length( _string );
		var _total	= 0;
		var _l		= 0;
		var _r		= 0;
		
		if ( _num > _f.width)
			_total = _num;
		else
			_total = _f.width;
		// calc leading space
		switch ( _f.align ) {
			case ">":
				_l	= _total - _num; break;
			case "^":
				_l	= (_total - _num) div 2; break;
			case "<" : case "=" :
				_l = 0;
		}
		_r = _total - _num - _l;
		
		return string_repeat( _f.fill, _l ) + _string + string_repeat( _f.fill, _r );
		    
	}
	var _f	= {fill: " ", align: "<", width: -1, prec: 0, type: ""}
	var _i	= string_pos_ext( "{", _string, 0 );
	var _a	= 1;
	
	while ( _i > 0 && _a < argument_count ) {
		// skip any escaped {'s
		if ( string_char_at( _string, _i - 1 ) == "\\" ) {
			_string	= string_delete( _string, _i-- - 1, 1 );
			continue;
		}
		// seek other bracket
		var _c	= string_pos_ext( "}", _string, _i ) - _i;
		
		if ( _c == 0 )
			break;
		// reset struct
		_f.fill = " "; _f.align = "<"; _f.width = -1; _f.prec = 0; _f.type = "";
		
		var _p	= __get_id__( _string, _i + 1 );
		var _id	= -1;
		var _v;
		var _s	= _i;
		var _e	= _i + _c;
		// find id
		if ( _p > 0 &&  _i + _p < _i + _c ) {
			var _dv	= string_char_at( _string, _i + 1 );
			
			_id	= string_copy( _string, _i + 1, _p );
			
			if ( "0" <= _dv || _dv <= "9" )
				_id	= real( _id );
			_c	-= _p;
			_i	= _p + 1;
			
		} else { ++_i; --_c; }
		
		// if format remains, format
		if ( _c - 1 > 0 )
			_i	= __get_format__( _string, _f, _i + 1, _c - 1 );
		
		// look up value
		if ( is_numeric( _id )) {
			if ( _id == -1 ) { _v = argument[ _a++ ]; }
			else { _v = argument[ _id + 1 ]; }
		} else {
			_v = variable_struct_get( argument[ 1 ], _id );
		}
		
		// format, this should be abstracted to type at some point
		if ( _f.type != "" ) {
			_v	= string_format( _v, 0, _f.prec );
			_p	= string_pos( ".", _v ) - 1;
			// no decimal, whole number
			if ( _p < 1 )
				_p = string_length( _v );
			if ( _p < _f.width )
				_v	= string_repeat( _f.fill, _f.width - _p ) + _v;
			
		} else
			_v	= string( _v );
		// apply padding
		_v	= __pad__( _v, _f );
		
		// do replacement
		_string	= __replace__( _v, _string, _s, _e );
		
		// find next bracket
		_i	= string_pos_ext( "{", _string, _s + string_length( _v ) - 1);
		
	}
	return _string;
	
}
