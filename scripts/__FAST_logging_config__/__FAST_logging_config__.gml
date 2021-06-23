// # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//								User-definable Macros
// # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// # The length of a string that loggers will add line breaks at
#macro FAST_LOGGER_DEFAULT_LENGTH	144

// # Sets whether or not log_critical, log_nonfatal, log_notify, or log_debug are logged
//		Remove them by commenting out which ones should be ignored.
#macro FAST_ERROR_LOG	0\
						+ FAST_LOGGER_CRITICAL \
						+ FAST_LOGGER_NONFATAL \
						+ FAST_LOGGER_NOTIFY \
						+ FAST_LOGGER_DEBUG

// # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// #							End of User Defines
// # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// # these are the error levels
#macro FAST_LOGGER_CRITICAL	0x1
#macro FAST_LOGGER_NONFATAL	0x2
#macro FAST_LOGGER_NOTIFY	0x4
#macro FAST_LOGGER_DEBUG	0x8

FAST.feature( "FLOG", "Logging", (1 << 32 ) + ( 1 << 16 ) + 1, "10/10/2020" );

/// @func LoggerError
/// @desc	Thrown when a logger causes an error.
/// @wiki Logging-Index Errors
function LoggerError( _name, _msg ) : __Error__() constructor {
	message	= conc( _name, " caused an error. ", _msg );
}
