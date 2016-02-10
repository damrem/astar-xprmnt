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
	var originCell:Array2Cell;
	var destCell:Array2Cell;

	public function new() 
	{
		super(MovingMazeNode, nodeUpdate, nodeAdded);
		originCell = new Array2Cell();
		destCell = new Array2Cell();
	}
	
	function nodeUpdate(movingMazeNode:MovingMazeNode, dt:Float) 
	{
		
	}
	
	function nodeAdded(movingMazeNode:MovingMazeNode) 
	{
		var movingTileEntities:Array<Entity> = [];
		//var originCell;
		
		if (movingMazeNode.movement.direction != Direction.None)
		{
			movingTileEntities = movingMazeNode.maze.tiles.getRow(movingMazeNode.movement.coord, movingTileEntities);
		}
		
		for (tileEntity in movingTileEntities)
		{
			//FIXME: this originCell can't be used later, change it!
			originCell = movingMazeNode.maze.tiles.cellOf(tileEntity, originCell);
			//cast(tileEntity.get(CellComponent), CellComponent).
		}
		
		movingMazeNode.maze.tiles.move(movingMazeNode.movement.coord, movingMazeNode.movement.coord, movingMazeNode.movement.direction);
		
		for (tileEntity in movingTileEntities)
		{
			//tileEntity.add(new TileMovementComponent(movingMazeNode.movement.direction));
			
			var destCell = movingMazeNode.maze.tiles.cellOf(tileEntity, destCell);
			
			/*switch(movingMazeNode.movement.direction)
			{
				case Direction.Left:
					destCell.x --;
					if (destCell.x < 0)
					{
						destCell.x = MazeRoom.MAZE_WIDTH - 1;
					}
					
				case Direction.Up:
					destCell.y --;
					if (destCell.y < 0)
					{
						destCell.y = MazeRoom.MAZE_HEIGHT - 1;
					}
					
				case Direction.Right:
					destCell.x ++;
					if (destCell.x >= MazeRoom.MAZE_WIDTH)
					{
						destCell.x = 0;
					}
					
				case Direction.Down:
					destCell.y ++;
					if (destCell.y >= MazeRoom.MAZE_HEIGHT)
					{
						destCell.y = 0;
					}
					
				case Direction.None:
					
			}*/
			
			tileEntity.add(new TileMovementComponent(originCell, destCell));
			//tileEntity.add(new DestinationCell(
		}
	}
	
}