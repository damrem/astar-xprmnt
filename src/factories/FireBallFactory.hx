package factories;
import ash.core.Entity;
import physics.B2;
import randommove.RandomMove;

/**
 * ...
 * @author damrem
 */
class FireBallFactory
{

	static public function create(shooter:Entity):Entity
	{
		var entity = SimpleEntityCreator.createBallEntity(0, 0, 0, 0xffff00);
		entity.add(new RandomMove());
		return entity;
	}
	
}