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

/**
 * ...
 * @author damrem
 */
class Main extends Sprite 
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
		
		var maxV = Std.int(Lib.current.stage.stageHeight / Tile.SIZE);
		var maxU = maxV;
		
		maze = new Maze(maxU, maxV);
		
		addChild(maze);
		var tiles = maze.tiles;
		
		/*
		for (v in 0 ... maxV)
		{
			for (u in 0 ... maxU)
			{
				tiles[v * maxU + u].rightNeighbor = tiles[v * maxU + u + 1];
				tiles[v * maxU + u].bottomNeighbor = tiles[v * maxU + u + maxU];
				tiles[v * maxU + u].leftNeighbor = tiles[v * maxU + u - 1];
				tiles[v * maxU + u].topNeighbor = tiles[v * maxU + u - maxU];
			}
		}
		*/
		
		/*
		for (tile0 in tiles)
		{
			for (tile1 in tiles)
			{
				if (tile0.hasConnection(tile1))
				{
					tile0.point.node.addArc(tile1.point.node);
					
				}
			}
		}
		*/
				
		pathCanvas = new Shape();
		addChild(pathCanvas);
		
		hero = new Hero();
		addChild(hero);
		hero.moveToCell(new Array2Cell(), true);
		
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		
		
	}
	
	private function onKeyDown(e:KeyboardEvent):Void 
	{
		trace(e);
		
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
					
			}

			var cellDest = maze.getNeighborCell(hero.cell, direction);
			
			
			if (cellDest != null)
			{
				var tileOrigin = maze.tiles.getAt(hero.cell);
				var tileDest = maze.tiles.getAt(cellDest);
				if (tileOrigin.point.node.getArc(tileDest.point.node) == null)
				{
					maze.move(hero.cell.x, hero.cell.y, direction);
				}
				hero.moveToCell(cellDest);
			}
			
			
			
		}
		
	}
	
	//function moveHeroToTile
	/*
	function select(tile:Tile)
	{
		for (anyTile in maze.tiles)
		{
			anyTile.select(false);
		}
		
		selectedTile0 = selectedTile1;
		selectedTile1 = tile;
		if (selectedTile1 != null)
		{
			selectedTile1.select();
		}
		if (selectedTile0 != null)
		{
			selectedTile0.select();
		}

		pathCanvas.graphics.clear();
		pathCanvas.graphics.lineStyle(5, 0xffffff00);
		
		var path = new DA<AStarWaypoint>();
		
		if (selectedTile0 != null && selectedTile1 != null)
		{
			if (astar.find(graph, selectedTile0.point, selectedTile1.point, path))
			{
				trace(path);
				pathCanvas.graphics.moveTo((path.get(0).x+0.5)*Tile.SIZE, (path.get(0).y+0.5)*Tile.SIZE);
				for (p in path) {
					
					pathCanvas.graphics.lineTo((p.x+0.5)*Tile.SIZE, (p.y+0.5)*Tile.SIZE);
					
				}
			}
			
		}
	}
	*/

}
