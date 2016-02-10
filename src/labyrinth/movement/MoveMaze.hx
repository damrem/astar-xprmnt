package labyrinth.movement;

import ash.core.Entity;
import ash.tools.ListIteratingSystem;
import hxlpers.Direction;
import labyrinth.movement.TileMovementComponent;

using hxlpers.ds.Array2SF;

/**
 * ...
 * @author damrem
 */
class MoveMaze extends ListIteratingSystem<MovingMazeNode>
{

	public function new() 
	{
		super(MovingMazeNode, nodeUpdate);
	}
	
	function nodeUpdate(movingMazeNode:MovingMazeNode, dt:Float) 
	{
		var movingTileEntities:Array<Entity> = [];
		
		if (movingMazeNode.movement.direction != Direction.None)
		{
			movingMazeNode.maze.tiles.getRow(movingMazeNode.movement.coord, movingTileEntities);
		}
		
		movingMazeNode.maze.tiles.move(movingMazeNode.movement.coord, movingMazeNode.movement.coord, movingMazeNode.movement.direction);
		
		for (tileEntity in movingTileEntities)
		{
			//tileEntity.add(new TileMovementComponent(movingMazeNode.movement.direction));
			
			tileEntity.add(new TileMovementComponent());
			//tileEntity.add(new DestinationCell(
		}
	}
	
}