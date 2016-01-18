package labyrinth;

import ash.tools.ListIteratingSystem;
import box2D.collision.shapes.B2PolygonShape;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2FixtureDef;
import box2D.dynamics.B2World;

/**
 * ...
 * @author damrem
 */
class TileToPhysicsConvertSystem extends ListIteratingSystem<TileNode>
{
	var world:B2World;

	public function new(world:B2World) 
	{
		super(TileNode, nodeUpdate, nodeAdded, nodeRemoved);
		this.world = world;
		
	}
	
	function nodeUpdate(node:TileNode, time:Float)
	{
		
	}
	
	function nodeAdded(node:TileNode)
	{
		trace("nodeAdded" + node);
		
		node.body.b2body = world.createBody(node.body.bodyDef);
		
		var shape = new B2PolygonShape();
		var fixtureDef = new B2FixtureDef();

		shape.setAsOrientedBox(10, 10, new B2Vec2( -15, -15));
		fixtureDef.shape = shape;
		node.body.b2body.createFixture(fixtureDef);
		
		shape.setAsOrientedBox(10, 10, new B2Vec2(15, -15));
		fixtureDef.shape = shape;
		node.body.b2body.createFixture(fixtureDef);
	}
	
	function nodeRemoved(node:TileNode)
	{
		
	}
	
}

