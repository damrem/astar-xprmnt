package;

import entities.EntityRoom;
import openfl.display.Sprite;
import openfl.Lib;

/**
 * ...
 * @author damrem
 */
class AshGame extends Sprite
{

	public function new() 
	{
		super();
		
		addChild(new EntityRoom(Lib.current.stage.stageWidth, Lib.current.stage.stageHeight, 4));
		
	}
	
}