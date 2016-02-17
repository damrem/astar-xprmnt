package labyrinth.movement;

import ash.core.Engine;
import ash.core.NodeList;
import ash.tools.ListIteratingSystem;
import box2D.common.math.B2Vec2;
import de.polygonal.ds.Array2.Array2Cell;
import factories.TileFactory;
import hxlpers.Direction;
import motion.Actuate;

using hxlpers.ds.Array2CellSF;

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
			
			var originCell = movingTileNode.tile.cell;
			
			
			var destCell = new Array2Cell();
			mazeNode.maze.tiles.cellOf(movingTileNode.entity, destCell);

			//	No wrapping -> simple tween
			if (originCell.distance(destCell) <= 1)
			{
				movingTileNode.movement.position = new B2Vec2(TileFactory.posXfromCellX(originCell.x), TileFactory.posYfromCellY(originCell.y));
				
				Actuate
				.tween(movingTileNode.movement.position, 2.0, { 
					x:TileFactory.posXfromCellX(destCell.x), 
					y:TileFactory.posYfromCellY(destCell.y) 
				} )
				.onComplete(tweenEnded, [movingTileNode]);
			}
			//	wrapping -> clone tile, tween both original & clone
			else
			{
				
				//	the old tile
				
				var outcomingTileEntity = movingTileNode.entity;

				//	cloning the old tile
				var incomingTileEntity = TileFactory.createEntity(movingTileNode.tile.cell.x, movingTileNode.tile.cell.y, movingTileNode.tile.bits);
				
				//	placing the clone
				//TODO
				
				var position = new B2Vec2();
				switch(movingTileNode.movement.direction)
				{
					case Direction.Left:
						position.x = TileFactory.posXfromCellX(destCell.x + 1);
						position.y = TileFactory.posYfromCellY(destCell.y);
						
					case Direction.Up:
						position.x = TileFactory.posXfromCellX(destCell.x);
						position.y = TileFactory.posYfromCellY(destCell.y + 1);
						
					case Direction.Right:
						position.x = TileFactory.posXfromCellX(destCell.x - 1);
						position.y = TileFactory.posYfromCellY(destCell.y);
						
					case Direction.Down:
						position.x = TileFactory.posXfromCellX(destCell.x);
						position.y = TileFactory.posYfromCellY(destCell.y - 1);
						
					case Direction.None:
				}
				trace(position);
				
				var movement = new TileMovementComponent(destCell, movingTileNode.movement.direction);
				//movement.
				incomingTileEntity.add(movement);
				//incomingTileEntity.
				
				//	adding the clone to the engine
				MazeRoom.engine.addEntity(incomingTileEntity);
				
				//	tweening both
				
				//	replacing the old tile by the new one in the data structure
				
				//	destroying the old tile (physically & from the entity system)
				
			}
			
			
		}
	}
	
	function tweenEnded(movingTileNode:MovingTileNode)
	{
		trace("removeMovement", movingTileNode, movingTileNode.entity);
		//movingTileNode.tile.cell = movingTileNode.movement.destCell;
		movingTileNode.entity.remove(TileMovementComponent);
	}
	
	
	
	
	
	
	
	
	
}