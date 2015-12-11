package;

import motion.Actuate;
import openfl.display.Sprite;

/**
 * ...
 * @author damrem
 */
class Hero extends Sprite
{
	public var currentTile:Tile;

	public var isMoving:Bool;
	
	public function new() 
	{
		super();
		
	}
	
	public function moveToTile(tile:Tile)
	{
		Actuate.tween(this, 1, { 
			x:tile.x, 
			y:tile.y
			
		} ).onComplete(setTile, [tile]);
	}
	
	function setTile(tile:Tile)
	{
		currentTile = tile;
	}
	
}