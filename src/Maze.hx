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
	
	public function new(w:Int, h:Int)
	{
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
				//tiles.assign(Tile, [u, v, graph]);
				var tile = new Tile(graph);
				tile.moveTo(new Array2Cell(u, v), true);
				addChild(tile);
				tile.addEventListener(MouseEvent.MOUSE_OVER, function(e)
				{
					//getNeighbor(tile, Right).alpha = 0.5;
					tile.point.node.removeMutualArcs();
					//drawArcs();
				});
				tile.addEventListener(MouseEvent.MOUSE_OUT, function(e)
				{
					//getNeighbor(tile, Right).alpha = 1;
				});
				tiles.set(u, v, tile);
				/*var tile = new Tile(u, v, graph);
				tiles.push(tile);*/
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
		//graph.clear();
		var cell:Array2Cell = new Array2Cell();
		for (tile in tiles)
		{
			tile.point.node.removeArc();
			tiles.cellOf(tile, cell);
			tile.point.x = cell.x;
			tile.point.y = cell.y;
			
			var right = getNeighbor(tile, Right);
			if(
			
			for (connectedNeighbor in getConnectedNeighbors(tile))
			{
				tile.point.node.addArc(connectedNeighbor.point.node);
				//connectedNeighbor.point.node.addArc(tile.point.node);
				//graph.addMutualArc(tile.point.node, connectedNeighbor.point.node);
			}
			
		}
		
	}
	
	function drawPath()
	{
		var g = pathCanvas.graphics;
		pathCanvas.x = pathCanvas.y = Tile.SIZE / 2;
		pathCanvas.scaleX = pathCanvas.scaleY = Tile.SIZE;
		g.clear();
		g.lineStyle(1, 0xffff00, 1, true, LineScaleMode.NONE);
		for (point in graph)
		{
			trace(point);
			for (connected in point.node)
			{
				g.moveTo(point.x, point.y);
				g.lineTo(connected.x, connected.y);
				trace(point, connected);
			}
			trace('========');
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
		if (right!=null&&areConnected(tile, right))
		{
			tiles.push(right);
		}
		var bottom = getNeighbor(tile, Bottom);
		if (bottom!=null&&areConnected(tile, bottom))
		{
			tiles.push(bottom);
		}
		var left = getNeighbor(tile, Left);
		if (left!=null&&areConnected(tile, left))
		{
			tiles.push(left);
		}
		var top = getNeighbor(tile, Top);
		if (top!=null&&areConnected(tile, top))
		{
			tiles.push(top);
		}
		return tiles;
	}
	
	public function move(x:Int, y:Int, direction:Direction)
	{
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
		
		//updateArcs();
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
	
	function drawArcs()
	{
		var g = pathCanvas.graphics;
		g.clear();
		g.lineStyle(1, 0xffff00, 1, true, LineScaleMode.NONE);
		
		for (point in graph)
		{
			trace(point);
			var arc = point.node.arcList;
			trace(arc);
			while (arc != null)
			{
				g.moveTo(point.x, point.y);
				g.lineTo(arc.node.val.x, arc.node.val.y);
				arc = arc.next;
			}
		}
	}
	
	function updateArcs()
	{
		for (tile in tiles)
		{	
			tile.point.node.removeMutualArcs();
			
			var tileRight = getNeighbor(tile, Right);
			
			if (tileRight != null && tileRight.left && tile.right)
			{
				graph.addMutualArc(tile.point.node, tileRight.point.node);
			}

			
		}
		
		/*
		for (tile0 in tiles)
		{
			for (tile1 in tiles)
			{
				if (tile0 != tile1)
				{
					if (areConnected(tile0, tile1))
					{
						if (tile0.point.node.getArc(tile1.point.node) == null)
						{
							tile0.point.node.addArc(tile1.point.node);
							if (draw)
							{
								g.moveTo(tile0.x, tile0.y);
								g.lineTo(tile1.x, tile1.y);
							}
						}
						
						if (tile1.point.node.getArc(tile0.point.node) == null)
						{
							tile1.point.node.addArc(tile0.point.node);
							if (draw)
							{
								g.moveTo(tile0.x, tile0.y);
								g.lineTo(tile1.x, tile1.y);
							}
						}
						
					}
				}
			}
		}
		*/
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
		return (tile0.y < tile1.y && tile0.bottom && tile1.top) || (tile1.y < tile0.y && tile1.bottom && tile0.top);
	}
	
	public function areHConnected(tile0:Tile, tile1:Tile)
	{
		if (!areNeighbors(tile0, tile1))
		{
			return false;
		}
		var oneWay = tile0.x < tile1.x && tile0.right && tile1.left;
		var another = tile1.x < tile0.x && tile1.right && tile0.left;
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