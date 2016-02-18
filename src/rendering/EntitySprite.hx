package rendering;

import openfl.display.Sprite;

/**
 * ...
 * @author damrem
 */
class EntitySprite extends Sprite
{

	public var entity:Array<{}>;
	
	public function new(entity) 
	{
		super();
		this.entity = entity;
	}
	
}