package;

import de.polygonal.ai.pathfinding.AStar;
import de.polygonal.ai.pathfinding.AStarWaypoint;
import de.polygonal.ds.Array2;
import de.polygonal.ds.Graph;
import openfl.display.LineScaleMode;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.events.MouseEvent;

using A2;

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
		//updateArcs();
		//drawArcs();
		
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
				if (connectingTile == tiles.get(1, 1))
				{
					trace(connectingTile+", "+tiles.cellOf(connectingTile, new Array2Cell())+"; "+connectedNeighbor+", "+tiles.cellOf(connectedNeighbor, new Array2Cell()));
					connectedNeighbor.alpha = 0.5;
				}
				/*else
				{
					connectedNeighbor.alpha = 1;
				}*/
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
	
	
	
	public function getNeighbor(tile:Tile, direction:Direction):Tile
	{
		var cell = tiles.getNeighborCell(tiles.getCellOf(tile), direction);
		if (cell == null) return null;
		return tiles.getAt(cell);
	}
	
	public function getConnectedNeighbors(tile:Tile):Array<Tile>
	{
		var tiles = new Array<Tile>();
		
		var right = getNeighbor(tile, Right);
		if (right != null)
		{
			if(areConnected(tile, right))
			{
				tiles.push(right);
			}
		}
		
		var bottom = getNeighbor(tile, Bottom);
		if (bottom != null)
		{
			if(areConnected(tile, bottom))
			{
				tiles.push(bottom);
			}
		}
		
		var left = getNeighbor(tile, Left);
		if (left != null)
		{
			if(areConnected(tile, left))
			{
				tiles.push(left);
			}
		}
		
		var top = getNeighbor(tile, Top);
		if (top != null)
		{
			if(areConnected(tile, top))
			{
				tiles.push(top);
			}
		}
		return tiles;
	}
	
	public function move(x:Int, y:Int, direction:Direction)
	{
		trace("move");
		var group:Array<Tile> = [];
		
		switch(direction)
		{
			case Right:
				tiles.getRow(y, group);
				group.unshift(group.pop());
				tiles.setRow(y, group);
				
			case Bottom:
				tiles.getCol(x, group);
				group.unshift(group.pop());
				tiles.setCol(x, group);
				
			case Left:
				tiles.getRow(y, group);
				group.push(group.shift());
				tiles.setRow(y, group);
				
			case Top:
				tiles.getCol(x, group);
				group.push(group.shift());
				tiles.setCol(x, group);
		}
		
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
	
	public function areVNeighbors(tile0:Tile, tile1:Tile):Bool
	{
		var dy = tiles.getCellOf(tile0).y - tiles.getCellOf(tile1).y;
		return tiles.sameCol(tile0, tile1) && dy * dy == 1;
	}
	
	public function areHNeighbors(tile0:Tile, tile1:Tile):Bool
	{
		var dx = tiles.getCellOf(tile0).x - tiles.getCellOf(tile1).x;
		return tiles.sameRow(tile0, tile1) && dx * dx == 1;
	}
	
	public function areNeighbors(tile0:Tile, tile1:Tile):Bool
	{
		return areHNeighbors(tile0, tile1) || areVNeighbors(tile0, tile1);
	}
	
	
	public function areVConnected(tile0:Tile, tile1:Tile):Bool
	{
		if (!areNeighbors(tile0, tile1))
		{
			return false;
		}
		var cell0 = tiles.getCellOf(tile0);
		var cell1 = tiles.getCellOf(tile1);
		
		return (cell0.y < cell1.y && tile0.bottom && tile1.top) || (cell1.y < cell0.y && tile1.bottom && tile0.top);
	}
	
	public function areHConnected(tile0:Tile, tile1:Tile):Bool
	{
		
		if (!areNeighbors(tile0, tile1))
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
	
	/*
	public function hasLeftNeighbor(tile0:Tile, tile1:Tile)
	{
		return tiles.sameRow(otherTile) && u == otherTile.u + 1;
	}
	
	public function hasRightNeighbor(tile0:Tile, tile1:Tile)
	{
		return tiles.sameRow(otherTile) && u == otherTile.u - 1;
	}
	*/
	/*
	public function hasTopNeighbor(tile0:Tile, tile1:Tile)
	{
		return tiles.sameCol(otherTile) && v == otherTile.v + 1;
	}
	
	public function hasBottomNeighbor(tile0:Tile, tile1:Tile)
	{
		return tiles.sameCol(otherTile) && v == otherTile.v - 1;
	}
	*/
	/*
	public function hasNeighbor(tile0:Tile, tile1:Tile)
	{
		return hasBottomNeighbor(otherTile) || hasTopNeighbor(otherTile) || hasRightNeighbor(otherTile) || hasLeftNeighbor(otherTile);
	}
	*/
	/*
	public function hasLeftConnection(tile0:Tile, tile1:Tile)
	{
		return hasLeftNeighbor(otherTile) && left && otherTile.right;
	}
	
	public function hasRightConnection(tile0:Tile, tile1:Tile)
	{
		return hasRightNeighbor(otherTile) && right && otherTile.left;
	}
	
	public function hasTopConnection(tile0:Tile, tile1:Tile)
	{
		return hasTopNeighbor(otherTile) && top && otherTile.bottom;
	}
	
	public function hasBottomConnection(tile0:Tile, tile1:Tile)
	{
		return hasBottomNeighbor(otherTile) && bottom && otherTile.top;
	}
	
	public function hasConnection(tile0:Tile, tile1:Tile)
	{
		return hasLeftConnection(otherTile) || hasRightConnection(otherTile) || hasTopConnection(otherTile) || hasBottomConnection(otherTile);
	}
	*/
	
}