/// @func database_load
/// @param filename
/// @param *target
/// @desc	
/// @wiki Database-Index Functions
function database_load( _filename ) {
	static database	= DatabaseManager();
	static LEFT		= 0;
	static RIGHT	= 1;
	
	// if no target was provided, database is loaded into a new node
	var _target		= ( argument_count > 1 ? argument[ 1 ] : new DsTree() );
	var _file		= new FileFAST( _filename, true );
	var _timer		= new Timer( "$S seconds", 2 );
	var _last_file	= _filename;
	var _templates	= ds_stack_create();
	var _default	= undefined;
	var _root		= _target;
	var _continue	= true;
	var _raw, _indicator, _hand, _assign, _value, _last_value;
	
	// parse file into database
	while ( _file.eof() == false && _continue ) {
		_raw		= _file.read();
		// clear templates
		if ( _last_file != _file.name ) {
			DatabaseManager().type	= undefined;
			
			_root.remove( "template" );
			
			_last_file	= _file.name;
			
		}
		// find operant modifer
		_indicator	= string_char_at( _raw, 1 );
		_hand	= string_explode( _raw, "=", false );
		
		if ( string_find_first( "+@$", _hand[ LEFT ], 0 ) > 0 ) {
			_hand[ LEFT ]	= string_delete( _hand[ LEFT ], 1, 1 );
			
		}
		_assign	= array_length( _hand ) == 2;
		// check left hand value
		switch ( _indicator ) {
			// update previous value
			case "+" :
				var _value	= database.parse( _hand[ LEFT ], _file );
				
				if ( _last_value.is( "number" ) == false || _value.is( "number" ) == false ) {
					database.log( " Value ", _hand[ LEFT ], " can not be used with '+'! Skipped." );
					
					database.warnings++;
					
					continue;
					
				}
				_last_value.value	+= _value.value;
				
				break;
				
			// assign static value
			case "@" :
				if ( _assign == false ) {
					database.log( " Static ", _hand[ LEFT ], " has no assignment. Skipped." );
					
					database.warnings++;
					
					continue;
					
				}
				_last_value	= database.add_static( _hand[ LEFT ], database.parse( _hand[ RIGHT ], _file ) );
				
				break;
			// perform function
			case "$" :
				var _break	= string_explode( _hand[ LEFT ], ":", false );
				
				switch( _break[ 0 ] ) {
					case "template" :
						if ( array_length( _break ) == 1 ) {
							_default	= undefined;
							
							break;
							
						}
						var _seek	= _root.seek( _break[ 1 ] );
						
						if ( _seek == undefined || _seek.is( "node" ) == false ) {
							database.log( " Template ", _break[ 1 ], " was not found. Skipped." );
							
							database.warnings++;
							
							_default	= undefined;
							
							break;
							
						}
						_default	= _seek.value;
						
						break;
						
					case "include" :
						if ( array_length( _break ) == 1 ) {
							database.log( " Include has no assignment. Skipped." );
							
							database.warnings++;
							
							break;
							
						}
						var _seek	= _root.seek( _break[ 1 ] );
						
						if ( _seek == undefined || _seek.is( "node" ) == false ) {
							database.log( " Include template ", _break[ 1 ], " was not found. Skipped." );
							
							database.warnings++;
							
							break;
							
						}
						_target	= _seek.value.copy( _target );
						
						break;
						
					case "datatype" :
						if ( _break[ 1 ] == "" ) {
							DatabaseManager().type	= undefined;
							
						} else {
							DatabaseManager().type	= _break[ 1 ];
							
						}
						break;
						
					default :
						syslog( _break );
						
				}
				break;
				
			default :
				// node closure
				if ( _hand[ LEFT ] == "}" ) {
					if ( ds_stack_size( database.stack ) == 0 ) {
						database.log( " Node closure '}' without matching opener! Aborted." );
						
						_continue	= false;
						
						break;
						
					}
					_target		= ds_stack_pop( database.stack );
					_default	= ds_stack_pop( _templates );
					
					_last_value	= _target;
					
				} else {
					// find template
					var _break		= string_explode( _hand[ LEFT ], ":", false );
					var _template	= undefined;
					
					if ( array_length( _break ) > 1 ) {
						_template	= _root.seek( _break[ 1 ] );
						
						if ( _template == undefined ) {
							database.log( _file, " Template ", _break[ 1 ], " was not found. Skipped." );
							
							database.errors++;
							
							_template	= undefined;
							
						}
						
					}
					// node opening
					if ( array_length( _hand ) == 1 ) {
						_last_value	= ( _default == undefined ? new DsTree() : _default.copy() );
						
						if ( _template != undefined ) {
							_last_value	= _template.copy( _last_value );
							
						} else {
							_last_value	= database.__undefined;
							
						}
						_target.set( _break[ 0 ], _last_value, false );
						
						database.records++;
						
					} else if ( _hand[ RIGHT ] == "{" || _hand[ RIGHT ] == "${" ) {
						var _seek	= _target.seek( _break[ 0 ] );
						
						ds_stack_push( database.stack, _target );
						ds_stack_push( _templates, _default );
						
						if ( _seek == undefined || _seek.is( "node" ) == false ) {
							_last_value	= ( _default == undefined ? new DsTree() : _default.copy() );
							
							if ( _template != undefined && _template.is( "node" ) == true ) {
								_last_value	= _template.value.copy( _last_value );
								
							}
							_target.set( _break[ 0 ], _last_value, DsTree_Branch );
							_target	= _last_value;
							
							database.records++;
							
						} else {
							_target	= _seek.value;
							_last_value	= _target;
							
						}
						_default	= undefined;
						
					// value assignment
					} else {
						try {
							var _value	= database.parse( _hand[ RIGHT ], _file );
							
							_target.set( _hand[ LEFT ], _value, false );
							
							database.records++;
							
							_last_value	= _value;
							
						} catch ( _ex ) {
							var _string		= ( is_array( _ex ) ? _ex[ 1 ] : string( _ex ) );
							
							database.log( "Error in ", _file.name, " at line ", string( _file.line ), ", " + _string );
							
							database.errors++;
							
							if ( is_array( _ex ) ) {
								_continue = _ex[ 0 ] == true;
								
								if ( _continue == false ) {
									database.log( "Unrecoverable error, database load aborted." );
									
								}
								
							}
							
						}
						
					}
					
				}
				break;
			
		}
		
	}
	// check for lack of closures
	if ( ds_stack_size( database.stack ) > 0 ) {
		database.log( _file, " Matching closure '}' is missing! Database is likely corrupted." );
		
		database.warnings++;
		
		ds_stack_clear( database.stack );
		
	}
	// resolve links
	database.resolve_links( _target );
	
	if ( ds_queue_size( database.links ) > 0 ) {
		database.log( _file, " Could not resolve ", ds_queue_size( database.links ), " symbolic links. Skipped." );
		
		database.errors++;
		
		ds_queue_clear( database.links );
		
	}
	// clean up templates
	_root.remove( "template" );
	
	ds_stack_destroy( _templates );
	
	// log results
	database.log( "File ", _filename, " loaded, ", _file.includes, " includes, took ", _timer, "." );
	database.log( "Found ", database.records, " records with ", database.warnings, " warnings, and ", database.errors, " errors." );
	if ( database.errors + database.warnings > 0 ) {
		database.log( "..Issues detected during load! Check log for details." );
		
		database.errors		= 0;
		database.warnings	= 0;
		
	}
	// close file
	_file.destroy();
	// return populated node
	return _target;
	
}
