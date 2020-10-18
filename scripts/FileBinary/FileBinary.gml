/// @func FileBinary
/// @param {string}	filename	the name of the file to open
/// @param {bool}	read_only?	optional: whether this file should allow writing to. Default: true
/// @param {bool}	new?		optional: whether this file should be blank. Default: false
/// @desc	An implementation for binary files. They support writing reals, strings, and arrays.
/// @wiki Core-Index Files
function FileBinary( _filename, _readonly, _new ) : File( _readonly ) constructor {
	static __types = {
		FLOAT : {
			tag : 0x1,
			read : function( _types, _buffer ) {
				return buffer_read( _buffer, buffer_f64 );
			},
			write: function( _types, _buffer, _value ) {
				buffer_write( _buffer, buffer_u8, 0x1 );
				buffer_write( _buffer, buffer_f64, _value );
				
				return 9;
				
			}
		},
		STRING : {
			tag : 0x2,
			read : function( _types, _buffer ) {
				return buffer_read( _buffer, buffer_string );
				
			},
			write: function( _types, _buffer, _value ) {
				buffer_write( _buffer, buffer_u8, 0x2 );
				buffer_write( _buffer, buffer_string, string( _value ) );
				
				return 2 + string_byte_length( _value );
				
			}
		},
		ARRAY : {
			tag : 0x3,
			read : function( _types, _buffer ) {
				var _array	= array_create( buffer_read( _buffer, buffer_f64 ) );
				var _key, _action;
				
				var _i = 0; repeat( array_length( _array ) ) {
					_key	= buffer_read( _buffer, buffer_u8 );
					_action = _types( _key );
					
					if ( _action == undefined ) {
						FileManager().log( undefined, "FileBinary", "File ", name, " could not be read, file may have been corrupted. Ignored." );
						
						_array[ _i++ ]	= undefined;
			
						break;
						
					}
					_array[ _i++ ]	= _action.read( _types, _buffer );
					
				}
				return _array;
				
			},
			write: function( _types, _buffer, _value ) {
				buffer_write( _buffer, buffer_u8, 0x3 );
				buffer_write( _buffer, buffer_f64, array_length( _value ) );
				
				var _read, _action, _bytes = 9;
				
				var _i = 0; repeat( array_length( _value ) ) {
					_read	= _value[ _i++ ];
					_action	= _types( _read );
					
					if ( _action == undefined ) {
						FileManager().log( undefined, "FileBinary.save()", "Attempted to write an unknown data type \"", _read, "\". Ignored." );
						
						continue;
						
					}
					_bytes	+= _action.write( _types, _buffer, _read );
					
				}
				return _bytes;
				
			}
			
		}
		
	}
	static type_by_key		= function( _key ) {
		if ( _key == __types.FLOAT.tag ) { return __types.FLOAT; }
		if ( _key == __types.STRING.tag ) { return __types.STRING; }
		if ( _key == __types.ARRAY.tag ) { return __types.ARRAY; }
		
		return undefined;
		
	}
	static type_by_value	= function( _value ) {
		if ( is_real( _value ) ) { return __types.FLOAT; }
		if ( is_string( _value ) ) { return __types.STRING; }
		if ( is_array( _value ) ) { return __types.ARRAY; }
		
		return undefined;
		
	}
	static save	= function() {
		if ( writable ) {
			var _buffer	= buffer_create( 1024, buffer_grow, 1 );
			var _bytes	= 0;
			var _read, _action;
			
			var _i = 0; repeat( ds_list_size( contents ) ) {
				_read	= contents[| _i++ ];
				_action	= type_by_value( _read );
				
				if ( _action == undefined ) {
					FileManager().log( undefined, "FileBinary.save()", "Attempted to write an unknown data type \"", _read, "\". Ignored." );
					
					continue;
					
				}
				_bytes	+= _action.write( method( self, type_by_value ), _buffer, _read );
				
			}
			buffer_write( _buffer, buffer_u8, 0x0 );
			buffer_seek( _buffer, buffer_seek_start, 0 );
			
			if ( file_exists( name ) ) { file_delete( name ); }
			
			var _file	= file_bin_open( name, 1 );
			
			repeat ( _bytes + 1 ) {
				file_bin_write_byte( _file, buffer_read( _buffer, buffer_u8 ) );
				
			}
			buffer_delete( _buffer );
			
			file_bin_close( _file );
			
		} else {
			FileManager().log( undefined, instanceof( self ) + ".close", "Called on ", name, ", which is a read only file. Ignored." );
			
		}
		
	}
	name	= _filename;
	
	var _buffer	= buffer_create( 1024, buffer_grow, 1 );
	
	if ( _new != true && exists() ) {
		var _file	= file_bin_open( _filename, 0 );
		
		repeat( file_bin_size( _file ) ) {
			buffer_write( _buffer, buffer_u8, file_bin_read_byte( _file ) );
			
		}
		file_bin_close( _file );
		
		buffer_seek( _buffer, buffer_seek_start, 0 );
		
		var _key, _action;
		
		while( true ) {
			_key	= buffer_read( _buffer, buffer_u8 );
			
			if ( _key == 0x0 ) { break; }
			
			_action = type_by_key( _key );
			
			if ( _action == undefined ) {
				FileManager().log( undefined, "FileBinary", "File ", name, " could not be read, file may have been corrupted. Aborted." );
				
				break;
				
			}
			write( _action.read( method( self, type_by_key ), _buffer ) );
			
		}
		
	}
	
}
