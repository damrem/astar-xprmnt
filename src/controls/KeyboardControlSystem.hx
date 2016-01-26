package controls;

import ash.tools.ListIteratingSystem;
import fireballs.ShootingComponent;
import lime.ui.KeyCode;
import openfl.display.Stage;
import openfl.events.KeyboardEvent;

/**
 * ...
 * @author damrem
 */
class KeyboardControlSystem extends ListIteratingSystem<KeyboardControlledNode>
{

	var pressedKeys:Array<Bool>;
	
	public function new(stage:Stage) 
	{
		super(KeyboardControlledNode, updateNode);
		pressedKeys = [];
		stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyUp);
	}
	
	function onKeyUp(e:KeyboardEvent):Void 
	{
		trace("onKeyUp", e.keyCode);
		pressedKeys[e.keyCode] = false;
		trace(pressedKeys);
		/*if (e.keyCode == KeyCode.SPACE || e.keyCode == KeyCode.X)
		{
			
		}*/
	}
	
	function onKeyDown(e:KeyboardEvent):Void 
	{
		trace("onKeyDown", e.keyCode);
		pressedKeys[e.keyCode] = true;
		trace(pressedKeys);
	}
	
	function updateNode(node:KeyboardControlledNode, time:Float) 
	{
		trace(pressedKeys + "[" + node.controlled.shootKeyCode+"] = " + (pressedKeys[node.controlled.shootKeyCode]));
		if (pressedKeys[node.controlled.shootKeyCode]) 
		{			
			node.entity.add(new ShootingComponent(node.entity));
		}
	}
	
}