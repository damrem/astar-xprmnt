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
		if (tile == null)
		{
			return;
		}
		isMoving = true;
		Actuate.tween(this, 1, { 
			x:tile.x-Tile.SIZE/2, 
			y:tile.y-Tile.SIZE/2
			
		} ).onComplete(setTile, [tile]);
	}
	
	function setTile(tile:Tile)
	{
		if (currentTile != null)
		{			
			currentTile.alpha = 1;
		}
		currentTile = tile;
		currentTile.alpha = 0.5;
		isMoving = false;
	}
	
}