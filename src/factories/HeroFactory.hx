package factories;
import ash.core.Entity;
import box2D.dynamics.B2World;
import physics.BodyComponent;

/**
 * ...
 * @author damrem
 */
class HeroFactory
{
	public static var SIZE:Float = 25;
	
	public static function createHero(x:Float, y:Float, entityCreator:EntityCreator):Entity
	{
		var entity = new Entity("hero");
		return entityCreator.createBallEntity(x, y, SIZE, 0, 0xff0000);
		//entity.add(new Phy(
	}
	
}