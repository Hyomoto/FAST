/// @param {Real} _time_or_predicate    The amount of time or predicate to wait with.
/// @param {Bool} _use_delta            Whether to use frames (false) or seconds (true)
/// @desc Injects a wait, can be in frames or seconds depending on whether or not use delta is true.
function CatenaWait( _time_or_predicate, _use_delta = CATENA_USE_DELTA_BY_DEFAULT ) : Catenable() {
    static update       = function() {
        if (use_delta)  wait_until -= delta_time;
        else            wait_until -= 1;
        
        return self;
        
    }
    static isFinished   = function() {
        return wait_until <= 0;
        
    }
    if is_callable(_time_or_predicate) {
        update = function() {} // nothing to update
        isFinished = _time_or_predicate;
        
    } else {
        if ( _use_delta )
            _time_or_predicate *= 1_000_000;
        
    }
    wait_until = _time_or_predicate;
    use_delta = _use_delta;
    
}