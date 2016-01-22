package labyrinth;

import de.polygonal.ai.pathfinding.AStar;
import de.polygonal.ai.pathfinding.AStarWaypoint;
import de.polygonal.ds.Array2;
import de.polygonal.ds.Graph;
import hxlpers.Direction;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.events.MouseEvent;

using hxlpers.ds.Array2SF;

class Maze extends Sprite
{
	public var tiles:Array2<Tile>;
	
	var graph:Graph<AStarWaypoint>;
	var astar:AStar;
	
	var w:Int;
	var h:Int;
	
	var pathCanvas:Shape;
	
	
	public function new(w:Int, h:Int)
	{
		trace("new");
		super();
		this.h = h;
		this.w = w;
		
		tiles = new Array2(w, h);
		graph = new Graph<AStarWaypoint>();
		astar = new AStar(graph);
		
		for (v in 0...h)
		{
			for(u in 0...w)
			{
				var tile = new Tile(graph);
				tile.moveTo(new Array2Cell(u, v), true);
				addChild(tile);
				tiles.set(u, v, tile);
				
				addEventListener(MouseEvent.CLICK, function(e:MouseEvent)
				{
					for (otherTile in tiles)
					{
						otherTile.alpha = 1;
			}
					for (clikedTileNeighbor in getConnectedNeighbors(cast(e.target)))
					{
						clikedTileNeighbor.alpha = 0.5;
		}
		
				});
				
			}
		}
		
		pathCanvas = new Shape();
		addChild(pathCanvas);
		updateGraph();
		drawPath();
		
	}
	
	function updateGraph()
	{
		trace("updateGraph");
		var cell:Array2Cell = new Array2Cell();
		
		//	remove all arcs
		for (cleaningTile in tiles)
		{
			tiles.cellOf(cleaningTile, cell);
			cleaningTile.point.x = cell.x;
			cleaningTile.point.y = cell.y;
			cleaningTile.alpha = 1;
			for (anyNode in graph.nodeIterator())
			{
				if (cleaningTile.point.node != anyNode && cleaningTile.point.node.isConnected(anyNode))
				{
					cleaningTile.point.node.removeArc(anyNode);
				}
			}
		}
		
		//	add arcs between tiles
		for (connectingTile in tiles)
		{
			
			for (connectedNeighbor in getConnectedNeighbors(connectingTile))
			{
				if (!connectingTile.point.node.isConnected(connectedNeighbor.point.node))
				{
					graph.addSingleArc(connectingTile.point.node, connectedNeighbor.point.node);
				}	
			}
		}
	}
	
	function drawPath()
	{
		var g = pathCanvas.graphics;
		pathCanvas.scaleX = pathCanvas.scaleY = 1;
		pathCanvas.x = pathCanvas.y = Tile.SIZE / 2;
		g.clear();
		g.lineStyle(1, Std.random(0xffffff)/*, 1, false, LineScaleMode.NONE*/);
		for (point in graph)
		{
			for (connected in point.node)
			{
				g.moveTo(point.x*Tile.SIZE+Math.random()*4, point.y*Tile.SIZE+Math.random()*4);
				g.lineTo(connected.x*Tile.SIZE+Math.random()*4, connected.y*Tile.SIZE+Math.random()*4);
			}
			
		}
		
	}
	
	
	
	public function getConnectedNeighbors(tile:Tile):Array<Tile>
	{
		var connectedNeighbors = new Array<Tile>();
		
		var right = tiles.getNeighbor(tile, hxlpers.Direction.Right);
		if (right != null)
		{
			if(areConnected(tile, right))
			{
				connectedNeighbors.push(right);
			}
		}
		
		var bottom = tiles.getNeighbor(tile, hxlpers.Direction.Bottom);
		if (bottom != null)
		{
			if(areConnected(tile, bottom))
			{
				connectedNeighbors.push(bottom);
			}
		}
		
		var left = tiles.getNeighbor(tile, hxlpers.Direction.Left);
		if (left != null)
		{
			if(areConnected(tile, left))
			{
				connectedNeighbors.push(left);
			}
		}
		
		var top = tiles.getNeighbor(tile, hxlpers.Direction.Top);
		if (top != null)
		{
			if(areConnected(tile, top))
			{
				connectedNeighbors.push(top);
			}
		}
		return connectedNeighbors;
	}
	
	public function move(colIndex:Int, rowIndex:Int, direction:hxlpers.Direction)
	{
		trace("move");
		var group:Array<Tile> = tiles.move(colIndex, rowIndex, direction);
		
		updateGraph();
		drawPath();
		
		var movement=null;
		for (tile in group)
		{
			var cellDest:Array2Cell = new Array2Cell(); tiles.cellOf(tile, cellDest);
			movement = tile.moveTo(cellDest);
		}
		return movement;
	}
	
	public function areVConnected(tile0:Tile, tile1:Tile):Bool
	{
		if (!tiles.areNeighbors(tile0, tile1))
		{
			return false;
		}
		var cell0 = tiles.getCellOf(tile0);
		var cell1 = tiles.getCellOf(tile1);
		
		return (cell0.y < cell1.y && tile0.bottom && tile1.top) || (cell1.y < cell0.y && tile1.bottom && tile0.top);
	}
	
	public function areHConnected(tile0:Tile, tile1:Tile):Bool
	{
		
		if (!tiles.areNeighbors(tile0, tile1))
		{
			return false;
		}
		var cell0 = tiles.getCellOf(tile0);
		var cell1 = tiles.getCellOf(tile1);
		var oneWay = (cell0.x < cell1.x) && tile0.right && tile1.left;
		var another = (cell1.x < cell0.x) && tile1.right && tile0.left;
		return oneWay || another;
	}
	
	public function areConnected(tile0:Tile, tile1:Tile):Bool
	{
		return areHConnected(tile0, tile1) || areVConnected(tile0, tile1);
	}
	
	
	
}