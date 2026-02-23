function assert( _true, _throw ){
	if ( not _true )
		throw new Exception( _throw );
	return _true;
	
}
