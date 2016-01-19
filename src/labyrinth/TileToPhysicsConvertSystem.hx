package labyrinth;

import ash.tools.ListIteratingSystem;
import box2D.collision.shapes.B2PolygonShape;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2FixtureDef;
import physics.B2;

/**
 * ...
 * @author damrem
 */
class TileToPhysicsConvertSystem extends ListIteratingSystem<TileNode>
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
		trace("nodeAdded" + node);
		
		node.body.b2body = B2.world.createBody(node.body.bodyDef);
		
		var shape = new B2PolygonShape();
		var fixtureDef = new B2FixtureDef();

		shape.setAsOrientedBox(50, 50, new B2Vec2( 15, 15));
		fixtureDef.shape = shape;
		node.body.b2body.createFixture(fixtureDef);
		
		shape.setAsOrientedBox(50, 50, new B2Vec2(100, 100));
		fixtureDef.shape = shape;
		node.body.b2body.createFixture(fixtureDef);
	}
	
	function nodeRemoved(node:TileNode)
	{
		
	}
	
}

