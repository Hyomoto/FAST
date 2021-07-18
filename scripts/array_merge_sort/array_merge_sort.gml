/// @func array_merge_sort
/// @param {array}	array			An array to sort
/// @param {mixed}	*sort_or_func	optional: The sort logic to use
/// @desc	A simple sort-in-place algorithm for arrays.
/// @desc	An efficient, stable sorting algorithm for arrays.  Merge sort is much faster than insertion
///		sort, but uses more space due to it's copying of internal portions of the array.  If sort_or_func
///		is true, or not provided, the array will be sorted by ascending value.  Setting this to false will
///		use descending logic.  If a method is provided, this will be used for the comparison.  If an array
///		is not provided to sort, or a non-boolean, non-method is provided for sort, InvalidArgumentType
///		will be thrown.
/// @example
//var _array	= [ 10, 4, 15, 23, 12, 4 ];
//
//array_merge_sort( _array );
/// @output [ 4,4,10,12,15,23 ]
/// @throws InvalidArgumentType
/// @wiki Core-Index Functions
function array_merge_sort( _arr, _sort ) {
    // Divide the array into two subarrays, sort them and merge them
    static __sort__    = function( arr, l, r, f, s ) {
        static __merge__    = function( arr, p, q, r, f) {
            // Create L ← A[p..q] and M ← A[q+1..r]
            var n1 = q - p + 1;
            var n2 = r - q;
			
            var L = array_create( n1 );
            var M = array_create( n2 );
    
            for (var i = 0; i < n1; i++)
                L[i] = arr[p + i];
            for (var j = 0; j < n2; j++)
                M[j] = arr[q + 1 + j];
			
            // Maintain current index of sub-arrays and main array
            var i, j, k;
            i = 0;
            j = 0;
            k = p;
    
            // Until we reach either end of either L or M, pick larger among
            // elements L and M and place them in the correct position at A[p..r]
            while (i < n1 && j < n2) {
                if ( f( L[i], M[j]) ) {
                    arr[@ k] = M[j];
                    j++;
                } else {
					arr[@ k] = L[i];
                    i++;
                }
                k++;
            }
            // When we run out of elements in either L or M,
            // pick up the remaining elements and put in A[p..r]
            while (i < n1) {
                arr[@ k] = L[i];
                i++;
                k++;
            }

            while (j < n2) {
                arr[@ k] = M[j];
                j++;
                k++;
            }
        }
        if (l < r) {
            // m is the point where the array is divided into two subarrays
            var m = (l + r) div 2;
            
            s(arr, l, m, f, s);
            s(arr, m + 1, r, f, s);
            
            // Merge the sorted subarrays
            __merge__(arr, l, m, r, f);
            
        }
    
    }
	if ( is_array( _arr ) == false )
		throw new InvalidArgumentType( "array_merge_sort", 0, _arr, "array" );
		
	if ( array_length( _arr ) < 2 )
		return;
		
	if ( struct_type( _sort, Sort )) {
		_sort	= _sort.func();
		
	} else {
		switch ( _sort ) {
	        case undefined :
	        case true : _sort = function( _a, _b ) { return _a > _b ? 1 : -1; }; break;
	        case false: _sort = function( _a, _b ) { return _a < _b ? 1 : -1; }; break;
			
	    }
		
	}
	if ( is_method( _sort ) == false ) { throw new InvalidArgumentType( "array_merge_sort", 1, _sort, "method" ); }
	
    __sort__( _arr, 0, array_length( _arr ) - 1, _sort, __sort__ );
    
}
