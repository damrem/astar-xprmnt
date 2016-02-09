package factories;
import ash.core.Entity;
import box2D.dynamics.B2BodyType;
import labyrinth.TileApertureComponent;
import physics.B2;
import physics.BodyComponent;

/**
 * ...
 * @author damrem
 */
class TileFactory
{
	public static var TILE_SIZE:Float = 64;
	public static var TUNNEL_SIZE:Float = 32;
	

	public static function createEntity(u:Int, v:Int):Entity
	{
		var tileEntity = new Entity();
		
		tileEntity.add(new TileApertureComponent());
		
		var bd = B2.createBodyDef((u + 0.5) * TILE_SIZE, (v + 0.5) * TILE_SIZE, B2BodyType.KINEMATIC_BODY);
		var fd = B2.createFixtureDef();
		fd.filter.categoryBits = CollisionBits.TILE_CATEGORY;
		fd.filter.maskBits = CollisionBits.TILE_MASK;
		trace("boundary", CollisionBits.TILE_CATEGORY, CollisionBits.TILE_MASK);
		tileEntity.add(new BodyComponent(bd, fd));
		
		return tileEntity;
	}
	
}