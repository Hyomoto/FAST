/// @func Database
function Database() : __Struct__() constructor {
	static node = function( _value, _id, _source ) constructor {
		static __parser__	= new ( __FAST_database_config__().parser )(".");
		
		static read	= function( _path ) { 
			if ( is_string( _path ) ) { _path = __parser__.parse( _path ); }
			// this is the final node
			if ( _path.has_next() == false ) {
				__Source.__Last = self;
				
				return __Value;
				
			}
			// otherwise, if this node is not traversable
			if ( __ID != FAST_DB_IDS.NODE )
				throw new __Error__().from_string("Traversal of " + _path.__String + " failed because " + _path.__Buffer + " is not traversable!" );
			// if the next node doesn't exist
			if ( variable_struct_exists( __Value, _path.next() ) == false )
				return new ValueNotFound( "read", _path.__String, _path.__Buffer );
			// continue traversal
			return __Value[$ _path.__Buffer ].read( _path );
			
		}
		static write	= function( _path, _value, _id ) {
			if ( is_string( _path ) ) { _path	= __parser__.parse( _path ); }
			
			var _key	= _path.next();
			// this is the final node
			if ( _path.has_next() == false ) {
				if ( _id == undefined ) {
					if ( is_numeric( _value ) )		{ _id = FAST_DB_IDS.NUMBER; }
					else if ( is_string( _value ) )	{ _id = FAST_DB_IDS.STRING; }
					else if ( is_array( _value ) )	{ _id = FAST_DB_IDS.ARRAY; }
					else if ( is_struct( _value ) )	{ _id = FAST_DB_IDS.STRUCT; }
					else
						throw new __Error__().from_string( "Write failed because value was unrecognized and id was not specified!" );
				}
				if ( variable_struct_exists( __Value, _key )) {
					var _node	= __Value[$ _key ];
					// key exists, destroy it
					var _f	= variable_struct_get( __Source.__NodeTypes, _node.__ID );
					if ( _f != undefined && _f.onDestroy != undefined )
						_f.onDestroy( _node );
					// write data to existing node
					_node.__Value	= _value;
					_node.__ID		= _id;
					
				} else {
					// write value to new node
					__Value[$ _key ]	= new __Source.node( _value, _id, __Source );
					
				}
				__Source.__Last = __Value[$ _key ];
				
				return __Value[$ _key ].__Value;
				
			}
			// if this node is not traversable
			if ( __ID != FAST_DB_IDS.NODE )
				throw new __Error__().from_string("Traversal of " + _path.__String + " failed because " + _path.__Buffer + " is not traversable!" );
			// if the next node doesn't exist, or is not a traversable node
			if ( !variable_struct_exists( __Value, _key ) || __Value[$ _key ].__ID != FAST_DB_IDS.NODE )
				__Value[$ _key ]	= new __Source.node( undefined, FAST_DB_IDS.NODE, __Source );
			
			return __Value[$ _key ].write( _path, _value, _id );
			
		}
		static remove	= function( _path ) {
			var _key	= _path.next();
			// this is the final node
			if ( _path.has_next() == false ) {
				if ( variable_struct_exists( __Value, _key )) {
					var _node	= __Value[$ _key ];
					// key exists, destroy it
					var _f	= variable_struct_get( __Source.__NodeTypes, _node.__ID );
					if ( _f != undefined && _f.onDestroy != undefined )
						_f.onDestroy( _node );
					// remove node
					variable_struct_remove( __Value, _key );
					
				}
				return new ValueNotFound( "remove", _path.__String, -1 );
				
			}
			// if this node is not traversable
			if ( __ID != FAST_DB_IDS.NODE )
				throw new __Error__().from_string("Traversal of " + _path.__String + " failed because " + _path.__Buffer + " is not traversable!" );
			// if the next node doesn't exist, or is not a traversable node
			if ( !variable_struct_exists( __Value, _key ) || __Value[$ _key ].__ID != FAST_DB_IDS.NODE )
				throw new __Error__().from_string("Traversal of " + _path.__String + " failed because " + _path.__Buffer + " is not traversable!" );
			
			return __Value[$ _key ].remove( _path );
			
		}
		static copy		= function( _node ) {
			if ( _node == undefined ) { _node = new __Source.node( undefined, FAST_DB_IDS.NODE, __Source ); }
			
			var _keys	= variable_struct_get_names( __Value );
			var _i = 0; repeat( array_length( _keys )) {
				var _value	= __Value[$ _keys[ _i ]];
				var _id		= _value.__ID;
				var _f	= variable_struct_get( __Source.__NodeTypes, string( _id ) );
				if ( _f != undefined && _f.onCopy != undefined ) {
					_value	= _f.onCopy( _value ); }
				else
					_value	= _value.__Value;
				_node.write( _keys[ _i++ ], _value, _id );
				
			}
			return _node;
			
		}
		static destroy	= function() {
			var _keys	= variable_struct_get_names( __Value );
			var _i = 0; repeat( array_length( _keys )) {
				var _node	= __Value[$ _keys[ _i++ ] ];
				var _f	= variable_struct_get( __Source.__NodeTypes, _node.__ID );
				if ( _f != undefined && _f.onDestroy != undefined) {
					_f.onDestroy( _node );
					
				}
				
			}
			
		}
		static keys		= function() {
			return variable_struct_get_names( __Value );
			
		}
		static toString	= function( _indent ) {
			if ( _indent == undefined ) { _indent = 0; }
			
			var _tab	= _indent == undefined ? "" : string_repeat( "  ", _indent );
			
			var _string	= "";
			
			var _keys	= variable_struct_get_names( __Value );
			var _i = 0; repeat( array_length( _keys ) ) {
				var _node	= __Value[$ _keys[ _i ] ];
				
				if ( _string != "" ) { _string += "\n"; }
				
				var _f	= variable_struct_get( __Source.__NodeTypes, string( _node.__ID ) );
				if ( _f != undefined && _f.toString != undefined) {
					_string	+= _tab + _keys[ _i ] + ":\n" + _f.toString( _node, _indent + 1 );
					
				} else {
					_string	+= _tab + _keys[ _i ] + ": " + string( _node.__Value );
					
				}
				++_i;
			}
			if ( _string == "" ) { _string = _tab + "<empty>"; }
			
			return _string;
			
		}
		var _f	= variable_struct_get( _source.__NodeTypes, string( _id ) );
		if ( _f != undefined && _f.onCreate != undefined )
			__Value = _f.onCreate( _value );
		else
			__Value	= _value;
		__ID	= _id;
		__Source= _source;
		
	}
	/// @param {string}	path	A path to a key
	/// @desc	Reads from the path and returns the value  if it exists, or ValueNotFound
	///		if it didn't.
	/// @returns mixed or ValueNotFound
	static read		= function( _path ) {
		return __Node.read( _path );
		
	}
	/// @param {string}			path	A path to a key
	/// @param {mixed}			value	The value to write
	/// @param {FAST_DB_FLAGS}	flag	optional: A flag specifying the type of value this is
	/// @desc	Writes the given value to the specified path.  The type will be inferred, but
	///		if it is a custom type, the id given must be provided.  Returns the written value.
	/// @returns mixed
	static write	= function( _path, _value, _id ) {
		return __Node.write( _path, _value, _id );
		
	}
	/// @param {string}	path	A path to a key
	/// @desc	Removes the key at the given path and returns it.
	/// @returns mixed
	static remove	= function( _path ) {
		return __Node.remove( __parser__.parse( _path ) );
		
	}
	/// @desc	Destroys the database.
	static copy	= function() {
		return __Node.copy();
		
	}
	/// @desc	Destroys the database.
	static destroy	= function() {
		__Node.destroy();
		
	}
	/// @param {method}	funcs	A struct of methods
	/// @param {int}	ID		optional: The id to bind to
	/// @desc	Declares a new value type for the database.  The struct provided can contain up
	///		to three methods, onCreate, onDestroy and toString.  These methods are used to ensure
	///		custom data types can be created, cleaned up and debugged properly.
	/// @returns int
	static add_node_type	= function( _func, _id ) {
		if ( _id == undefined ) { _id = __NodeIds++; }
		
		__NodeTypes[$ string( _id ) ] = _func;
		
		return _id;
		
	}
	/// @param {__InputStream__}	source	An input stream to read from
	/// @desc	Reads from the given source to populate the database.
	/// @returns self
	static from_node	= function( _source ) {
		if ( is_struct( _source ) == false )
			throw new __Error__().from_string( "Source was not a struct!" );
		__Node	= _source;
		
		return self;
		
	}
	/// @param {__InputStream__}	source		An input stream to read from
	/// @param {struct}				*defines	optional: Used to pass in static defines
	/// @desc	Reads from the given source to populate the database.
	/// @returns self
	static from_input	= function( _source, _defines ) {
		static __read_until__	= function( _str, _i, _f ) {
			var _eos	= string_length( _str ) - _i + 1;
			var _len	= 0;
			var _pos	= _i;
			
			repeat( _eos ) {
				if ( _f( string_char_at( _str, _pos )) )
					break;
				++_len;
				++_pos;
			}
			if ( _f( string_char_at( _str, _pos )) )
				return _len;
			return 0;
			
		}
		static __read_number__	= function( _str, _i ) {
			var _eos	= string_length( _str ) - _i + 1;
			var _digits	= 0;
			var _pos	= _i;
			
			if ( _eos > 2 && string_copy( _str, 1, 2 ) == "0x" ) {
				_digits	+= 2; _pos += 2;
				
			}
			repeat ( _eos ) {
				var _dv	= string_char_at( _str, _pos );
				if ( _dv < "0" || "9" < _dv )
		            break;
				++_digits;
				++_pos;
				
		    }
			switch( string_char_at( _str, _pos ) ) {
				case "b" : ++_digits;
			}
			return _digits;
			
		}
		static __eval__	= function( _e, _l, _d ) {
			try {
				var _eval	= new DatabaseExpression().from_string( _e );
				
			} catch ( _ex ) {
				throw new __Error__().from_string( string_formatted( "> {}\n{}", _e, _ex.message ));
				
			}
			var _result	= _eval.evaluate( _l, _d );
			// clean up memory
			_eval.destroy();
			
			return _result;
			
		}
		static __format__	= ( function( _f ) {
			_f.set_rule( ";", function() { remove(); insert( "\n" ); });
			_f.set_rule( "{", function() { advance(); insert( "\n" ); });
			_f.set_rule( "}", function() { insert( "\n" ); advance(); insert( "\n" ); });
			_f.set_rule( "\"", function() {
				if ( __Read > 1 && string_char_at( __String, __Read - 1 ) == "\"" ) { advance(); }
				else { safexor(); advance(); }
			});
			return _f;
			
		})( new StringFormatter() );
		static __line_parser__	= new Parser();
		static __char_parser__	= new Parser();
		
		if ( struct_type( _source, __Stream__ ))
			_source	= new __Stream__( _source ).open();
		if ( struct_type( _source, __InputStream__ ) == false )
			throw new InvalidArgumentType( "from_input", 0, _source, "__InputStream__" );
		
		var _line	= 0;
		var _mode	= FAST_DB.NORMAL;
		var _stack			= new Stack().push( __Node );
		var _template		= new Stack().push( undefined );
		var _default_type	= undefined;
		// pull in defines if not redeclared
		_defines	= _defines == undefined ? {} : _defines;
		
		while ( _source.finished()	= false ) {
			// read next entry, pass through formatter
			__line_parser__.open( __format__.format( _source.read() ));
			
			++_line;
			
			while( __line_parser__.finished() == false ) {
				// read next break
				var _string	= string_trim( __line_parser__.word( char_is_linebreak, false) );
				// discard empty lines
				if ( _string == "" ) { continue; }
				// check for operators
				switch ( string_char_at( _string, 1 )) {
					case "#" :
						if ( _string == "#define" ) {
							_mode = FAST_DB.DEFINE;
							
						} else if ( _string == "#endef" ) {
							_mode = FAST_DB.NORMAL;
							
						} else if ( _string == "#type" ) {
							_mode = FAST_DB.NORMAL;
							
						} else if ( string_copy( _string, 1, 5 ) == "#copy" ) {
							_string	= string_trim( string_delete( _string, 1, 5 ));
							var _import	= read( _string );
							//_source.__Source, _line, _string, _split[ 1 ]
							if ( error_type( _import ) == ValueNotFound )
								throw new BadDatabaseFormat( _source.__Source, _line, _string, "#copy", "Could not import path because it doesn't exist." )
							if ( __Last.__ID != FAST_DB_IDS.NODE )
								throw new BadDatabaseFormat( _source.__Source, _line, _string, "#copy", "Could not import path because it isn't a node." )
							
							__Last.copy( _stack.peek() );
							
						} else if ( string_copy( _string, 1, 9 ) == "#template" ) {
							_string	= string_trim( string_delete( _string, 1, 9 ));
							var _import	= read( _string );
							
							if ( error_type( _import ) == ValueNotFound )
								throw new BadDatabaseFormat( _source.__Source, _line, _string, "#template", "Could not import path because it doesn't exist." )
							if ( __Last.__ID != FAST_DB_IDS.NODE )
								throw new BadDatabaseFormat( _source.__Source, _line, _string, "#template", "Could not import path because it isn't a node." )
							
							_template.pop();
							_template.push( __Last );
							
						} else if ( string_copy( _string, 1, 8 ) == "#tempend" ) {
							if ( _template.peek() == undefined )
								throw new BadDatabaseFormat( _source.__Source, _line, _string, "#tempend", "#tempend called without #template." )
							_template.pop();
							_template.push( undefined );
							
						} else if ( string_copy( _string, 1, 8 ) == "#include" ) {
							var _import	= string_trim( string_delete( _string, 1, 8 ));
							var _dir	= filename_dir( _import );
							var _name	= filename_name( _import );
							
							if ( _name == "" ) { _name = "*"; }
							else if ( string_pos( ".", _name ) > 0 ) {
								_name	= string_delete( _name, 1, string_pos( ".", _name ));
								
							}
							var _files	= file_search( _name, _dir, true, new Queue() );
							
							__line_parser__.push();
							
							repeat( _files.size() ) {
								from_input( new TextFile().open( _files.pop() ), _defines );
								
							}
							__line_parser__.pop();
							
						}
						continue;
						
				}
				var _pos	= 1;
				
				if ( _mode == FAST_DB.DEFINE ) {
					var _def	= string_copy( _string, _pos, __read_until__( _string, _pos, function( _c ) { return _c == " " || _c == "\t" || _c == "="; }));
					_pos	+= string_length( _def );
					_pos	+= __read_until__( _string, _pos, function( _c ) { return _c != " " && _c != "\t"; });
					
					var _value	= __eval__( string_delete( _string, 1, _pos - 1 ), _defines );
					
					_defines[$ _def ]	= _value;
					
				} else {
					// pop if end of node
					if ( _string == "}" ) {
						_stack.pop();
						_template.pop();
						
						continue;
						
					}
					__char_parser__.open( string_trim( _string ));
					
					var _left	= string_explode( __char_parser__.word( function( _c ) { return _c == " " || _c == "\t" || _c == "="; }, false ), "<-", true );
					
					__char_parser__.skip( char_is_whitespace );
					
					if ( __char_parser__.peek() != "=" ) {
						__char_parser__.reset();
						
						var _i = array_length( variable_struct_get_names( _stack.peek().__Value ) );
						var _split	= string_explode( __char_parser__.remaining(), ",", true );
						
						var _j = 0; repeat( array_length( _split )) {
							if ( _split[ _j ] != "" ) {
								_stack.peek().write( string( _i++ ), __eval__( _split[ _j ], _defines, _stack.peek() ), undefined );
								
							}
							++_j;
						}
						continue;
						
					}
					var _right	= string_trim( __char_parser__.advance(1).remaining() );
					
					__char_parser__.open( _right );
					
					//var _right	= string_trim( __char_parser__.advance(1).remaining());
					var _id		= _default_type;
					var _import	= undefined;
					var _templ	= undefined;
					
					if ( array_length( _left ) == 2 ) { // import <-
						if ( _right != "{" )
							throw new BadDatabaseFormat( _source.__Source, _line, _string, _left[ 1 ], "Import '<-' can only be used on nodes." )
						
						_import	= read( _left[ 1 ] );
						
						if ( error_type( _import ) == ValueNotFound )
							throw new BadDatabaseFormat( _source.__Source, _line, _string, _left[ 1 ], "Import path doesn't exist." )
						if ( __Last.__ID != FAST_DB_IDS.NODE )
							throw new BadDatabaseFormat( _source.__Source, _line, _string, _left[ 1 ], "Import path must point to a node." )
						
						_import	= __Last;
						
					}
					_left	= _left[ 0 ];
					
					// push if start of node
					if ( _right	= "{" ) {
						var _read	= _stack.peek().read( _left );
						// if a template is available, grab it before pushing the new scope
						if ( _template.peek() != undefined )
							_templ	= _template.peek();
						
						if ( error_type( _read ) != ValueNotFound && __Last.__ID == FAST_DB_IDS.NODE ) {
							_stack.push( __Last );
							_template.push( undefined );
							
							if ( _import != undefined )
								_import.copy( __Last );
								
							continue;
							
						} else {
							_right	= undefined;
							_id		= FAST_DB_IDS.NODE;
							
						}
						
					} else {
						// custom data types, too chunky
						//if ( __char_parser__.peek(2) == "!!" ) {
						//	var _type	= __char_parser__.word( function( _c ) { return _c == "!" || _c == " " || _c == "\t" }, false );
							
						//}
						_right	= __eval__( _right, _defines, _stack.peek() )
						
					}
					_stack.peek().write( _left, _right, _id );
					// if last write was a node, it becomes the new scope
					if ( _id == FAST_DB_IDS.NODE ) {
						_stack.push( __Last );
						_template.push( undefined );
					}
					// if last node included an import, copy it
					if ( _import != undefined )
						_import.copy( __Last );
					// if last node included a template, copy it
					if ( _templ != undefined )
						_templ.copy( __Last );
						
				}
				
			}
			
		}
		_source.close();
		
		return self;
		
	}
	/// @desc	Converts the database to a string.  Used for debugging.
	static toString	= function() {
		return "root:\n" + __Node.toString(1);
		
	}
	static __type_parser__	= new Parser();
	
	__NodeTypes	= {}
	__NodeIds	= 0;
	
	add_node_type({
		onCreate	: function( _v ) { return is_struct( _v ) ? _v : {}},
		onDestroy	: function( _v ) { _v.destroy(); },
		onCopy		: function( _v ) { return _v.copy().__Value; },
		toString	: function( _v, _indent ) { return _v.toString( _indent ); }
	}, FAST_DB_IDS.NODE );
	
	__Node		= new node({}, FAST_DB_IDS.NODE, self);
	__NodeIds	= FAST_DB_IDS.LAST;
	__Last		= undefined;
	
	__Type__.add( Database );
	
}
