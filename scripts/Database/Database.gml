/// @func Database
function Database() : __Struct__() constructor {
	static node = function( _value, _id, _source ) constructor {
		static read	= function( _path ) {
			// this is the final node
			if ( _path.has_next() == false ) { return __Value; }
			// otherwise, if this node is not traversable
			if ( __ID & FAST_DB_IDS.NODE == 0 )
				throw new __Error__().from_string("Traversal of " + _path.__String + " failed because " + _path.__Buffer + " is not traversable!" );
			// if the next node doesn't exist
			if ( variable_struct_exists( __Value, _path.next() ) == false )
				throw new __Error__().from_string("Traversal of " + _path.__String + " failed because " + _path.__Buffer + " does not exist!" );
			// continue traversal
			return __Value[$ _path.__Buffer ].read( _path );
			
		}
		static write	= function( _path, _value, _id ) { 
			var _key	= _path.next();
			// this is the final node
			if ( _path.has_next() == false ) {
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
				return _value;
				
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
		var _f	= variable_struct_get( __Source.__NodeTypes, string( _id ) );
		if ( _f != undefined && _f.onCreate != undefined )
			__Value = _f.onCreate( self, _value );
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
		return __Node.read( __parser__.parse( _path ) );
		
	}
	/// @param {string}			path	A path to a key
	/// @param {mixed}			value	The value to write
	/// @param {FAST_DB_FLAGS}	flag	optional: A flag specifying the type of value this is
	/// @desc	Writes the given value to the specified path.  The type will be inferred, but
	///		if it is a custom type, the id given must be provided.  Returns the written value.
	/// @returns mixed
	static write	= function( _path, _value, _id ) {
		if ( _id == undefined ) {
			if ( is_numeric( _value ) )		{ _id = FAST_DB_IDS.NUMBER; }
			else if ( is_string( _value ) )	{ _id = FAST_DB_IDS.STRING; }
			else if ( is_array( _value ) )	{ _id = FAST_DB_IDS.ARRAY; }
			else if ( is_struct( _value ) )	{ _id = FAST_DB_IDS.STRUCT; }
			else
				throw new __Error__().from_string( "Write failed because value was unrecognized and id was not specified!" );
		}
		return __Node.write( __parser__.parse( _path ), _value, _id );
		
	}
	/// @param {string}	path	A path to a key
	/// @desc	Removes the key at the given path and returns it.
	/// @returns mixed
	static remove	= function( _path ) {
		return __Node.remove( __parser__.parse( _path ) );
		
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
	static from_input	= function( _source ) {
		if ( struct_type( _source, __Stream__ ))
			_source	= new __Stream__( _source );
		if ( struct_type( _source, __InputStream__ ) == false )
			throw new InvalidArgumentType( "from_input", 0, _source, "__InputStream__" );
		
	}
	/// @desc	Converts the database to a string.  Used for debugging.
	static toString	= function() {
		return "root:\n" + __Node.toString(1);
		
	}
	static __parser__	= new ( __FAST_database_config__().parser )(".");
	
	
	__NodeTypes	= {}
	__NodeIds	= 0;
	
	add_node_type({
		onCreate: function( _node, _value ) { return {}},
		onDestroy: function( _node ) { _node.destroy(); },
		toString: function( _node, _indent ) { return _node.toString( _indent ); }
	}, FAST_DB_IDS.NODE );
	
	__Node		= new node({}, FAST_DB_IDS.NODE, self);
	__NodeIds	= FAST_DB_IDS.LAST;
	
	__Type__.add( Database );
	
}
