package;

import de.polygonal.ds.Array2.Array2Cell;
import motion.Actuate;
import motion.easing.Linear;
import openfl.display.Sprite;

/**
 * ...
 * @author damrem
 */
class Hero extends Sprite
{
	static public inline var SIZE=12;

	public var cell:Array2Cell;
	public var isMoving:Bool;
	
	public function new() 
	{
		super();
		graphics.beginFill(0xff0000);
		graphics.drawCircle(0, 0, SIZE/2);
		graphics.endFill();
		cell = new Array2Cell();
	}
	
	
	public function moveTo(x:Int, y:Int, instant=false)
	{
		var cell = new Array2Cell(x, y);
		moveToCell(cell, instant);
	}
	
	public function moveToCell(cell:Array2Cell, instant=false)
	{
		trace("moveTo", cell.x, cell.y, instant);
		this.cell = cell;
		isMoving = !instant;
		
		Actuate
		.tween(this, instant?0:0.5, { 
			x:(cell.x+0.5)*Tile.SIZE, 
			y:(cell.y+0.5)*Tile.SIZE
			
		} )
		.ease(Linear.easeNone)
		.onComplete(function()
		{
			isMoving = false;
		});
	}
	
	
	
	
	
	
	
	
}