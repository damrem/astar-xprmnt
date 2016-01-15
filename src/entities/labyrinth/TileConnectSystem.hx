package entities.labyrinth;

import ash.tools.ListIteratingSystem;

/**
 * ...
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