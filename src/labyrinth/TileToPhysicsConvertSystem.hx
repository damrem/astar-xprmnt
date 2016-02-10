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
	//var fixtureDef:B2FixtureDef;
	var cornerBlockAbsCoord:Float;
	var wallLength:Float;
	
	public function new() 
	{
		super(TileNode, nodeUpdate, nodeAdded, nodeRemoved);
		/*
		fixtureDef = B2.createFixtureDef();
		fixtureDef.filter.categoryBits = CollisionBits.TILE_CATEGORY;
		fixtureDef.filter.maskBits = CollisionBits.TILE_MASK;
		*/
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
		node.physical.body = B2.world.createBody(node.physical.bodyDef);
		
		//node.physical.body.getFixtureList().destroy();
		
		for (x in cornerBlockCoords)
		{
			for (y in cornerBlockCoords)
			{
				node.physical.fixtureDef.shape = B2.createSquareShape(cornerBlockSize, x, y);
				node.physical.body.createFixture(node.physical.fixtureDef);
			}
		}
		
		if (!node.aperture.bottom)
		{
			node.physical.fixtureDef.shape = B2.createRectShape(wallLength, cornerBlockSize, 0, cornerBlockAbsCoord);
			node.physical.body.createFixture(node.physical.fixtureDef);
		}
		if (!node.aperture.top)
		{
			node.physical.fixtureDef.shape = B2.createRectShape(wallLength, cornerBlockSize, 0, -cornerBlockAbsCoord);
			node.physical.body.createFixture(node.physical.fixtureDef);
		}
		if (!node.aperture.right)
		{
			node.physical.fixtureDef.shape = B2.createRectShape(cornerBlockSize, wallLength, cornerBlockAbsCoord, 0);
			node.physical.body.createFixture(node.physical.fixtureDef);
		}
		if (!node.aperture.left)
		{
			node.physical.fixtureDef.shape = B2.createRectShape(cornerBlockSize, wallLength, cornerBlockAbsCoord, 0);
			node.physical.body.createFixture(node.physical.fixtureDef);
		}
		
	}
	
	function nodeRemoved(node:TileNode)
	{
		
	}
	
}

