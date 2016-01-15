package;

import edge.World;
import entities.rendering.EntitySprite;
import entities.rendering.Gfx;
import openfl.display.Sprite;

/**
 * ...
 * @author damrem
 */
class EdgeGame extends Sprite
{

	public function new() 
	{
		super();
		var world = new World();
		
		var hero = [];
		hero.push(new Gfx(new EntitySprite()));
		
		world.engine.create([new Gfx()]);
	}
	
}