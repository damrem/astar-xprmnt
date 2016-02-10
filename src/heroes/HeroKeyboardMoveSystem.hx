package heroes;

import ash.tools.ListIteratingSystem;
import controls.KeyState;
import heroes.HeroControlNode;
import heroes.HeroFactory.HeroCommand;
import hxlpers.Direction;

/**
 * ...
 * @author damrem
 */
class HeroKeyboardMoveSystem extends ListIteratingSystem<HeroControlNode>
{
	
	public function new() 
	{
		super(HeroControlNode, updateNode);
	}
	
	function updateNode(node:HeroControlNode, time:Float) 
	{
		var isLeftPressed = false;
		var isUpPressed = false;
		var isRightPressed = false;
		var isDownPressed = false;
		
		for (keyCode in node.controlled.keyStates.keys())
		{
			var state = node.controlled.keyStates[keyCode];
			var command = node.controlled.keyMap[keyCode];
			
			switch(command)
			{
				case HeroCommand.Left:
					isLeftPressed = state == KeyState.JustPressed || state == KeyState.Pressed;
					
				case HeroCommand.Up:
					isUpPressed = state == KeyState.JustPressed || state == KeyState.Pressed;
					
				case HeroCommand.Right:
					isRightPressed = state == KeyState.JustPressed || state == KeyState.Pressed;
					
				case HeroCommand.Down:
					isDownPressed = state == KeyState.JustPressed || state == KeyState.Pressed;
			}
			
		}
		

		if (isLeftPressed)
		{	
			node.controlled.hDirection = Direction.Left;
		}
		
		if (isUpPressed)
		{
			node.controlled.vDirection = Direction.Up;
		}
		
		if (isRightPressed)
		{
			node.controlled.hDirection = Direction.Right;
		}
		
		if (isDownPressed)
		{
			node.controlled.vDirection = Direction.Down;
		}
		
		if (!isLeftPressed && !isRightPressed)
		{
			node.controlled.hDirection = Direction.None;
		}
		
		if (!isUpPressed && !isDownPressed)
		{
			node.controlled.vDirection = Direction.None;
		}
		
		
		
		var mass = node.body.body.getMass();
		
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
			node.body.body.applyImpulse(node.controlled.impulse, node.body.body.getWorldCenter());
		}
		
	}
	
	
	
}

