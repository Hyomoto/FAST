FAST.feature( "FIOM", "Input/Output Module", (1 << 32 ) + (1 << 16), "6/12/2021" );

/// @func FileNotFound
/// @desc	Thrown when a request for a file is made and it didn't exist.
function FileNotFound( _call, _file ) : __Error__() constructor {
	message	= conc( "The function ", _call, " failed because it could not find ", _file )
}
/// @func IllegalFileOperation
/// @desc	Thrown when an illegal call is made to operate on a file.
function IllegalFileOperation( _call, _msg ) : __Error__() constructor {
	message	= conc( "The function ", _call, " failed because ", _msg )
}
