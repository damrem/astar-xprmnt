package;

import de.polygonal.ai.pathfinding.AStar;
import de.polygonal.ai.pathfinding.AStarWaypoint;
import de.polygonal.ds.Array2;
import de.polygonal.ds.Graph;
import openfl.display.LineScaleMode;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.events.MouseEvent;

class Maze extends Sprite
{
	public var tiles:Array2<Tile>;
	
	var graph:Graph<AStarWaypoint>;
	var astar:AStar;
	
	var w:Int;
	var h:Int;
	
	var pathCanvas:Shape;
	var countright:Int;
	var countbottom:Int;
	var countleft:Int;
	var counttop:Int;
	
	public function new(w:Int, h:Int)
	{
		trace("new");
		super();
		this.h = h;
		this.w = w;
		
		tiles = new Array2(w,h);
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
		
		//graph.clear();
		
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
		
		for (debugTile in tiles)
		{
			//trace(debugTile.point.node);
		}
	}
	
	function drawPath()
	{
		trace('drawPath');
		var g = pathCanvas.graphics;
		pathCanvas.x = pathCanvas.y = Tile.SIZE / 2;
		//pathCanvas.scaleX = pathCanvas.scaleY = Tile.SIZE;
		g.clear();
		g.lineStyle(1, Std.random(0xffffff), 1, true, LineScaleMode.NONE);
		for (point in graph)
		{
			//trace(point);
			for (connected in point.node)
			{
				g.moveTo(point.x*Tile.SIZE+Math.random()*4, point.y*Tile.SIZE+Math.random()*4);
				g.lineTo(connected.x*Tile.SIZE+Math.random()*4, connected.y*Tile.SIZE+Math.random()*4);
				//trace(point, connected);
			}
			//trace('========');
		}
		
	}
	
	public function getNeighborCell(refCell:Array2Cell, direction:Direction, wrapped=false):Array2Cell
	{
		var cell = new Array2Cell(refCell.x, refCell.y);
		switch(direction)
		{
			case Right:
				cell.x++;
				if (cell.x >= w)
				{
					if (!wrapped) return null;
					cell.x = 0;
				}
				
			case Bottom:
				cell.y++;
				if (cell.y >= h)
				{
					if (!wrapped) return null;
					cell.y = 0;
				}
				
			case Left:
				cell.x--;
				if (cell.x < 0)
				{
					if (!wrapped) return null;
					cell.x = w - 1;
				}
				
			case Top:
				cell.y--;
				if (cell.y < 0)
				{
					if (!wrapped) return null;
					cell.y = h - 1;
				}
				
		}
		return cell;
	}
	
	public function getNeighbor(tile:Tile, direction:Direction):Tile
	{
		var cell = getNeighborCell(getTileCell(tile), direction);
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
				countright++;
				tiles.push(right);
			}
		}
		
		var bottom = getNeighbor(tile, Bottom);
		if (bottom != null)
		{
			if(areConnected(tile, bottom))
			{
				countbottom++;
				tiles.push(bottom);
			}
		}
		
		var left = getNeighbor(tile, Left);
		if (left != null)
		{
			if(areConnected(tile, left))
			{
				countleft++;
				tiles.push(left);
			}
		}
		
		var top = getNeighbor(tile, Top);
		if (top != null)
		{
			if(areConnected(tile, top))
			{
				counttop++;
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
		
		var movement = null;
		for (tile in group)
		{
			var cellDest:Array2Cell = new Array2Cell(); tiles.cellOf(tile, cellDest);
			movement = tile.moveTo(cellDest);
		}
		return movement;
	}
	
	function getTileCell(tile:Tile)
	{
		var cell = new Array2Cell();
		tiles.cellOf(tile, cell);
		return cell;
	};
	
	public function sameRow(tile0:Tile, tile1:Tile)
	{
		return getTileCell(tile0).y == getTileCell(tile1).y;
	}
	
	public function sameCol(tile0:Tile, tile1:Tile)
	{
		return getTileCell(tile0).x == getTileCell(tile1).x;
	}
	
	public function areVNeighbors(tile0:Tile, tile1:Tile)
	{
		var dy = getTileCell(tile0).y - getTileCell(tile1).y;
		return sameCol(tile0, tile1) && dy * dy == 1;
	}
	
	public function areHNeighbors(tile0:Tile, tile1:Tile)
	{
		var dx = getTileCell(tile0).x - getTileCell(tile1).x;
		return sameRow(tile0, tile1) && dx * dx == 1;
	}
	
	public function areNeighbors(tile0:Tile, tile1:Tile)
	{
		return areHNeighbors(tile0, tile1) || areVNeighbors(tile0, tile1);
	}
	
	
	public function areVConnected(tile0:Tile, tile1:Tile)
	{
		if (!areNeighbors(tile0, tile1))
		{
			return false;
		}
		var cell0 = getTileCell(tile0);
		var cell1 = getTileCell(tile1);
		
		return (cell0.y < cell1.y && tile0.bottom && tile1.top) || (cell1.y < cell0.y && tile1.bottom && tile0.top);
	}
	
	public function areHConnected(tile0:Tile, tile1:Tile)
	{
		
		if (!areNeighbors(tile0, tile1))
		{
			return false;
		}
		var cell0 = getTileCell(tile0);
		var cell1 = getTileCell(tile1);
		var oneWay = (cell0.x < cell1.x) && tile0.right && tile1.left;
		var another = (cell1.x < cell0.x) && tile1.right && tile0.left;
		return oneWay || another;
	}
	
	public function areConnected(tile0:Tile, tile1:Tile)
	{
		return areHConnected(tile0, tile1) || areVConnected(tile0, tile1);
	}
	
	/*
	public function hasLeftNeighbor(tile0:Tile, tile1:Tile)
	{
		return sameRow(otherTile) && u == otherTile.u + 1;
	}
	
	public function hasRightNeighbor(tile0:Tile, tile1:Tile)
	{
		return sameRow(otherTile) && u == otherTile.u - 1;
	}
	*/
	/*
	public function hasTopNeighbor(tile0:Tile, tile1:Tile)
	{
		return sameCol(otherTile) && v == otherTile.v + 1;
	}
	
	public function hasBottomNeighbor(tile0:Tile, tile1:Tile)
	{
		return sameCol(otherTile) && v == otherTile.v - 1;
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