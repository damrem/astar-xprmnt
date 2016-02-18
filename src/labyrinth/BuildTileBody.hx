package labyrinth;

import edge.Entity;
import edge.ISystem;
import factories.TileFactory;
import physics.B2;
import physics.PhysicalComponent;

/**
 * Converts tile aperture into a compound body. 
 * @author damrem
 */
class BuildTileBody implements ISystem
{
	var cornerBlockSize:Float;
	var cornerBlockCoords:Array<Float>;
	var cornerBlockAbsCoord:Float;
	var wallLength:Float;
	
	public function new() 
	{
		cornerBlockSize = (TileFactory.TILE_SIZE - TileFactory.TUNNEL_SIZE) / 4;
		cornerBlockAbsCoord = (TileFactory.TUNNEL_SIZE) / 2 + cornerBlockSize;
		cornerBlockCoords = [ -cornerBlockAbsCoord, cornerBlockAbsCoord];
		wallLength = TileFactory.TUNNEL_SIZE / 2;
	}
	
	public function update(tile:TileComponent, physical:PhysicalComponent)
	{
		
	}
	
	public function updateAdded(entity:Entity, node:TileNode)
	{
		trace("tile node added");
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
	
	public function updateRemoved(entity:Entity, node:TileNode)
	{
		B2.world.destroyBody(node.physical.body);
	}
	
}

