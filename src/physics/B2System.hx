package physics;

import ash.tools.ListIteratingSystem;

/**
 * ...
 * @author damrem
 */
class B2System extends ListIteratingSystem<PhysicalNode>
{
	
	public function new() 
	{
		super(PhysicalNode, updateNode, nodeAdded, nodeRemoved);
	}
	
	override public function update(time:Float)
	{
		super.update(time);
		B2.world.step(time, 8, 3);
	}
	
	
	function updateNode(node:PhysicalNode, time:Float)
	{
	}
	
	
	function nodeAdded(node:PhysicalNode)
	{
		node.physical.body = B2.world.createBody(node.physical.bodyDef);
		node.physical.body.createFixture(node.physical.fixtureDef);
	}
	
	function nodeRemoved(node:PhysicalNode)
	{
		node.physical.body.DestroyFixture(node.physical.body.getFixtureList());
		B2.world.destroyBody(node.physical.body);
	}
	
}