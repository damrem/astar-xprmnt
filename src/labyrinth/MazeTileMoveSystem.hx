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
	
	function nodeUpdate(node:MovingMazeNode, dt:Float) 
	{
		var movingTileEntities:Array<Entity>;
		
		if(node.movement.direction==Direction.Left||node.movement.direction==Direction.Right)
		{
			node.maze.tiles.getRow(node.movement.y, movingTileEntities);
		}
		else if(node.movement.direction==Direction.Up||node.movement.direction==Direction.Down)
		{
			node.maze.tiles.getCol(node.movement.x, movingTileEntities);
		}
		
		for (tileEntity in movingTileEntities)
		{
			tileEntity.add(new TileMovementComponent(node.movement.direction));
		}
	}
	
}