package labyrinth;

import ash.core.Engine;
import ash.core.NodeList;
import ash.core.System;
import box2D.common.math.B2Vec2;
import hxlpers.Direction;
import physics.B2;

/**
 * ...
 * @author damrem
 */
class MoveTileSystem extends System
{
	var movingTileNodes:NodeList<MovingTileNode>;
	var mazeNodes:NodeList<MazeNode>;
	var velocity:B2Vec2;
	static inline var SPEED:Float = 5000;
	
	public function new() 
	{
		super();
		velocity = new B2Vec2();
	}
	
	override public function addToEngine(engine:Engine)
	{
		movingTileNodes = engine.getNodeList(MovingTileNode);
		mazeNodes = engine.getNodeList(MazeNode);
	}
	
	override function update(dt:Float) 
	{
		for (movingTileNode in movingTileNodes)
		{
			switch(movingTileNode.movement.direction)
			{
				case Direction.Left:
					velocity.x = - SPEED;
					velocity.y = 0;
					
				case Direction.Up:
					velocity.x = 0;
					velocity.y = - SPEED;
					
				case Direction.Right:
					velocity.x = SPEED;
					velocity.y = 0;
					
				case Direction.Down:
					velocity.x = 0;
					velocity.y = SPEED;
					
				case Direction.None:
					velocity.x = 0;
					velocity.y = 0;
					
				
			}
			movingTileNode.physical.body.setLinearVelocity(velocity);
			movingTileNode.physical.body.setAwake(true);
		}
	}
	
	
	
}