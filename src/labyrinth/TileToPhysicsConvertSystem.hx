package labyrinth;

import ash.tools.ListIteratingSystem;
import box2D.collision.shapes.B2PolygonShape;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2FixtureDef;
import factories.TileFactory;
import physics.B2;

/**
 * ...
 * @author damrem
 */
class TileToPhysicsConvertSystem extends ListIteratingSystem<TileNode>
{
	var cornerBlockSize:Float;
	var cornerBlockCoords:Array<Float>;
	var fixtureDef:B2FixtureDef;
	var cornerBlockAbsCoord:Float;
	
	public function new() 
	{
		super(TileNode, nodeUpdate, nodeAdded, nodeRemoved);
		
		fixtureDef = B2.createFixtureDef();
		
		cornerBlockSize = (TileFactory.SIZE - TileFactory.TUNNEL_SIZE) / 4;
		cornerBlockAbsCoord = (TileFactory.TUNNEL_SIZE + cornerBlockSize) / 2;
		cornerBlockCoords = [ -cornerBlockAbsCoord, cornerBlockAbsCoord];
		
		
	}
	
	function nodeUpdate(node:TileNode, time:Float)
	{
		
	}
	
	function nodeAdded(node:TileNode)
	{
		trace("nodeAdded" + node);
		
		node.body.b2body = B2.world.createBody(node.body.bodyDef);
		
		
		var halfTileSize = TileFactory.SIZE / 2;
		
		for (x in cornerBlockCoords)
		{
			for (y in cornerBlockCoords)
			{
				
				fixtureDef.shape = B2.createSquareShape(cornerBlockSize, x, y);
				node.body.b2body.createFixture(fixtureDef);
			}
		}
		
		if (!node.aperture.bottom)
		{
			fixtureDef.shape = B2.createRectShape(TileFactory.TUNNEL_SIZE, cornerBlockSize, 0, cornerBlockAbsCoord);
			node.body.b2body.createFixture(fixtureDef);
		}
		if (!node.aperture.top)
		{
			fixtureDef.shape = B2.createRectShape(TileFactory.TUNNEL_SIZE, cornerBlockSize, 0, -cornerBlockAbsCoord);
			node.body.b2body.createFixture(fixtureDef);
		}
		if (!node.aperture.right)
		{
			fixtureDef.shape = B2.createRectShape(cornerBlockSize, TileFactory.TUNNEL_SIZE, cornerBlockAbsCoord, 0);
			node.body.b2body.createFixture(fixtureDef);
		}
		if (!node.aperture.left)
		{
			fixtureDef.shape = B2.createRectShape(cornerBlockSize, TileFactory.TUNNEL_SIZE, cornerBlockAbsCoord, 0);
			node.body.b2body.createFixture(fixtureDef);
		}
		
		/*
		
		var shape = new B2PolygonShape();
		var fixtureDef = new B2FixtureDef();

		shape.setAsOrientedBox(50, 50, new B2Vec2( 15, 15));
		fixtureDef.shape = shape;
		node.body.b2body.createFixture(fixtureDef);
		
		shape.setAsOrientedBox(50, 50, new B2Vec2(100, 100));
		fixtureDef.shape = shape;
		node.body.b2body.createFixture(fixtureDef);
		*/
	}
	
	function nodeRemoved(node:TileNode)
	{
		
	}
	
}

