/// @desc write methods
methods		= {
	toString : function() {
		var _header		= "";
		var _methods	= "";
		var _footer		= true;
		_header	+= "## Methods" + "\n";
		
		var _functions	= "|Jump To|[`top`](#)|";
		var _width		= string_length( _functions );
		var _max		= 11;
		
		var _i = 2, _last = undefined; repeat( list.size() ) {
			// find next method
			_last	= list.next( _last );
			
			if ( _i == 11 ) {
				_functions	+= "\n" + string_repeat( "|---", 11 ) + "|" + "\n||";
				_footer	= false;
				_i = 1;
			}
			
			_methods	+= string( _last.value );
			
			if ( _last.value.ignore ) { continue; }
			
			_functions += ( _footer ? "[" + _last.value.name + "]" : "[**" + _last.value.name + "**]" ) + "(#" + _last.value.pattern + ")|";
			++_i;
			
		}
		_functions	+= ( _footer ? "\n" + string_repeat( "|---", _max - _i ) + "|" : "" ) + "\n";
		
		_header	+= _functions;
		
		if ( list.size() == 0 ) {
			_methods	+= "\nNo methods for this structure." + "\n";
			
		}
		var _variables	= "";
		_variables	= "## Variables" + "\n";
		_variables	+= "|Jump To|[`top`](#)|" + "\n";
		_variables	+= "|---|---|" + "\n\n";
		
		if ( vars.size() == 0 ) {
			_variables	+= "No variables for this structure." + "\n";
			
		}
		var _last = undefined; repeat( vars.size() ) {
			_last	= vars.next( _last );
			
			_variables	+= string( _last.value ) + "\n";
			
		}
		return _header + _methods + _variables;
		
	},
	list : new DsLinkedList(),
	vars : new DsLinkedList()
}
variables	= new DsLinkedList();
args		= new DsQueue();

var _open	= 0;
var _desc	= undefined;
var _ret	= undefined;
var _over	= false;
var _ignore	= false;

while ( target.eof() == false ) {
	var _read		= string_trim( target.read() );
	var _comment	= string_pos( "//", _read );
	var _ext		= 0;
	var _tag		= find_tag( _read );
	
	if ( _tag != undefined ) {
		if ( array_length( _tag ) == 1 ) { _tag[ 1 ] = ""; }
		
		if ( _tag[ 0 ] == "@param" ) {
			args.enqueue( new make_argument( _tag[ 1 ] ) );
			
		} else if ( _tag[ 0 ] == "@override" ) {
			_over	= true;
			
			_read	= target.read();
			
			_open	+= string_count( "{", _read ) - string_count( "}", _read );
			
		} else if ( _tag[ 0 ] == "@duplicate" || _tag[ 0 ] == "@dupe" ) {
			_ignore	= true;
				
		} else if ( _tag[ 0 ] == "@desc" ) {
			_desc	= _tag[ 1 ];
			
		} else if ( _tag[ 0 ] == "@return" || _tag[ 0 ] == "@returns" ) {
			_ret	= return_lookup( _tag[ 1 ] );
			
		}  else if ( _tag[ 0 ] == "@alias" ) {
			var _rest	= string_find_first( " \t", _tag[ 1 ], 0 );
			var _func = methods.list.add( new make_function( strc( _tag[ 1 ], 1, _rest - 1 ), strd( _tag[ 1 ], 1, _rest ), _desc, _ret ) );
			
			if ( args.empty() == false ) {
				var _i = 0; repeat( args.size() ) {
					_func.value.args[ _i++ ]	= args.dequeue();
					
				}
				
			}
			
		}
		continue;
		
	}
	while ( _comment != 0 && _comment > _ext ) {
		_ext = next_quote( _read, _ext );
		// the quote happens after the comment, or there is not quote
		if ( _ext == 0 || _ext > _comment ) {
			_read = string_copy( _read, 1, _comment - 1 );
			
			break;
			
		}
		// the comment happens after the quote, check for encapsulation
		_ext = next_quote( _read, _ext );
		// comment is encapsulated, repeat until no //'s are found
		if ( _ext > _comment ) {
			_comment	= string_pos_ext( "//", _read, _ext );
			
		}
		//syslog( target.next, " :: ", _comment, ", ", _ext );
	}
	if ( _open == 1 ) {
		var _statement = _read;
		
		if ( string_pos( ";", _statement ) > 0 ) {
			_statement	= strc( _statement, 1, string_pos( ";", _statement ) - 1 );
			
		}
		if ( string_pos( "{", _statement ) > 0 ) {
			_statement	= strc( _statement, 1, string_pos( "{", _statement ) - 1 );
			
		}
		var _pos	= string_pos( "=", _statement );
		
		if ( _pos > 0 ) {
			_statement	= string_explode( _statement, "=", true );
			
			if ( string_copy( _statement[ 0 ], 1, 3 ) != "var" && string_copy( _statement[ 0 ], 1, 2 ) != "if" ) {
				if ( string_copy( _statement[ 0 ], 1, 6 ) == "static" ) {
					_statement[ 0 ]	= strd( _statement[ 0 ], 1, 6 );
					
				}
				if ( string_copy( _statement[ 1 ], 1, 8 ) == "function" ) {
					_statement[ 1 ]	= string_delete( _statement[ 1 ], 1, string_pos( "(", _statement[ 1 ] ) );
					
					var _func = methods.list.add( new make_function( _statement[ 0 ], string_copy( _statement[ 1 ], 1, string_pos( ")", _statement[ 1 ] ) - 1 ), _desc, _ret ) );
					
					if ( _ignore ) { _func.value.ignore = true; }
					
				} else {
					var _var = methods.vars.add( new make_variable( _statement[ 0 ], ( _desc == undefined ? "No description provided." : _desc ) ) );
					
				}
				_ignore	= false;
				_desc	= undefined;
				_over	= false;
				_ret	= undefined;
				
			}
			
		}
		
	}
	_open	+= string_count( "{", _read ) - string_count( "}", _read );
	
}
if ( _open != 0 ) {
	error( "Not enough closures. ", _open );
	
}
/*

|Jump To|[`top`](#Top)|[toArray](#toarray)|[toString](#toString)|[is](#is-type-)|
|---|---|---|---|---|
>### method()
*Returns:* N/A (`undefined`)
|Name|Type|Purpose|
|---|---|---|
||||
>### is( type )
*Returns:* boolean (`true` or `false`)
|Name|Type|Purpose|
|---|---|---|
|type|struct id|The structure type to compare this against|

Returns `true` if the provided type is Timer.
***
Description
***
*/