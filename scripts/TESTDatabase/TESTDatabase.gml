/// @func TESTDatabase
function TESTDatabase() : __Struct__() constructor {
	static __pool__	= new ObjectPool();
	static __node__	= function() constructor {
		static __parser__	= new ( __FAST_database_config__().parser )(".");
		static write	= function( _path, _value, _id ) {
			if ( is_string( _path )) { _path = __parser__.open( _path ); }
			
			var _key	= _path.read();
			// this is the final node
			if ( _path.finished()) {
				// write value
				return;
				
			}
			// if key does not exist, write it
			if ( variable_struct_exists( __Content, _key ) == false ) {
				//__Content[$ _key ] = new __node__(
				
			}
			// traverse structure
			
		}
		static read		= function( _path, _undef ) {}
		static copy		= function( _target ) {}
		static destroy	= function() {}
		static toString	= function() {}
		__Content	= undefined;
		__ID		= "null";
		
	}
	/// @param {Parser}	parser
	static make	= function( _p ) {
		static _dt_ = function( _p ) { _p.mark(); show_debug_message( _p.remaining() ); _p.reset(); }
		
		var _type	= undefined;
		
		_p.skip( char_is_whitespace );
		
		if ( _p.peek() == ":" ) {
			_p.advance(1).skip( char_is_whitespace );
			
			if ( _p.peek(2) == "!!" ) {
				_type	= _p.word( function( _c ) { return _c == "!" || char_is_whitespace( _c ); }, false );
				_p.skip( char_is_whitespace );
				
			}
			var _value	= string_trim( _p.remaining() );
			
		} else if ( _p.peek() == "[" ) {
			
			
		}
		syslog("% %", _type, _value );
		// create blank node
		var _node	= new __node__();
		// type is generic
		if ( _value == ">" ) {
			// consume the rest of this line
			_p.remaining();
			// calculate indent
			var _i	= string_length( _p.word( char_is_whitespace ));
			var _l;
			
			_value	= "";
			_p.mark(); // prevents unmark from crashing
			do {
				// undo the last mark, it wasn't used
				_p.unmark(); 
				// compile value
				_value	+= _p.remaining();
				// mark this position
				_p.mark();
				// test for white space
				_l		= _i;
				_i	= string_length( _p.word( char_is_whitespace ));
				
			} until ( _p.finished() || _i != _l );
			// last read was not part of this line, ignore it
			_p.reset();
			
		}
		// check defines
		if ( string_char_at( _value, 1 ) == "@" ) {
			
			
		}
		if ( _type == undefined ) {
			switch ( string_char_at( _value, 1 )) {
				case "\"" : case "'" :
					_value = string_copy( _value, 2, string_length( _value ) - 2 );
					_type = FAST_DB_IDS.STRING;
					break;
				default:
					
			}
			
		// type was specified
		} else {
			
			
		}
		return _node;
		//if ( _id == undefined ) {
		//	if ( is_numeric( _value ) )		{ _id = FAST_DB_IDS.NUMBER; }
		//	else if ( is_string( _value ) )	{ _id = FAST_DB_IDS.STRING; }
		//	else if ( is_array( _value ) )	{ _id = FAST_DB_IDS.ARRAY; }
		//	else if ( is_struct( _value ) )	{ _id = FAST_DB_IDS.STRUCT; }
		//	else
		//		throw new InvalidArgumentType( "make", 1, _value, "string" );
		//}
		//if ( _id < 0 || _id >= __NodeId )
		//	throw new __Error__().from_string(string_formatted("Undefined node id \"{}\" provided to database.", _id ));
		// create new node
		// populate node
		
	}
	static from_string	= function( _string ) {
		static __parser__	= new Parser();
		var _queue	= new Queue();
		
		while ( __parser__.finished() == false ) {
			_queue.push( __parser__.word( char_is_linebreak, false ));
			
		}
		__parser__.clear();
		from_input( _queue );
		
	}
	static from_input	= function( _input ) {
		// check if input is a stream, wrap if true
		if ( struct_type( _input, __Stream__ ))
			_input	= new __Stream__( _input ).open();
		// check if input is an input stream, error if now
		if ( struct_type( _input, __InputStream__ ) == false )
			throw new InvalidArgumentType( "from_input", 0, _input, "__InputStream__" );
		// helper functions
		static __indicators__	= [ "{", "}", "[", "]", ",", ":" ];
		static __parser__	= new Parser();
		
		__parser__.open( _input );
		// start processing
		var _node = new make( _p, FAST_DB_IDS.NODE);
		
		__parser__.clear();
		
	}
	static create_id	= function( _name, _struct, _id ) {
		if ( is_struct( _struct ) == false )
			throw new InvalidArgumentType( "create_id", 0, _struct, "struct" );
		if ( _id == undefined ) { _id = __NodeId++; }
		
		__NodeTypes[$ _name ]	= _id;
		__NodeIds[ _id ]		= _struct;
		
		return _id;
		
	}
	__NodeId	= FAST_DB_IDS.LAST;
	__NodeIds	= array_create( __NodeId, {});
	__NodeTypes	= {}
	
	create_id( "node", {
		create	: function( _p, _n ) {
			
		},
		copy	: function() {},
		destroy	: function() {},
	}, FAST_DB_IDS.NODE );
	
	__Type__.add( Database );
	
}
