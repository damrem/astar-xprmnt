package labyrinth;

import ash.tools.ListIteratingSystem;

/**
 * ...
 * @author damrem
 */
class ApertureToPolygonSystem extends ListIteratingSystem<TileNode>
{

	public function new() 
	{
		super(TileNode, nodeUpdate, nodeAdded, nodeRemoved);
	}
	
	function nodeUpdate(node:TileNode, time:Float)
	{
		
	}
	
	function nodeAdded(node:TileNode)
	{
		//converts aperture into a polygon (the path one, not the wall one, it will be simpler :)
	}
	
	function nodeRemoved(node:TileNode)
	{
		
	}
	
}

