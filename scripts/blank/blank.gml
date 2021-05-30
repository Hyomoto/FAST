var _event	= new FrameEvent( FAST.STEP, 0, undefined, function() {
	ats_run();
	
}).once();


//function Throw(msg) {
//    var errStr = "\n \nCUSTOM EXCEPTION\n==============================================================="
//    while string_length(msg) > 100 {
//        errStr += "\n"+string_copy(msg,1,100)
//        msg = string_copy(msg,101,string_length(msg)-100)
//        if string_length(msg) > 1 {
//            if string_char_at(msg,1) != " " {
//                if string_char_at(errStr,string_length(errStr)) != " "
//                    errStr += "-"
//            }
//            else msg = string_copy(msg,2,string_length(msg)-1)
//        }
//    }
//    errStr += "\n" + msg + "\n===============================================================\n\n"
//    throw errStr
//}
//Throw( "Hello world!" );

//var _table	= new LehmerRandomizer();

//var _test	= array_create( 10, 0 );

//repeat( 256 ) {
//	_test[ _table.next_range( 0, 9 ) ]++;
	
//}
//syslog( _test );
