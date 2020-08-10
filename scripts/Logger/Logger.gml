/// @func Logger
/// @param name
/// @param Outputs...
function Logger( _name, _output ) constructor { //_console, _filename 
	static toString	= function() {
		return name;
		
	}
	static write	= function( _value ) {
		_value	= name + " :: " + string( _value );
		
		var _i = 0; repeat( array_length( outputs ) ) {
			outputs[ _i++ ].write( _value );
			
		}
		
	}
	static close	= function( _value ) {
		var _i = 0; repeat( array_length( outputs ) ) {
			outputs[ _i++ ].close( _value );
			
		}
		log( "Logger ", name, " has been closed." );
		
	}
	static clear	= function( _value ) {
		var _i = 0; repeat( array_length( outputs ) ) {
			outputs[ _i++ ].clear( _value );
			
		}
		
	}
	outputs	= array_create( argument_count - 1 );
	
	var _i = 1; repeat( argument_count - 1 ) {
		outputs[ _i - 1 ]	= argument[ _i ];
		
		++_i;
		
	}
	name	= _name;
	
	clear();
	write( "log opened: " + date_datetime_string(date_current_datetime()) );
	
	LogManager().add( self );
	
}

	//static write	= function( _string ) {
	//	ds_list_add( logHistory, _string );
		
	//	_string	= name + " :: " + _string;
		
	//	output( _string, console, false );
		
	//}
	//static dump		= function( _param, _function ) {
	//	var _i = 0; repeat( ds_list_size( logHistory ) ) {
	//		_function( logHistory[| _i++ ], _param );
			
	//	}
		
	//}
	//if ( _filename != undefined ) {
	//	output	= function( _string, _console, _force ) {
	//		if ( ds_list_size( logHistory ) >= writeAt || _force ) {
	//			var _file = file_text_open_append( filename );
				
	//			dump( _file, function( _string, _file ) {
	//				file_text_write_string( _file, _string );
	//				file_text_writeln( _file );
					
	//			});
	//			file_text_close( _file );
				
	//			ds_list_clear( logHistory );
				
	//		}
	//		if ( _console ) {
	//			show_debug_message( _string );
				
	//		}
			
	//	}
	//	close	= function() {
	//		output( undefined, false, true );
			
	//		show_debug_message( "Logger " + name + " closed." );
			
	//		ds_list_clear( logHistory );
			
	//	}
	//	if ( file_exists( _filename ) ) {
	//		file_delete( _filename );
			
	//	}
		
	//} else {
	//	output	= function( _string, _console ) {
	//		if ( _console ) {
	//			show_debug_message( _string );
				
	//		}
	//		if ( logHistory >= writeAt ) {
	//			ds_list_delete( logHistory, 0 );
				
	//		}
			
	//	}
	//	close	= function() {
	//		show_debug_message( "Logger " + name + " closed." );
			
	//		ds_list_clear( logHistory );
			
	//	}
		
	//}
	