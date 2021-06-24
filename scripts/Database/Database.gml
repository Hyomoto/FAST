/// @func Database
function Database() : __Struct__() constructor {
	static node = function( _value, _id, _source ) constructor {
		static read	= function( _path ) {
			if ( _path.has_next() == false ) { return __Value; }
			if ( __ID & FAST_DB_IDS.NODE == 0 )
				throw new __Error__().from_string("Traversal of " + _path.__String + " failed because " + _path.__Buffer + " is not traversable!" );
			if ( variable_struct_exists( __Value, _path.next() ) == false )
				throw new __Error__().from_string("Traversal of " + _path.__String + " failed because " + _path.__Buffer + " does not exist!" );
			
			return __Value[$ _path.__Buffer ].read( _path );
			
		}
		static write	= function( _path, _value, _id ) { 
			var _key	= _path.next();
			// this is the final node
			if ( _path.has_next() == false ) {
				if ( variable_struct_exists( __Value, _key )) {
					var _f	= variable_struct_get( __Source.__NodeTypes, string( _id ) );
					if ( _f != undefined && _f.onDestroy != undefined )
						_f.onDestroy( __Value[$ _key ] );
					__Value.__Value	= _value;
					__Value.__ID	= _id;
					return _value;
				}
				__Value[$ _key ]	= new __Source.node( _value, _id, __Source );
				return _value;
			}
			// if the next node is not traversable
			if ( __ID != FAST_DB_IDS.NODE )
				throw new __Error__().from_string("Traversal of " + _path.__String + " failed because " + _path.__Buffer + " is not traversable!" );
			// if the next node doesn't exist, or is not a traversable node
			if ( !variable_struct_exists( __Value, _key ) || __Value[$ _key ].__ID != FAST_DB_IDS.NODE )
				__Value[$ _key ]	= new __Source.node( undefined, FAST_DB_IDS.NODE, __Source );
			
			return __Value[$ _key ].write( _path, _value, _id );
			
		}
		static remove	= function( _path ) {
			var _key	= _path.next();
			if ( _path.has_next() == false ) {
				return;
				
			}
			// if the next node is not traversable
			if ( __ID & FAST_DB_IDS.NODE == 0 )
				throw new __Error__().from_string("Traversal of " + _path.__String + " failed because " + _path.__Buffer + " is not traversable!" );
			// if the next node doesn't exist, or is not a traversable node
			if ( variable_struct_exists( __Value, _key ) || __Value[$ _key ].__ID != FAST_DB_IDS.NODE )
				throw new __Error__().from_string("Traversal of " + _path.__String + " failed because " + _path.__Buffer + " is not traversable!" );
			
			return __Value[$ _key ].remove( _key );
			
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
		__Value	= _value;
		__ID	= _id;
		__Source= _source;
		
		var _f	= variable_struct_get( __Source.__NodeTypes, string( _id ) );
		if ( _f != undefined && _f.onCreate != undefined )
			_f.onCreate( self );
		
	}
	static read		= function( _key ) {
		return __Node.read( __parser__.parse( _key ) );
		
	}
	static write	= function( _key, _value, _id ) {
		if ( _id == undefined ) {
			if ( is_numeric( _value ) )		{ _id = FAST_DB_IDS.NUMBER; }
			else if ( is_string( _value ) )	{ _id = FAST_DB_IDS.STRING; }
			else if ( is_array( _value ) )	{ _id = FAST_DB_IDS.ARRAY; }
			else if ( is_struct( _value ) )	{ _id = FAST_DB_IDS.STRUCT; }
			else
				throw new __Error__().from_string( "Write failed because value was unrecognized and id was not specified!" );
		}
		return __Node.write( __parser__.parse( _key ), _value, _id );
		
	}
	static destroy	= function() {
		__Node.destroy();
		
	}
	static toString	= function() {
		return "root:\n" + __Node.toString(1);
		
	}
	static add_node_type	= function( _id, _func ) {
		__NodeTypes[$ string( _id ) ] = _func;
		
	}
	static from_input	= function( _source ) {
		if ( struct_type( _source, __Stream__ ))
			_source	= new __Stream__( _source );
		if ( struct_type( _source, __InputStream__ ) == false )
			throw new InvalidArgumentType( "from_input", 0, _source, "__InputStream__" );
		
	}
	static __parser__	= new ( __FAST_database_config__().parser )(".");
	
	
	__NodeTypes	= {}
	__NodeIds	= FAST_DB_IDS.LAST;
	
	add_node_type( FAST_DB_IDS.NODE, {
		onCreate: function( _node ) { _node.__Value = {} },
		onDestroy: function( _node ) { _node.destroy(); },
		toString: function( _node, _indent ) { return _node.toString( _indent ); }
	});
	__Node		= new node({}, FAST_DB_IDS.NODE, self);
	
	__Type__.add( Database );
	
}
