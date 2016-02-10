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
		//var adaptedTime = time * Main.THEORICAL_FPS / Main.fps.currentFPS;
		//trace(time, adaptedTime);
		//var period:Float = 1 / Main.fps.currentFPS;
		super.update(time);
		//if (Math.isFinite(adaptedTime))
		{
			//trace(B2.PERIOD, 1 / Main.fps.currentFPS);
			B2.world.step(time, 8, 3);
		}
	}
	
	
	function updateNode(node:PhysicalNode, time:Float)
	{
		//node.phy.body.advance(PERIOD);
		//world.step(PERIOD, 8, 3);
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