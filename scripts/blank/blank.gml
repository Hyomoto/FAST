syslog( string_repeat( "~", 72 ) )
syslog( "\t\tDATABASE TEST" );

syslog( string_repeat( "~", 72 ) )

var _data	= new Database();
syslog( "write" );
_data.write( "foo.bar", "hello world!" );
_data.write( "foo.car", "jello world!" );
_data.write( "bar", 0, FAST_DB_IDS.NODE );
syslog( "output" );
show_debug_message( _data.toString() );
