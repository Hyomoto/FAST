/// @func __Parser__
function __Parser__() : __InputStream__() constructor {
	static open		= function() {}
	static read		= function( _c ) {}
	static finished	= function() {}
	static close	= function() {}
	static parse	= function( _s ) {}
	
	__Type__.add( __Parser__ );
	
}
