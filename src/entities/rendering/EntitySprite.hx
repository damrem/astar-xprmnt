package entities.rendering;
import ash.core.Entity;
import openfl.display.Sprite;

/**
 * ...
 * @author damrem
 */
class EntitySprite extends Sprite
{

	public var entity:Entity;
	
	public function new(entity) 
	{
		super();
		this.entity = entity;
	}
	
}