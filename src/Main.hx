package;

import MazeRoom;
import hxlpers.game.Game;
import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.Lib;

using hxlpers.ds.Array2SF;

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
		
		var mazeRoom = new MazeRoom(stage.stageWidth, stage.stageHeight, 1);
		game.addRoom("maze", mazeRoom);
		
		addChild(mazeRoom.phyDebugSprite);
		
		addChild(new FPS(10, 10, 0xffffff));
	}
	
}
