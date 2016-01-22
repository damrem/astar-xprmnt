package controls;

import ash.tools.ListIteratingSystem;
import openfl.display.Stage;
import openfl.events.KeyboardEvent;

/**
 * ...
 * @author damrem
 */
class KeyboardControlSystem extends ListIteratingSystem<KeyboardControlledNode>
{

	public function new(stage:Stage) 
	{
		super(KeyboardControlledNode, updateNode);
		stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyUp);
	}
	
	function onKeyUp(e:KeyboardEvent):Void 
	{
		
	}
	
	function onKeyDown(e:KeyboardEvent):Void 
	{
		trace(e.charCode, e.keyCode);
	}
	
	function updateNode(node:KeyboardControlledNode, time:Float) 
	{
		
	}
	
}