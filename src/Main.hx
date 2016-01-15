package;

import entities.EntityRoom;
import hxlpers.game.Game;
import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.Lib;

using A2;

/**
 * ...
 * @author damrem
 */
class Main extends Sprite
{

	public function new() 
	{
		super();
		
		addEventListener(Event.ADDED_TO_STAGE, onStage);
	}
	
	function onStage(event:Event)
	{
		removeEventListener(Event.ADDED_TO_STAGE, onStage);
		
		var game = new Game(stage.stageWidth, stage.stageHeight, 1);
		addChild(game);
		game.addRoom("maze", new EntityRoom(stage.stageWidth, stage.stageHeight, 1));
		
		addChild(new FPS(10, 10, 0xffffff));
	}
	
}
