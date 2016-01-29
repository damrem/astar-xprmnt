package controls;

import ash.tools.ListIteratingSystem;
import box2D.common.math.B2Vec2;
import controls.KeyboardControlledNode;
import openfl.display.Stage;
import openfl.events.KeyboardEvent;
import openfl.Lib;
import openfl.ui.Keyboard;

/**
 * ...
 * @author damrem
 */
class KeyboardControlSystem extends ListIteratingSystem<KeyboardControlledNode>
{
	var pressedKeys:Map<Int, Bool>;
	var keyStates:Map<Int, KeyState>;
	
	public function new() 
	{
		super(KeyboardControlledNode, updateNode);
		
		pressedKeys = new Map<Int, Bool>();
		keyStates = new Map<Int, KeyState>();
		
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
	}
	
	function onKeyDown(e:KeyboardEvent):Void 
	{
		pressedKeys[e.keyCode] = true;
	}
	
	function onKeyUp(e:KeyboardEvent):Void 
	{
		pressedKeys[e.keyCode] = false;
	}
	
	override public function update(time:Float)
	{
		
		for (key in pressedKeys.keys())
		{
			if (pressedKeys[key])
			{
				if (keyStates[key] == null || keyStates[key] == KeyState.Released || keyStates[key]==KeyState.JustReleased)
				{
					keyStates[key] = KeyState.JustPressed;
				}
				else
				{
					keyStates[key] = KeyState.Pressed;
				}
			}
			else
			{
				if (keyStates[key]==KeyState.Pressed || keyStates[key]==KeyState.JustPressed)
				{
					keyStates[key] = KeyState.JustReleased;
				}
				else
				{
					keyStates[key] = KeyState.Released;
				}
			}
		}
		
		super.update(time);
	}
	
	function updateNode(node:KeyboardControlledNode, time:Float) 
	{
		for (keyCode in node.controlled.keyMap.keys())
		{
			if (this.keyStates[keyCode] != null)
			{
				node.controlled.keyStates[keyCode] = this.keyStates[keyCode];
			}
		}
		
	}
	
	
	
}

