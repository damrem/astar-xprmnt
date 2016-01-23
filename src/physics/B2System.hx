package physics;

import ash.tools.ListIteratingSystem;

/**
 * ...
 * @author damrem
 */
class B2System extends ListIteratingSystem<SimpleBodyNode>
{
	
	public function new() 
	{
		super(SimpleBodyNode, updateNode, nodeAdded, nodeRemoved);
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
	
	
	function updateNode(node:SimpleBodyNode, time:Float)
	{
		//node.phy.body.advance(PERIOD);
		//world.step(PERIOD, 8, 3);
	}
	
	
	function nodeAdded(node:SimpleBodyNode)
	{
		node.phy.b2body = B2.world.createBody(node.phy.bodyDef);
		node.phy.b2body.createFixture(node.phy.fixtureDef);
	}
	
	function nodeRemoved(node:SimpleBodyNode)
	{
		node.phy.b2body.DestroyFixture(node.phy.b2body.getFixtureList());
		B2.world.destroyBody(node.phy.b2body);
	}
	
}