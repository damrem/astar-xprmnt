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
	
	var pressedKeys:Array<Bool>;
	
	public function new() 
	{
		super(KeyboardControlledNode, updateNode, nodeAdded, nodeRemoved);
		
		pressedKeys = [];
		
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
	
	
	
	function updateNode(node:KeyboardControlledNode, time:Float) 
	{
		var isLeftPressed = pressedKeys[node.controlled.keySet.left];
		var isUpPressed = pressedKeys[node.controlled.keySet.up];
		var isRightPressed = pressedKeys[node.controlled.keySet.right];
		var isDownPressed = pressedKeys[node.controlled.keySet.down];
		

		if (isLeftPressed)
		{
			node.controlled.hDirection = Left;
		}
		
		if (isUpPressed)
		{
			node.controlled.vDirection = Up;
		}
		
		if (isRightPressed)
		{
			node.controlled.hDirection = Right;
		}
		
		if (isDownPressed)
		{
			node.controlled.vDirection = Down;
		}
		
		if (!isLeftPressed && !isRightPressed)
		{
			node.controlled.hDirection = None;
		}
		
		if (!isUpPressed && !isDownPressed)
		{
			node.controlled.vDirection = None;
		}
		
		
		
		var mass = node.body.b2body.getMass();
		
		switch(node.controlled.hDirection)
		{
			case Left:
				node.controlled.impulse.x = -node.controlled.reactivity * mass;
				
			case Right:
				node.controlled.impulse.x = node.controlled.reactivity * mass;
				
			default:
				node.controlled.impulse.x = 0;
		}
		
		switch(node.controlled.vDirection)
		{
			case Up:
				node.controlled.impulse.y = -node.controlled.reactivity * mass;
				
			case Down:
				node.controlled.impulse.y = node.controlled.reactivity * mass;
				
			default:
				node.controlled.impulse.y = 0;
		}
		
		
		if (node.controlled.impulse.x != 0 || node.controlled.impulse.y != 0) {			
			node.body.b2body.applyImpulse(node.controlled.impulse, node.body.b2body.getWorldCenter());
		}
	}
	
	function nodeAdded(node:KeyboardControlledNode) 
	{
		
	}
	
	function nodeRemoved(node:KeyboardControlledNode) 
	{
		
	}
	
}

enum Direction {
	Up;
	Down;
	Left;
	Right;
	None;
}