package labyrinth;

import ash.tools.ListIteratingSystem;
import box2D.dynamics.B2FixtureDef;
import factories.TileFactory;
import physics.B2;

/**
 * Converts tile aperture into a compound body. 
 * @author damrem
 */
class BuildTileBody extends ListIteratingSystem<TileNode>
{
	var cornerBlockSize:Float;
	var cornerBlockCoords:Array<Float>;
	//var fixtureDef:B2FixtureDef;
	var cornerBlockAbsCoord:Float;
	var wallLength:Float;
	
	public function new() 
	{
		super(TileNode, nodeUpdate, nodeAdded, nodeRemoved);
		
		cornerBlockSize = (TileFactory.TILE_SIZE - TileFactory.TUNNEL_SIZE) / 4;
		cornerBlockAbsCoord = (TileFactory.TUNNEL_SIZE) / 2 + cornerBlockSize;
		cornerBlockCoords = [ -cornerBlockAbsCoord, cornerBlockAbsCoord];
		wallLength = TileFactory.TUNNEL_SIZE / 2;
	}
	
	function nodeUpdate(node:TileNode, time:Float)
	{
		
	}
	
	function nodeAdded(node:TileNode)
	{
		node.physical.body = B2.world.createBody(node.physical.bodyDef);
		
		for (x in cornerBlockCoords)
		{
			for (y in cornerBlockCoords)
			{
				node.physical.fixtureDef.shape = B2.createSquareShape(cornerBlockSize, x, y);
				node.physical.body.createFixture(node.physical.fixtureDef);
			}
		}
		
		if (!node.tile.bottom)
		{
			node.physical.fixtureDef.shape = B2.createRectShape(wallLength, cornerBlockSize, 0, cornerBlockAbsCoord);
			node.physical.body.createFixture(node.physical.fixtureDef);
		}
		if (!node.tile.top)
		{
			node.physical.fixtureDef.shape = B2.createRectShape(wallLength, cornerBlockSize, 0, -cornerBlockAbsCoord);
			node.physical.body.createFixture(node.physical.fixtureDef);
		}
		if (!node.tile.right)
		{
			node.physical.fixtureDef.shape = B2.createRectShape(cornerBlockSize, wallLength, cornerBlockAbsCoord, 0);
			node.physical.body.createFixture(node.physical.fixtureDef);
		}
		if (!node.tile.left)
		{
			node.physical.fixtureDef.shape = B2.createRectShape(cornerBlockSize, wallLength, cornerBlockAbsCoord, 0);
			node.physical.body.createFixture(node.physical.fixtureDef);
		}
		
	}
	
	function nodeRemoved(node:TileNode)
	{
		B2.world.destroyBody(node.physical.body);
	}
	
}

