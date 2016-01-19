package factories;
import ash.core.Entity;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2FixtureDef;
import labyrinth.TileApertureComponent;
import physics.BodyComponent;

/**
 * ...
 * @author damrem
 */
class TileFactory
{

	public static function create():Entity
	{
		var entity = new Entity();
		entity.add(new TileApertureComponent());
		entity.add(new BodyComponent(new B2BodyDef(), new B2FixtureDef()));
		return entity;
	}
	
}