package fireballs;

import ash.core.Entity;

/**
 * ...
 * @author damrem
 */
class ShootingComponent
{
	var shooter:Entity;

	public function new(shooter:Entity) 
	{
		trace("new", shooter);
		this.shooter = shooter;
	}
	
}