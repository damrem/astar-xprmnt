package labyrinth.connection;

import ash.tools.ListIteratingSystem;

/**
 * Add and remove graph arcs according to connection between tiles.
 * @author damrem
 */
class TileConnectSystem extends ListIteratingSystem<TileNode>
{

	public function new() 
	{
		super(TileNode, update);
		
	}
	
	function update(node:TileNode, dt:Float)
	{
		
	}
	
}