package labyrinth.movement;

import ash.core.Engine;
import ash.core.NodeList;
import ash.tools.ListIteratingSystem;
import box2D.common.math.B2Vec2;
import de.polygonal.ds.Array2.Array2Cell;
import factories.TileFactory;
import motion.Actuate;

/**
 * ...
 * @author damrem
 */
class MoveTile extends ListIteratingSystem<MovingTileNode>
{
	var mazeNodes:NodeList<MazeNode>;
	
	public function new() 
	{
		super(MovingTileNode, nodeUpdate, nodeAdded);
	}
	
	override public function addToEngine(engine:Engine)
	{
		super.addToEngine(engine);
		mazeNodes = engine.getNodeList(MazeNode);
	}
	
	function nodeUpdate(movingTileNode:MovingTileNode, dt:Float) 
	{
		movingTileNode.physical.body.setPosition(movingTileNode.movement.position);
	}
	
	function nodeAdded(movingTileNode:MovingTileNode) 
	{
		for (mazeNode in mazeNodes)
		{
			trace("mazeNode", mazeNode);
			
			var cell:Array2Cell = new Array2Cell();
			mazeNode.maze.tiles.cellOf(movingTileNode.entity, cell);
			
			movingTileNode.movement.position = new B2Vec2(TileFactory.posXfromCellX(movingTileNode.tile.cell.x), TileFactory.posYfromCellY(movingTileNode.tile.cell.y));
			
			Actuate
			.tween(movingTileNode.movement.position, 2.0, { 
				x:TileFactory.posXfromCellX(cell.x), 
				y:TileFactory.posYfromCellY(cell.y) 
			} )
			.onComplete(tweenEnded, [movingTileNode]);
		}
	}
	
	function tweenEnded(movingTileNode:MovingTileNode)
	{
		trace("removeMovement", movingTileNode, movingTileNode.entity);
		//movingTileNode.tile.cell = movingTileNode.movement.destCell;
		movingTileNode.entity.remove(TileMovementComponent);
	}
	
	
	
	
	
	
	
	
	
}