/// @func database_load
/// @param filename
/// @param *target
/// @desc	
function database_load( _filename, _target ) {
	static database	= DatabaseManager();
	static LEFT		= 0;
	static RIGHT	= 1;
	
	var _file	= new FileFAST( _filename, true );
	var _timer	= new Timer( "$S seconds", 2 );
	var _last_file	= _filename;
	var _templates	= ds_stack_create();
	var _default	= undefined;
	var _raw, _indicator, _hand, _assign, _value, _last_value;
	// if no target was provided, database is loaded into a new node
	if ( _target == undefined ) {
		_target	= new DsNode();
		
	}
	var _root	= _target;
	
	// parse file into database
	while ( _file.eof() == false ) {
		_raw		= _file.read();
		// clear templates
		if ( _last_file != _file.name ) {
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
					log_nonfatal( undefined, "FAST_database_load", _file, " Value ", _hand[ LEFT ], " can not be used with '+'! Skipped." );
					
					database.warnings++;
					
					continue;
					
				}
				_last_value.value	+= _value.value;
				
				break;
				
			// assign static value
			case "@" :
				if ( _assign == false ) {
					log_nonfatal( undefined, "FAST_database_load", _file, " Static ", _hand[ LEFT ], " has no assignment. Skipped." );
					
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
							log_nonfatal( undefined, "FAST_database_load", _file, " Template ", _break[ 1 ], " was not found. Skipped." );
							
							database.warnings++;
							
							_default	= undefined;
							
							break;
							
						}
						_default	= _seek.value;
						
						break;
						
					case "include" :
						if ( array_length( _break ) == 1 ) {
							log_nonfatal( undefined, "FAST_database_load", _file, " Include has no assignment. Skipped." );
							
							database.warnings++;
							
							break;
							
						}
						var _seek	= _root.seek( _break[ 1 ] );
						
						if ( _seek == undefined || _seek.is( "node" ) == false ) {
							log_nonfatal( undefined, "FAST_database_load", _file, " Include template ", _break[ 1 ], " was not found. Skipped." );
							
							database.warnings++;
							
							break;
							
						}
						_target	= _seek.value.copy( _target );
						
						break;
						
					default :
						log( _break );
						
				}
				break;
				
			default :
				// node closure
				if ( _hand[ LEFT ] == "}" ) {
					if ( ds_stack_size( database.stack ) == 0 ) {
						log_critical( undefined, "database_load", _file, " Node closure '}' without matching opener! Aborted." );
						throw("see output log");
						
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
							log_nonfatal( undefined, "FAST_database_load", _file, " Template ", _break[ 1 ], " was not found. Skipped." );
							
							database.errors++;
							
							_template	= undefined;
							
						}
						
					}
					// node opening
					if ( array_length( _hand ) == 1 ) {
						//_last_value	= ( _default == undefined ? new DsNode() : _default.copy() );
						
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
							_last_value	= ( _default == undefined ? new DsNode() : _default.copy() );
							
							if ( _template != undefined && _template.is( "node" ) == true ) {
								_last_value	= _template.value.copy( _last_value );
								
							}
							_target.set( _break[ 0 ], _last_value, DsNodeNode );
							_target	= _last_value;
							
							database.records++;
							
						} else {
							_target	= _seek.value;
							_last_value	= _target;
							
						}
						_default	= undefined;
						
					// value assignment
					} else {
						var _value	= database.parse( _hand[ RIGHT ], _file );
						
						_target.set( _hand[ LEFT ], _value, false );
						
						database.records++;
						
						_last_value	= _value;
						
					}
					
				}
				break;
			
		}
		
	}
	// check for lack of closures
	if ( ds_stack_size( database.stack ) > 0 ) {
		log_critical( undefined, "database_load", _file, " Node closure '}' missing! Aborted." );
		throw("see output log");
		
	}
	// resolve links
	database.resolve_links( _target );
	
	if ( ds_queue_size( database.links ) > 0 ) {
		log_nonfatal( undefined, "FAST_database_load", _file, " Could not resolve ", ds_queue_size( database.links ), " symbolic links. Skipped." );
		
		database.errors++;
		
		ds_queue_clear( database.links );
		
	}
	// clean up templates
	_root.remove( "template" );
	
	ds_stack_destroy( _templates );
	
	// log results
	log_notify( undefined, "database_load", "file ", _filename, " loaded, ", _file.includes, " includes, took ", _timer, "." );
	log_notify( undefined, "database_load", "found ", database.records, " records with ", database.warnings, " warnings, and ", database.errors, " errors." );
	if ( database.errors + database.warnings > 0 ) {
		log_nonfatal( undefined, "database_load", "Issues detected during load! Check log for details." );
		
	}
	// close file
	_file.discard();
	// return populated node
	return _target;
	
}
