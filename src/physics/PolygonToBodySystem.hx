package physics;
import ash.tools.ListIteratingSystem;


/**
 * ...
 * @author damrem
 */
class PolygonToBodySystem extends ListIteratingSystem<PolygonalPhyNode>
{

	public function new() 
	{
		super(PolygonalPhyNode, updateNode, nodeAdded, nodeRemoved);
	}
	
	function updateNode(node:PolygonalPhyNode, t:Float)
	{
		
	}
	
	function nodeAdded(node:PolygonalPhyNode)
	{
		
	}
	
	function nodeRemoved(node:PolygonalPhyNode)
	{
		
	}
	
}