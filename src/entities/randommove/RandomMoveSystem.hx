package entities.randommove;

import ash.core.System;
import ash.tools.ListIteratingSystem;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2BodyType;
import entities.randommove.RandomMoveNode;
import hxlpers.Rnd;

/**
 * ...
 * @author damrem
 */
class RandomMoveSystem extends ListIteratingSystem<RandomMoveNode>
{

	public function new() 
	{
		super(RandomMoveNode, updateNode, nodeAdded, nodeRemoved);
	}
	
	function nodeAdded(node:RandomMoveNode) 
	{
		node.phy.body.setType(B2BodyType.DYNAMIC_BODY);
	}
	
	function nodeRemoved(node:RandomMoveNode) 
	{
		node.phy.body.setType(B2BodyType.STATIC_BODY);
	}
	
	function updateNode(node:RandomMoveNode, time:Float)
	{
		var body = node.phy.body;
		var mass = body.getMass();
		var xImpulse = mass * Rnd.float( -node.randomMove.range, node.randomMove.range);
		var yImpulse = mass * Rnd.float( -node.randomMove.range, node.randomMove.range);
		body.applyImpulse(new B2Vec2(xImpulse, yImpulse), body.getWorldCenter());
	}
	
}