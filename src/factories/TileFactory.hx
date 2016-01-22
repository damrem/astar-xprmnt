package factories;
import ash.core.Entity;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2BodyType;
import box2D.dynamics.B2FixtureDef;
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
		
		var bd = B2.createBodyDef(u*TILE_SIZE, v*TILE_SIZE, B2BodyType.KINEMATIC_BODY);
		var fd = B2.createFixtureDef();
		tileEntity.add(new BodyComponent(bd, fd));
		
		return tileEntity;
	}
	
}