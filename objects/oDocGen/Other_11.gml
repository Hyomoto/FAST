/// @desc find header
header	= {
	toString : function() {
		var _string = "";
		_string += "|Jump To|[`Go Back`](" + ( wiki != undefined ? repo + wiki.index : "" ) + ")|[Arguments](#arguments)|[Methods](#methods)|[Variables](#variables)|" + "\n"
		_string += "|---|---|---|---|---|" + "\n"
		_string += ">## " + name + "(" + argstr + ")" + "\n"
		if ( implements != undefined ) {
			_string	+= "*Implements:* [" + implements + "()](" + repo + implements + ")" + "\n\n";
			
		}
		_string += desc + "\n"
		_string += "```GML" + "\n"
		_string += example + "\n";
		_string += "```" + "\n"
		_string += "## Arguments" + "\n"
		_string += "|Name|Type|Purpose|" + "\n"
		_string += "|---|---|---|" + "\n"
		var _last = undefined; repeat( arguments.size() ) {
			if ( _last != undefined ) { _string += "\n"; }
			
			_last	= arguments.next( _last );
			
			_string	+= string( _last.value );
			
		}
		if ( arguments.size() == 0 ) {
			_string += "|None|||" + "\n"
			
		}
		return _string + "\n";
		
	},
	name : undefined,
	desc : "no description provided",
	arguments : new DsLinkedList(),
	argstr : "",
	example : "// no example provided",
	wiki : undefined,
	implements : undefined,
	repo : other.repo
};
repeat( target.remaining() ) {
	var _read	= string_trim( target.read() );
	
	if ( string_copy( _read, 1, 8 ) == "function" ) { break; }
	
	_read	= find_tag( _read );
	
	if ( _read == undefined ) { continue; }
	
	if ( _read[ 0 ] == "@func" ) {
		header.name	= _read[ 1 ];
		
		break;
		
	}
	
}
if ( header.name == undefined ) { header = undefined; exit; }

repeat( target.remaining() ) {
	var _read	= find_tag( target.read() );
	
	if ( _read == undefined ) { --target.next; break; }
	
	if ( _read[ 0 ] == "@wiki" ) {
		var _next	= string_find_first( " \t", _read[ 1 ], 0 );
		
		if ( _next == 0 ) {
			_read	= [ _read[ 1 ], "Default" ];
			
		} else {
			_read	= [ strc( _read[ 1 ], 1, _next - 1 ), strd( _read[ 1 ], 1, _next ) ];
			
		}
		header.wiki	= { path : repo, index : _read[ 0 ], table : _read[ 1 ] };
		
	} else if ( _read[ 0 ] == "@param" ) {
		header.arguments.add( new make_argument( _read[ 1 ] ) );
		
	} else if ( _read[ 0 ] == "@desc" ) {
		header.desc	= _read[ 1 ];
		
		repeat( target.remaining() ) {
			_read	= target.read();
			
			if ( find_tag( _read ) == undefined && string_copy( _read, 1, 2 ) == "//" ) {
				header.desc	+= " " + strd( _read, 1, 2 );
				
				continue;
				
			}
			header.desc = get_description( header.desc );
			
			--target.next;
			
			break;
			
		}
		
	} else if ( _read[ 0 ] == "@example" ) {
		header.example	= "";
		
		repeat( target.remaining() ) {
			_read	= target.read();
			
			if ( find_tag( _read ) == undefined && string_copy( _read, 1, 2 ) == "//" ) {
				header.example	+= ( header.example != "" ? "\n" : "" ) + strd( _read, 1, 2 );
				
				continue;
				
			}
			--target.next;
			
			break;
			
		}
		
	}
	
}
var _string	= "";

var _last = undefined; repeat( header.arguments.size() ) {
	if ( _last != undefined ) { _string += "," }
	
	_last	= header.arguments.next( _last );
	
	_string	+= " " + _last.value.name;
	
}
header.argstr = ( _string == "" ? "" : _string + " " );

repeat( target.remaining() ) {
	var _read	= string_trim( target.read() );
	
	if ( string_copy( _read, 1, 8 ) == "function" ) {
		var _implement	= string_explode( _read, ":", true );
		
		if ( array_length( _implement ) > 1 ) {
			_implement	= strc( _implement[ 1 ], 1, string_pos( "constructor", _implement[ 1 ] ) - 1 );
			
			header.implements = strc( _implement, 1, string_pos( "(", _implement ) - 1 );
						
		}
		--target.next;
		
		break;
		
	}
	
}
