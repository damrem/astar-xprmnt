package labyrinth.movement;

import ash.core.Engine;
import ash.core.NodeList;
import ash.core.System;
import ash.tools.ListIteratingSystem;
import box2D.common.math.B2Vec2;
import de.polygonal.ds.Array2.Array2Cell;
import factories.TileFactory;
import hxlpers.Direction;
import hxlpers.Rnd;
import motion.Actuate;
import physics.B2;

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
	
	function nodeAdded(movingTileNode:MovingTileNode) 
	{
		for (mazeNode in mazeNodes)
		{
			var cell:Array2Cell = new Array2Cell();
			mazeNode.maze.tiles.cellOf(movingTileNode.entity, cell);
			
			/*var pos = movingTileNode.physical.body.getPosition();
			pos.add(new B2Vec2(Rnd.float(5), Rnd.float(5)));
			movingTileNode.physical.body.setPosition(pos);*/
			
			Actuate
			.tween(movingTileNode.movement.position, 1.0, { x:TileFactory.posXfromCellX(cell.x), y:TileFactory.posYfromCellY(cell.y) } )
			.onComplete(removeMovement, [movingTileNode]);
			
			trace(cell);
			//switch(mazeNode.
		}
		
		//movingTileNode.physical.body.setLinearVelocity(velocity);
		//movingTileNode.physical.body.setAwake(true);
	}
	
	function removeMovement(node:MovingTileNode)
	{
		if (node.entity != null)
		{
			node.entity.remove(TileMovementComponent);
		}
	}
	
	function nodeUpdate(node:MovingTileNode, dt:Float) 
	{
		node.physical.body.setPosition(node.movement.position);
	}
	
	override public function addToEngine(engine:Engine)
	{
		super.addToEngine(engine);
		mazeNodes = engine.getNodeList(MazeNode);
		
	}
	
	
	
	
	
}