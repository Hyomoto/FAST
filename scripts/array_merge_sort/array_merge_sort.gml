/// @func array_merge_sort
/// @param    {array}    array            The array to sort
/// @param    {mixed}    *sort_or_func    Whether or not to sort ascending, or a function to use instead.
function array_merge_sort( _arr, _sort_or_func ) {
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
                    arr[@ k] = L[i];
                    i++;
                } else {
                    arr[@ k] = M[j];
                    j++;
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
    switch ( _sort_or_func ) {
        case undefined :
        case true : _sort_or_func = function( _a, _b ) { return _a <= _b ? 1 : -1; }; break;
        case false: _sort_or_func = function( _a, _b ) { return _a >= _b ? 1 : -1; }; break;
        
    }
    __sort__( _arr, 0, array_length( _arr ) - 1, _sort_or_func, __sort__ );
    
}
