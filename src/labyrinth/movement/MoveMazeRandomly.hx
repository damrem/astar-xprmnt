package labyrinth.movement;

import ash.tools.ListIteratingSystem;
import hxlpers.Direction;
import hxlpers.Rnd;
import labyrinth.movement.MazeMovementComponent;

/**
 * ...
 * @author damrem
 */
class MoveMazeRandomly extends ListIteratingSystem<MazeNode>
{
	
	var tt:Float = 0;
	var nextPeriod:Float;
	static inline var NEXT_PERIOD_MIN:Float = 2.5;
	static inline var NEXT_PERIOD_MAX:Float = 7.5;

	public function new() 
	{
		super(MazeNode, nodeUpdate);
		nextPeriod = Rnd.float(NEXT_PERIOD_MIN, NEXT_PERIOD_MAX);
	}
	
	function nodeUpdate(node:MazeNode, dt:Float) 
	{
		tt += dt;
		//trace(tt);
		//trace(nodeList.head);
		if (tt > nextPeriod)
		{
			tt = 0;
			nextPeriod = Rnd.float(NEXT_PERIOD_MIN, NEXT_PERIOD_MAX);
			startMoving(node);
		}
	}
	
	function startMoving(node:MazeNode)
	{
		trace("startMoving");
		
		var direction = Direction.None;
		var coord:Int = 0;
		
		switch(Std.random(4))
		{
			case 0:
				direction = Direction.Left;
				coord = Std.random(MazeRoom.MAZE_HEIGHT);
				
			case 1:
				direction = Direction.Up;
				coord = Std.random(MazeRoom.MAZE_WIDTH);
				
			case 2:
				direction = Direction.Right;
				coord = Std.random(MazeRoom.MAZE_HEIGHT);
				
			case 3:
				direction = Direction.Down;
				coord = Std.random(MazeRoom.MAZE_WIDTH);
		}
		
		if (direction != Direction.None)
		{
			node.entity.add(new MazeMovementComponent(direction, coord));
		}
		
	}
	
}