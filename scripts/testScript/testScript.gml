#macro Critical:ERROR_LEVEL	1
#macro Nonfatal:ERROR_LEVEL	2
#macro Notify:ERROR_LEVEL	3

var _array	= new ArrayDynamic( [ "a", "b", "c" ] );

syslog( _array, "[", _array.size(), " : ", array_length( _array.content ), "]" ); //

_array.append( "a" );

syslog( _array, "[", _array.size(), " : ", array_length( _array.content ), "]" ); //

_array.remove( 0 );

syslog( _array, "[", _array.size(), " : ", array_length( _array.content ), "]" ); // 

_array.remove( 1 );

syslog( _array, "[", _array.size(), " : ", array_length( _array.content ), "]" ); //

_array.remove( 1 );

syslog( _array, "[", _array.size(), " : ", array_length( _array.content ), "]" ); //

_array.insert( "i1", 0 );

syslog( _array, "[", _array.size(), " : ", array_length( _array.content ), "]" ); 

_array.insert( "i2", 1 );

syslog( _array, "[", _array.size(), " : ", array_length( _array.content ), "]" );

_array.insert( "i3", 3 );

syslog( _array, "[", _array.size(), " : ", array_length( _array.content ), "]" );

_array.append( "a" );

syslog( _array, "[", _array.size(), " : ", array_length( _array.content ), "]" ); //

_array.append( "a" );

syslog( _array, "[", _array.size(), " : ", array_length( _array.content ), "]" ); //