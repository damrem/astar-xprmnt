package labyrinth.movement;

import ash.core.Entity;
import ash.tools.ListIteratingSystem;
import de.polygonal.ds.Array2.Array2Cell;
import hxlpers.Direction;
import labyrinth.movement.TileMovementComponent;

using hxlpers.ds.Array2SF;

/**
 * ...
 * @author damrem
 */
class MoveMaze extends ListIteratingSystem<MovingMazeNode>
{
	var destCell:Array2Cell;

	public function new() 
	{
		super(MovingMazeNode, nodeUpdate, nodeAdded);
		destCell = new Array2Cell();
	}
	
	function nodeUpdate(movingMazeNode:MovingMazeNode, dt:Float) 
	{
		
	}
	
	function nodeAdded(movingMazeNode:MovingMazeNode) 
	{
		var movingTileEntities:Array<Entity> = [];
		//var originCell;
		
		if (movingMazeNode.movement.direction == Direction.Left || movingMazeNode.movement.direction == Direction.Right)
		{
			movingTileEntities = movingMazeNode.maze.tiles.getRow(movingMazeNode.movement.coord, movingTileEntities);
		}
		else if (movingMazeNode.movement.direction == Direction.Up || movingMazeNode.movement.direction == Direction.Down)
		{
			movingTileEntities = movingMazeNode.maze.tiles.getCol(movingMazeNode.movement.coord, movingTileEntities);
		}
		
		for (tileEntity in movingTileEntities)
		{
			var tileComponent = cast(tileEntity.get(TileComponent), TileComponent);
			tileComponent.cell = movingMazeNode.maze.tiles.cellOf(tileEntity, tileComponent.cell);
			
		}
		
		movingMazeNode.maze.tiles.move(movingMazeNode.movement.coord, movingMazeNode.movement.coord, movingMazeNode.movement.direction);
		
		for (tileEntity in movingTileEntities)
		{
			var destCell = movingMazeNode.maze.tiles.cellOf(tileEntity, destCell);
			
			tileEntity.add(new TileMovementComponent(destCell));
			
		}
	}
	
}