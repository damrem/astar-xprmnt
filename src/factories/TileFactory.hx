package factories;

import box2D.dynamics.B2BodyType;
import labyrinth.TileComponent;
import physics.B2;
import physics.PhysicalComponent;

/**
 * ...
 * @author damrem
 */
class TileFactory
{
	public static var TILE_SIZE:Float = 64;
	public static var TUNNEL_SIZE:Float = 32;
	

	public static function createEntity(x:Int, y:Int):Ent
	{
		var tileEntity = new Ent();
		
		tileEntity.push(new TileComponent(x, y));
		
		var bd = B2.createBodyDef(posXfromCellX(x), posYfromCellY(y), B2BodyType.KINEMATIC_BODY);
		
		var fd = B2.createFixtureDef();
		
		fd.filter.categoryBits = CollisionBits.TILE_CATEGORY;
		fd.filter.maskBits = CollisionBits.TILE_MASK;
		
		tileEntity.push(new PhysicalComponent(bd, fd));
		
		return tileEntity;
	}
	
	public static function posXfromCellX(cellX:Int):Float
	{
		return (cellX + 0.5) * TILE_SIZE;
	}
	
	public static function posYfromCellY(cellY:Int):Float
	{
		return (cellY + 0.5) * TILE_SIZE;
	}
	
}