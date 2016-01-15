package;

import de.polygonal.ai.pathfinding.AStar;
import de.polygonal.ai.pathfinding.AStarWaypoint;
import de.polygonal.ds.Array2.Array2Cell;
import de.polygonal.ds.DA;
import de.polygonal.ds.Graph;
import de.polygonal.ds.GraphNode;
import motion.Actuate;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.events.KeyboardEvent;
import openfl.events.MouseEvent;
import openfl.Lib;

using A2;

/**
 * ...
 * @author damrem
 */
class Game extends Sprite 
{
	
	var selectedTile0:Tile;
	var selectedTile1:Tile;
	
	var pathCanvas:Shape;
	
	var hero:Hero;
	var heroIsMoving:Bool;
	var maze:Maze;

	public function new() 
	{
		super();
		
		#if debug
		new MazeTestCase();
		#end
		
		var maxV = Std.int(Lib.current.stage.stageHeight / Tile.SIZE);
		var maxU = maxV = 4;
		
		//maze = new Maze(maxU, maxV);
		maze = new Maze(5, 5);
		
		addChild(maze);
		var tiles = maze.tiles;
		
		
				
		pathCanvas = new Shape();
		addChild(pathCanvas);
		
		hero = new Hero();
		addChild(hero);
		hero.moveToCell(new Array2Cell(), true);
		
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		
		
	}
	
	function onKeyDown(e:KeyboardEvent):Void 
	{
		//trace(e);
		
		var direction:Direction = null;
		if (!hero.isMoving)
		{
			switch(e.keyCode)
			{
				case 37:
					direction = Direction.Left;
					
				case 38:
					direction = Direction.Top;
					
				case 39:
					direction = Direction.Right;
					
				case 40:
					direction = Direction.Bottom;
					
				default:
					return;
			}

			var cellDest = maze.tiles.getNeighborCell(hero.cell, direction);
			
			
			if (cellDest != null)
			{
				var tileOrigin = maze.tiles.getAt(hero.cell);
				var tileDest = maze.tiles.getAt(cellDest);
				if (!tileOrigin.point.node.isMutuallyConnected(tileDest.point.node))
				{
					maze.move(hero.cell.x, hero.cell.y, direction);
				}
				hero.moveToCell(cellDest);
			}
			
			
			
		}
		
	}
	
	

}
