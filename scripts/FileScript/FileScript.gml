/// @func FileScript
/// @param filename
function FileScript( _filename, _readonly ) : File( _filename, _readonly ) constructor {
	static formatter	= ScriptManager().formatter;
	static reset	= function() {
		last	= startAt;
		local	= {};
		depth	= -1;
		
	}
	static discard		= function() {
		ds_list_destroy( list );
		
	};
	static readSuper	= read;
	static read		= function() {
		var _read	= readSuper();
		
		if ( _read != undefined ) {
			line	= _read.line;
			//name	= _read.file;
			
			return _read.value;
			
		}
		return undefined;
		
	}
	static get_lineSuper	= get_line;
	static get_line	= function( _line ) {
		var _return	= get_lineSuper( _line );
		
		return ( _return == undefined ? undefined : _return.value );
		
	}
	static peekSuper	= peek;
	static peek	= function() {
		var _return	= peekSuper();
		
		return ( _return == undefined ? undefined : _return.value );
		
	}
	// closes the file, preserving changes
	static closeSuper	= close;
	static close	= function() {
		if ( writable ) {
			var _file	= file_text_open_write( name );
			
			var _i = 0; repeat( ds_list_size( list ) ) {
				file_text_write_string( _file, list[| _i++ ] );
				file_text_writeln( _file );
				
			}
			file_text_close( _file );
			
		} else {
			log_notify( undefined, "ScriptFile.close", "Close called on read only file. Ignored." );
			
		}
		closeSuper();
		
	}
	static toString	= function() {
		return name + " (line " + string( line ) + ")";
		
	}
	static load	= function( _filename ) {
		static fragment	= function( _string, _execute, _line ) constructor {
			static toString	= function() {
				return string( value );
				
			}
			execute	= _execute;
			value	= _string;
			line	= _line;
			
		}
		ScriptManager().formatter.comment	= false;
		
		if ( exists( _filename ) == false ) {
			return false;
			
		}
		var _name	= filename_name( _filename );
		var _file	= file_text_open_read( _filename );
		var _line	= 0;
		var _read, _last, _pos;
		var _logic	= 0;
		var _branch	= new DsStack();
		
		while ( file_text_eof( _file ) == false ) {
			_read	= file_text_read_string( _file ); file_text_readln( _file );
			
			if ( _line == 0 && string_copy( _read, 1, 9 ) == "function(" ) {
				ds_list_add( list, new fragment( _read, false, _line ) );
				
				_logic	= 3;
				_line	+= 1;
				
				continue;
				
			}
			if ( string_pos( "<<", _read ) > 0 ) {
				_logic	= ( _logic == 0 ? 1 : _logic );
				_read	= string_delete( _read, 1, string_pos( "<<", _read ) + 1 );
				
			}
			if ( _logic ) {
				if ( string_pos( ">>", _read ) > 0 ) {
					_read	= string_delete( _read, string_pos( ">>", _read ), 2 );
					_logic	= ( _logic == 1 ? 2 : _logic );
					
				}
				_read	= ScriptManager().formatter.format( string_trim( _read ) );
				
			}
			if ( !_logic ) {
				ds_list_add( list, new fragment( _read, false, _line ) );
				
			} else if ( _read != "" ) {
				var _execute	= new ScriptStatement( _read );
				
				ds_list_add( list, new fragment( _execute, true, _line ) );
				
				if ( _execute.close ) {
					_branch.pop().goto	= _line;
					
				}
				if ( _execute.open ) {
					_execute.depth	= _branch.size();
					
					_branch.push( _execute );
					
				}
				
			}
			if ( _logic == 2 ) {
				_logic = 0;
				
			}
			++_line;
			
		}
		file_text_close( _file );
		
		lines	= ds_list_size( list );
		name	= _filename;
		
	}
	static execute	= function( _engine, _local ) {
		var _next;
		
		isRunning	= true;
		
		_local	= ( _local == undefined ? local : _local );
		
		while ( eof() == false ) {
			if ( is_string( peek() ) && isFunction == false ) {
				syslog( "RTP: ", read() );
				
				break;
				
			}
			_next	= read();
			
			if ( _next.ends ) {
				isRunning	= false;
				
				return _next.execute( _engine, _local );
				
			}
			if ( _next.close ) {
				if ( _next.keyword == "end" ) {
					--depth;
					
					continue;
					
				}
				
			}
			if ( _next.open ) {
				if ( depth < _next.depth && _next.execute( _engine, _local ) ) {
					++depth;
					
					continue;
					
				}
				last	= _next.goto;
				
			} else {
				_next.execute( _engine, _local );
				
			}
			
		}
		if ( eof() ) {
			isRunning	= false;
				
		}
		
	}
	isRunning	= false;
	isFunction	= false;
	includes	= 0;
	line		= 0;
	startAt		= 0;
	local		= {};
	depth		= -1;
	
	load( _filename );
	
}
