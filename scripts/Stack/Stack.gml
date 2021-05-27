function Stack() : LinkedList() constructor {
	static next = function() { return pop( size() ); }
}