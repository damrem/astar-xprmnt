package factories;
import ash.core.Entity;
import box2D.collision.shapes.B2Shape;
import box2D.dynamics.B2BodyType;
import labyrinth.TileApertureComponent;
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
	

	public static function createEntity(x:Int, y:Int):Entity
	{
		var tileEntity = new Entity();
		
		tileEntity.add(new TileApertureComponent());
		
		var bd = B2.createBodyDef((x + 0.5) * TILE_SIZE, (y + 0.5) * TILE_SIZE, B2BodyType.KINEMATIC_BODY);
		var fd = B2.createFixtureDef();
		fd.filter.categoryBits = CollisionBits.TILE_CATEGORY;
		fd.filter.maskBits = CollisionBits.TILE_MASK;
		
		tileEntity.add(new PhysicalComponent(bd, fd, B2.createSquareShape(0.1)));
		
		return tileEntity;
	}
	
}