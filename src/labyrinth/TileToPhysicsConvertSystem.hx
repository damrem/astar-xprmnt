package labyrinth;

import ash.tools.ListIteratingSystem;
import box2D.dynamics.B2FixtureDef;
import factories.TileFactory;
import physics.B2;

/**
 * Converts tile aperture into a compound body. 
 * @author damrem
 */
class TileToPhysicsConvertSystem extends ListIteratingSystem<TileNode>
{
	var cornerBlockSize:Float;
	var cornerBlockCoords:Array<Float>;
	var fixtureDef:B2FixtureDef;
	var cornerBlockAbsCoord:Float;
	var wallLength:Float;
	
	public function new() 
	{
		super(TileNode, nodeUpdate, nodeAdded, nodeRemoved);
		
		fixtureDef = B2.createFixtureDef();
		
		cornerBlockSize = (TileFactory.TILE_SIZE - TileFactory.TUNNEL_SIZE) / 4;
		cornerBlockAbsCoord = (TileFactory.TUNNEL_SIZE) / 2 + cornerBlockSize;
		trace(cornerBlockAbsCoord);
		cornerBlockCoords = [ -cornerBlockAbsCoord, cornerBlockAbsCoord];
		wallLength = TileFactory.TUNNEL_SIZE / 2;
		
	}
	
	function nodeUpdate(node:TileNode, time:Float)
	{
		
	}
	
	function nodeAdded(node:TileNode)
	{
		node.body.b2body = B2.world.createBody(node.body.bodyDef);
		
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
			fixtureDef.shape = B2.createRectShape(wallLength, cornerBlockSize, 0, cornerBlockAbsCoord);
			node.body.b2body.createFixture(fixtureDef);
		}
		if (!node.aperture.top)
		{
			fixtureDef.shape = B2.createRectShape(wallLength, cornerBlockSize, 0, -cornerBlockAbsCoord);
			node.body.b2body.createFixture(fixtureDef);
		}
		if (!node.aperture.right)
		{
			fixtureDef.shape = B2.createRectShape(cornerBlockSize, wallLength, cornerBlockAbsCoord, 0);
			node.body.b2body.createFixture(fixtureDef);
		}
		if (!node.aperture.left)
		{
			fixtureDef.shape = B2.createRectShape(cornerBlockSize, wallLength, cornerBlockAbsCoord, 0);
			node.body.b2body.createFixture(fixtureDef);
		}
		
	}
	
	function nodeRemoved(node:TileNode)
	{
		
	}
	
}

