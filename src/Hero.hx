package;

import motion.Actuate;
import motion.easing.Linear;
import openfl.display.Sprite;

/**
 * ...
 * @author damrem
 */
class Hero extends Sprite
{
	public var currentTile:Tile;

	public var isMoving:Bool;
	static public inline var SIZE=12;
	
	public function new() 
	{
		super();
		graphics.beginFill(0xff0000);
		graphics.drawCircle(0, 0, SIZE/2);
		graphics.endFill();
		
		
		
	}
	
	public function moveToTile(tile:Tile)
	{
		trace("moveToTile", tile);
		if (tile == null)
		{
			return;
		}
		isMoving = true;
		Actuate.tween(this, 0.5, { 
			x:tile.x, 
			y:tile.y
			
		} )
		.ease(Linear.easeNone)
		.onComplete(setTile, [tile]);
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