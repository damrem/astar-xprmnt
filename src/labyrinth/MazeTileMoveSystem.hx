package labyrinth;

import ash.core.Entity;
import ash.tools.ListIteratingSystem;
import hxlpers.Direction;

using hxlpers.ds.Array2SF;

/**
 * ...
 * @author damrem
 */
class MazeTileMoveSystem extends ListIteratingSystem<MovingMazeNode>
{

	public function new() 
	{
		super(MovingMazeNode, nodeUpdate);
	}
	
	function nodeUpdate(movingMazeNode:MovingMazeNode, dt:Float) 
	{
		var movingTileEntities:Array<Entity> = [];
		
		if (movingMazeNode.movement.direction == Direction.Left || movingMazeNode.movement.direction == Direction.Right)
		{
			movingMazeNode.maze.tiles.getRow(movingMazeNode.movement.y, movingTileEntities);
		}
		else if (movingMazeNode.movement.direction == Direction.Up || movingMazeNode.movement.direction == Direction.Down)
		{
			movingMazeNode.maze.tiles.getCol(movingMazeNode.movement.x, movingTileEntities);
		}
		
		for (tileEntity in movingTileEntities)
		{
			tileEntity.add(new TileMovementComponent(movingMazeNode.movement.direction));
		}
	}
	
}