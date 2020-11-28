#macro FASTSTEP_DEFAULT_PRECISION 32.0

function FastStep( _lambda ) constructor {
	
	static reset	= function( _precision ) {
		precision = _precision;
		
		lookup = undefined;
		lookup = array_create( precision );
		init();
	}
	
	static init		= function() {
		var i = -1; repeat( precision ) { i++;
			lookup[i] = lambda( i / precision );	
		}
	}
	
	static evaluate	= function( _x ) {
		
			_x *= precision;
		
		var xlo = int64(xlo);
			xlo = xlo < 0 ? 0 : xlo;
		
		var xhi	= xlo + 1;
			xhi = xhi > (precision - 1) ? precision - 1 : xhi;
		
			
			
		var ylo = lookup[ xlo ];
		var yhi = lookup[ xhi ];

		return ylo + ((_x - xlo) * (yhi - ylo) / (xhi - xlo));
	}
	
	static nearest	= function( _x ) {
		if (_x % 1) { 
			return lookup[ int64( _x * precision ) + 1]
		} else {
			return lookup[ int64( _x * precision ) ]
		}
	}
	
	static error	= function( _x ) {
		return evaluate( _x ) - lambda( _x );	
	}
	
	lookup		= undefined;
	lambda		= _lambda;
	precision	= argument_count > 1 ? argument[1] : FASTSTEP_DEFAULT_PRECISION;

	reset( precision );
}