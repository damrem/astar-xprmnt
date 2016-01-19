package physics;

import ash.tools.ListIteratingSystem;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2DebugDraw;
import box2D.dynamics.B2World;
import openfl.display.Sprite;

/**
 * ...
 * @author damrem
 */
class SimpleBodyCreateDestroySystem extends ListIteratingSystem<SimpleBodyNode>
{
	static public var GRAVITY:B2Vec2 = new B2Vec2();
	static public inline var PERIOD:Float = 1 / 60;

	public function new() 
	{
		super(SimpleBodyNode, updateNode, nodeAdded, nodeRemoved);
	}
	
	override public function update(time:Float)
	{
		//trace("update");
		super.update(time);
		B2.world.step(PERIOD, 8, 3);
		B2.world.drawDebugData();
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