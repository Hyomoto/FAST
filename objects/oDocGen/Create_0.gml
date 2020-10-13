// whether or not to output verbose messages during compilation
verbose		= true;
// whether or not to overwrite files that already exist
overwrite	= true;
// if true, the file(s) will be copied to the clipboard instead
clipboard	= false;

/// @func strd
/// @param string
/// @param index
/// @param count
strd	= function( _string, _start, _count ) {
	return string_trim( string_delete( _string, _start, _count ) )
	
}
/// @func strc
/// @param string
/// @param index
/// @param count
strc	= function( _string, _start, _count ) {
	return string_trim( string_copy( _string, _start, _count ) )
	
}
error	= function() {
	var _string	= "ERROR in " + target.name + " ::\n";
	
	var _i = 0;repeat( argument_count ) {
		_string	+= string( argument[ _i++ ] );
		
	}
	++errors;
	
	syslog( _string );
	
}
trace	= function() {
	if ( verbose == false ) { return; }
	
	var _string	= "";
	
	var _i = 0;repeat( argument_count ) {
		_string	+= string( argument[ _i++ ] );
		
	}
	syslog( _string );
	
}
next_quote	= function( _string, _ext ) {
	for ( var _i = _ext + 1; _i < string_length( _string ); ++_i ) {
		if ( string_char_at( _string, _i ) == "\\" ) { ++_i; }
		else if ( string_char_at( _string, _i ) == "\"" ) {
			return _i;
			
		}
		
	}
	return 0;
	
}
get_description	= function( _string ) {
	_string	= string_replace_all( _string, "\\t", "\t" );
	_string	= string_replace_all( _string, "\\n", "\n" );
	
	var _links	= string_pos( "(#", _string );
	var _cap, _link;
	
	while ( _links > 0 ) {
		_cap	= string_pos_ext( ")", _string, _links );
		
		if ( _cap == 0 ) { break; }
		
		_link	= string_copy( _string, _links + 2, ( _cap - _links - 2 ) );
		_link	= "[" + _link + "](" + repo + _link + ")";
		
		_string	= string_copy( _string, 1, _links - 1 ) + _link + string_delete( _string, 1, _cap );
		
		_links	= string_pos( "(#", _string );
		
	}
	return _string;
	
}
find_tag	= function( _string ) {
	_string		= string_trim( _string );
	
	if ( string_copy( _string, 1, 3 ) == "///" ) {
		_string	= strd( _string, 1, 3 );
		
	} else if ( string_copy( _string, 1, 2 ) == "//" ) {
		_string	= strd( _string, 1, 2 );
		
	} else {
		return undefined;
		
	}
	if ( string_copy( _string, 1, 1 ) != "@" ) {
		return undefined;
		
	}
	var _snip	= string_find_first( " \t", _string, 0 );
	
	return ( _snip == 0 ? [ _string ] : [ string_copy( _string, 1, _snip - 1 ), strd( _string, 1, _snip ) ] );
	
}
return_lookup	= function( _string ) {
	static __table	= function( _string ) {
		switch ( _string ) {
			case "null" : return "`undefined`";
			case "intp" : return "int (`0..`)";
			case "intn" : return "int (`..0`)";
			case "int"  : return "int (`..0..`)";
			case "real" : return "real (`0.00`)";
			case "float": return "float (`0.00`)";
			case "string" : return "string (`\"string\"`)";
			case "array": return "array (`[values...]`)";
			case "list" : return "list (`[|values...]`)";
			case "map"  : return "map (`[?values...]`)";
			case "self" : return "`self`";
			case "boolean" :
			case "bool" : return "boolean (`true` or `false`)";
			
		}
		return _string;
		
	}
	var _strings	= string_explode( _string, "||", true );
	var _result		= "";
	
	for ( var _i = 0; _i < array_length( _strings ); ++_i ) {
		if ( string_pos( " ", _strings[ _i ] ) > 0 ) {
			var _pos	= string_pos( " ", _strings[ _i ] );
			
			_result += string_copy( _strings[ _i ], 1, _pos - 1 ) + " (" + string_delete( _strings[ _i ], 1, _pos ) + ")";
			
		} else {
			if ( _i > 0 && _i < array_length( _strings ) - 1 ) { _result += ", " }
			else if ( _i > 0 && _i == array_length( _strings ) - 1 ) { _result += ", or " }
			
			_result += __table( _strings[ _i ] );
			
		}
		
	}
	return _result;
	
}
make_variable	= function( _string, _desc ) constructor {
	static toString	= function() {
		return "* " + name + " - " + desc;
		
	}
	name	= _string;
	desc	= _desc;
	
}
make_function	= function( _string, _args, _desc, _ret ) constructor {
	static toString	= function() {
		var _string = "";
		_string	+= "> ### " + name + "(" + argstr + ")" +"\n";
		_string += "*Returns:* " + returns + "\n";
		_string	+= "|Name|Type|Purpose|" + "\n";
		_string	+= "|---|---|---|" + "\n";
		if ( array_length( args ) == 0 ) {
			_string	+= "|None|||" + "\n";
			
		}
		var _i = 0; repeat( array_length( args ) ) {
			_string	+= string( args[ _i ] ) + "\n";
			++_i;
		}
		_string	+= "\n";
		if ( desc != undefined ) { _string	+= desc + "\n"; }
		_string	+= "***" + "\n";
		
		return _string;
		
	}
	_args	= string_replace_all( _args, "_", "" );
	
	ignore	= false;
	
	name	= _string;
	argstr	= _args;
	desc	= _desc;
	returns	= ( _ret == undefined ? "N/A (`undefined`)" : _ret );
	args	= string_explode( _args, ",", true );
	
	if ( _string == "is" ) {
		name	= "is";
		argstr	= " type ";
		returns	= other.return_lookup( "bool" );
		desc	= ( _desc == undefined ? "Returns `true` if the provided type is " + string( other.header.name ) + "." : _desc );
		args	= [ "{struct id} type The structure type to compare this against." ];
		
	} else if ( _string == "toArray" ) {
		name	= "toArray";
		argstr	= "";
		returns	= ( _ret == undefined ? other.return_lookup( "array" ) : _ret );
		desc	= ( _desc == undefined ? "Returns the structure as a array." : _desc );
		
	} else if ( _string == "toString" ) {
		name	= "toString";
		argstr	= "";
		returns	= other.return_lookup( "string" );
		desc	= ( _desc == undefined ? "Returns the structure as a string." : _desc );
		
	}
	var _i = 0; repeat( array_length( args ) ) {
		with ( other ) {
			other.args[ _i ]	= new make_argument( other.args[ _i ] );
		}
		++_i;
		
	}
	if ( other.args.empty() == false ) {
		var _i = 0; repeat( other.args.size() ) {
			args[ _i++ ]	= other.args.dequeue();
			
		}
		argstr	= " ";
		
		var _i = 0; repeat( array_length( args ) ) {
			if ( _i > 0 ) { argstr += ", "; }
			
			argstr	+= args[ _i++ ].name;
			
		}
		argstr += " ";
		
	}
	pattern	= string_lower( _string + string_replace_all( argstr, " ", "-" ) );
	pattern	= string_replace_all( pattern, ",", "" );
	
}
make_argument	= function( _string ) constructor {
	static toString	= function() {
		return "|`" + name + "`|" + type + "|" + desc + "|";
		
	}
	name	= "";
	type	= "undef";
	desc	= "";
	
	if ( string_pos( "{", _string ) == 1 ) {
		var _end	= string_pos( "}", _string );
		
		type	= string_copy( _string, 2, _end - 2 );
		
		_string	= other.strd( _string, 1, _end );
		
	}
	var _rest	= string_find_first( " \t", _string, 0 );
	
	if ( _rest > 0 ) {
		name	= string_copy( _string, 1, _rest - 1 );
		
		_string	= other.strd( _string, 1, _rest );
		
	} else {
		name	= _string;
		_string	= "";
		
	}
	desc	= _string;
	
}
TOC = function() constructor {
	static add	= function( _wiki, _table, _data ) {
		if ( pages[? _wiki ] == undefined ) {
			ds_map_add_map( pages, _wiki, ds_map_create() );
			
		}
		_wiki	= pages[? _wiki ];
		
		if ( _wiki[? _table ] == undefined ) {
			ds_map_add_list( _wiki, _table, ds_list_create() );
			
		}
		_table	= _wiki[? _table ];
		
		ds_list_add( _table, _data );
		
	}
	static destroy	= function() {
		ds_map_destroy( pages );
		
	}
	pages	= ds_map_create();
	
}
files	= new DsQueue();
total	= 0;
complete= 0;
display	= "0/0";
perc	= 1.0;

x		= floor( room_width * 0.1 );
y		= floor( room_height * 0.75 );
w		= floor( room_width * 0.80 );
h		= 64;

bg	= new Surface( w, h );
fg	= new Surface( w, h );

target	= undefined;
path	= undefined;
output	= undefined;
repo	= "https://github.com/Hyomoto/FASTv33/wiki/"

header		= undefined;
methods		= undefined;
args		= undefined;

errors		= 0;
final		= 0;
table		= undefined;
