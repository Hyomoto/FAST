/// @desc file processing
var _filename	= string_copy( filename_name( target.name ), 1, string_pos( ".", filename_name( target.name ) ) ) + "md";

//methods		= new DsQueue();
//variables	= new DsQueue();

// find header

trace( "Compiling header..." );

event_user( 1 );

if ( header == undefined ) {
	trace( "Skipped." );
	
	exit;
	
}
trace( "Compiling body..." );

event_user( 2 );

// write to index
if ( header.wiki != undefined ) {
	table.add( header.wiki.index, header.wiki.table, { name : header.name + "(" + header.argstr + ")", path : header.wiki.path + header.name } );
	
}
if ( clipboard ) {
	clipboard_set_text( string( header ) + string( methods ) );
	
} else if ( overwrite || file_exists( path + _filename ) == false ) {
	// write to file
	output	= new FileText( path + _filename, false, true );
	syslog( "Writing to ", path + _filename, "..." );
	output.write( string( header ) + string( methods ) );
	
	output.close();
	++final;
	
}


/*
## Variables
|Jump To|[`top`](#Top)|
|---|---|
* var - description
*/