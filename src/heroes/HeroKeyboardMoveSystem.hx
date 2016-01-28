package heroes;

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
	
	public function new() 
	{
		super(KeyboardControlledNode, updateNode);
	}
	
	
	
	
	
	function updateNode(node:KeyboardControlledNode, time:Float) 
	{
		var leftState = keyStates[node.controlled.keySet.left];
		var upState = keyStates[node.controlled.keySet.up];
		var rightState = keyStates[node.controlled.keySet.right];
		var downState = keyStates[node.controlled.keySet.down];
		
		var isLeftPressed = leftState == KeyState.JustPressed || leftState == KeyState.Pressed;
		var isUpPressed = upState == KeyState.JustPressed || upState == KeyState.Pressed;
		var isRightPressed = rightState == KeyState.JustPressed || rightState == KeyState.Pressed;
		var isDownPressed = downState == KeyState.JustPressed || downState == KeyState.Pressed;
		

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
	
	
	
}

