/// @func Graph
function Graph() constructor {
	static add = function( _name ) {
		var _node	= {
			set: function( _name, _weight ) { __Edges[$ _name ]	= _weight; return self; },
			neighbors: function() { return variable_struct_get_names( __Edges ); },
			__Edges: {}
			
		}
		__Nodes[$ _name ]	= _node;
		
		return _node;
		
	}
	static find	= function( _start, _end ) {
		static __Next__	= function( _costs, _process ) {
			var _cost	= infinity;
			var _node	= undefined;
			
			var _i = 0, _n = variable_struct_get_names( _costs ); repeat( array_length( _n ) ) {
				var _next	= _n[ _i++ ];
				if ( _process[$ _next ] != undefined || _costs[$ _next ] > _cost ) { continue; }
				
				_cost	= _costs[$ _next ];
				_node	= _next;
				
			}
			if ( _node != undefined ) { _process[$ _node ] = true; }
			
			return _node;
			
		}
		var _costs		= {}
		var _parents	= {}
		var _process	= {}
		
		_costs[$ _start ]	= 0;
		
		var _node	= __Next__( _costs, _process );
		
		while ( _node != undefined ) {
			var _cost	= _costs[$ _node ];
			
			var _i = 0, _n = __Nodes[$ _node ].neighbors(); repeat( array_length( _n ) ) {
				var _edge		= _n[ _i++ ];
				var _new_cost	= _cost + __Nodes[$ _node ].__Edges[$ _edge ];
				
				if ( variable_struct_exists( _costs, _edge ) && _costs[$ _edge ] <= _new_cost ) {
					continue;
					
				} else {
					_costs[$ _edge ]	= _new_cost;
					_parents[$ _edge ]	= _node;
					
				}
				
			}
			_node	= __Next__( _costs, _process );
			
		}
		var _list	= new LinkedList();
		var _next	= _end;
		
		while ( _next != _start ) {
			_list.insert( 0, _next );
			
			_next	= _parents[$ _next ];
			
		}
		_list.insert( 0, _start );
		
		return _list;
		
	}
	__Nodes	= {}
	
}
