package entities.labyrinth;

import ash.tools.ListIteratingSystem;

/**
 * ...
 * @author damrem
 */
class TileDrawSystem extends ListIteratingSystem<TileNode>
{

	public function new() 
	{
		super(TileNode, update, added, removed);
		
	}
	
	function update(node:TileNode, dt:Float)
	{
		
	}
	
	function added(node:TileNode)
	{
		
	}
	
	function removed(node:TileNode)
	{
		
	}
	
}