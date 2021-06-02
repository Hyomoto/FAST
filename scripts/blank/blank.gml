
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

var _timer	= new Timer();

var _a	= new Array().order();
var _l	= new LehmerRandomizer().seed( 1 );

repeat( 100 ) { _a.push( irandom( 100 ) ); }

syslog( _a );

_a	= _a.shuffle( _l );

syslog( _a );

syslog( _timer.elapsed() / 1000000 );
