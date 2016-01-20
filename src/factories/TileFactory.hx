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
	public static var SIZE:Float = 64;
	public static var TUNNEL_SIZE:Float = 32;
	

	public static function create():Entity
	{
		var entity = new Entity();
		entity.add(new TileApertureComponent());
		var bd = B2.createBodyDef(100, 100, B2BodyType.KINEMATIC_BODY);
		var fd = B2.createFixtureDef();
		entity.add(new BodyComponent(bd, fd));
		return entity;
	}
	
}