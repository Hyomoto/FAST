/// @func test_validator
/// @param string
/// @param subject
/// @param steps
/// @param do
function test_validator( _string, _steps, _subject, _compare ) {
    var _count    = 0;
    
    try {
        repeat( _steps ) {
            if ( _compare( _subject ) == true ) { ++_count; }
            
        }
        
    } catch ( _ex ) {
        show_debug_message( _ex.longMessage );
        
        _count    = -1;
        
    } finally {
        show_debug_message( "Testing " + _string + "... " + ( _count == _steps ? "passed." : "failed" ) );
        
    }
    
}
