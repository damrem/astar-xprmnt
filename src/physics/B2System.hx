package physics;

import ash.tools.ListIteratingSystem;

/**
 * ...
 * @author damrem
 */
class B2System extends ListIteratingSystem<PhysicalShapedNode>
{
	
	public function new() 
	{
		super(PhysicalShapedNode, updateNode, nodeAdded, nodeRemoved);
	}
	
	override public function update(time:Float)
	{
		super.update(time);
		B2.world.step(time, 8, 3);
	}
	
	
	function updateNode(node:PhysicalShapedNode, time:Float)
	{
	}
	
	
	function nodeAdded(node:PhysicalShapedNode)
	{
		node.physicalShaped.body = B2.world.createBody(node.physicalShaped.bodyDef);
		node.physicalShaped.body.createFixture(node.physicalShaped.fixtureDef);
	}
	
	function nodeRemoved(node:PhysicalShapedNode)
	{
		node.physicalShaped.body.DestroyFixture(node.physicalShaped.body.getFixtureList());
		B2.world.destroyBody(node.physicalShaped.body);
	}
	
}