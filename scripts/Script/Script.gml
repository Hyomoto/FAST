/// @func Script
function Script() : DsChain() constructor {
	static execute	= function( _engine ) {
		if ( errors > 0 ) {
			_engine.log( "execute", "Cannot execute \"", source, "\" because it contains errors!" );
			
			return undefined;
			
		}
		var _package	= _engine.executionStack.top();
		var _reread		= false;
		var _ex, _last;
		
		while ( has_next( _package.last ) ) {
			if ( _engine.executionStop ) { return; }
			
			if ( _reread == false ) {
				_package.last	= next( _package.last );
				
			}
			_last			= _package.last;
			_ex				= _last.value;
			_reread			= false;
			
			if ( is_string( _ex ) ) {
				if ( _engine.parseQueue != undefined ) {
					_engine.parseQueue.enqueue( _ex );
					
				}
				continue;
				
			}
			if( _ex.ignore ) { continue; }
			if ( _ex.ends ) {
				if ( args == undefined && _ex.keyword == "wait" ) {
					_engine.wait	= ScriptManager().WaitCondition( _engine, self );
					//_engine.queue.enqueue_at_head( self );
					_engine.executionStop	= true;
					
					if ( _ex.expression != undefined ) {
						if ( _ex.wait_on ) {
							with ( _engine ) {
								wait.expression	= _ex;
								wait.package	= _package;
								wait.update		= method( wait, function() {
									if ( expression.execute( script, package ) ) { engine.wait = undefined; }
									
								});
								
							}
							
						} else {
							with ( _engine ) {
								wait.time		= _ex.execute( self, _package );
								wait.update		= method( wait, function() {
									if ( --time <= 0 ) { engine.wait = undefined; }
								
								});
							
							}
							
						}
						
					}
					//if ( has_next( _last ) ) {
					//	var _time	= _ex.execute( self, _package );
						
					//	if ( _time != undefined ) {
					//		wait	= new EventOnce( FAST.STEP, _time, _package, function( _package ) {
					//			execute( _package );
							
					//		});
							
					//	} else {
					//		queue.enqueue_at_head( _package );
							
					//		wait	= true;
							
					//	}
						
					//}
					//return;
					
					return;
					
				}
				_engine.executionStack.pop();
				
				return _ex.execute( _engine, _package );
				
			}
			if ( _ex.close ) {
				if ( _ex.keyword == "loop" ) {
					_package.depth -= 1;
					
					if ( _package.depth < _ex.depth ) { continue; }
					
					_package.last	= _ex.goto;
					_reread			= true;
					
				} else if ( _ex.keyword == "end" ) {
					_package.depth -= 1;
					
					continue;
					
				}
				
			}
			if ( _ex.open ) {
				if ( _package.depth < _ex.depth && _ex.execute( _engine, _package ) ) {
					_package.depth	+= 1;
					
					continue;
					
				}
				_package.last	= _ex.goto;
				_reread			= true;
				
			} else {
				_ex.execute( _engine, _package );
				
			}
			
		}
		_engine.executionStack.pop();
		
		return undefined;
		
	}
	static validate	= function( _engine, _quiet ) {
		var _open	= 0;
		var _last	= undefined;
		
		repeat( links ) {
			_last	= next( _last );
			
			if ( is_string( _last.value ) ) { continue; }
			
			_last.value.validate( self );
			
			if ( _last.value.close ) { --_open; }
			if ( _last.value.open ) { ++_open; }
			
		}
		if ( _open > 0 ) { _engine.errors.push( source + " lacks closures, check for missing 'end' or 'loop'." ); }
		if ( _open < 0 ) { _engine.errors.push( source + " has too many closures, check for extra 'end' or 'loop'." ); }
		
		if ( _quiet == false || _engine.errors.size() > 0 ) {
			errors	= _engine.errors.size();
			
			_engine.log( source, "Script validated with ", errors, " errors." );
			
			if ( _engine.errors.size() > 0 ) {
				while ( _engine.errors.size() > 0 ) {
					_engine.log( source, _engine.errors.pop() );
					
				}
				
			}
			
		}
		
	}
	static toString	= function() {
		return source;
		
	}
// # Method Declaration
	static first	= function() {
		if ( links == 0 ) { return undefined; }
		
		return chain;
		
	}
	static has_next	= function( _last ) {
		return ( links == 0 ? false : _last == undefined || _last.chain != undefined );
		
	}
	static next		= function( _last ) {
		if ( links == 0 ) { return undefined; }
		if ( _last == undefined || _last.chain == undefined ) {
			_last	= chain;
			
		} else {
			_last	= _last.chain;
			
		}
		return _last;
		
	}
	static find	= function( _value ) {
		if ( links == 0 ) { return undefined; }
		
		var _seek	= chain;
		
		while ( _seek != undefined ) {
			if ( _seek.value == _value ) {
				return _seek;
				
			}
			_seek	= _seek.chain;
			
		}
		return undefined;
		
	}
	static add	= function( _value ) {
		var _link	= new ChainLink( _value );
		
		if ( final == undefined ) { 
			chain		= _link;
			
		} else {
			final.chain	= _link;
			
		}
		final		= _link;
		
		++links;
		
		return _link;
		
	}
	static clearSuper	= clear;
	static clear	= function() {
		final	= undefined;
		
		clearSuper();
		
	}
	static is		= function( _data_type ) {
		return _data_type == Script;
		
	}
// # Variable Declaration
	name	= "";
	source	= undefined;
	final	= undefined;
	args	= undefined;
	errors	= 0;
	lines	= 0;
	
	isFunction	= false;
	
}
