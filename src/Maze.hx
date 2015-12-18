package;

import de.polygonal.ai.pathfinding.AStar;
import de.polygonal.ai.pathfinding.AStarWaypoint;
import de.polygonal.ds.Array2;
import de.polygonal.ds.Graph;
import openfl.display.Sprite;
import openfl.events.MouseEvent;

class Maze extends Sprite
{
	public var tiles:Array2<Tile>;
	var graph:Graph<AStarWaypoint>;
	var astar:AStar;
	var w:Int;
	var h:Int;
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
				tiles.set(u, v, tile);
				/*var tile = new Tile(u, v, graph);
				tiles.push(tile);*/
			}
		}
		
		updateArcs();
	}
	
	public function getNeighborCell(refCell:Array2Cell, direction:Direction):Array2Cell
	{
		var cell = new Array2Cell(refCell.x, refCell.y);
		switch(direction)
		{
			case Right:
				cell.x++;
				
			case Bottom:
				cell.y++;
				
			case Left:
				cell.x--;
				
			case Top:
				cell.y--;
				
		}
		return cell;
	}
	
	public function getNeighbor(tile:Tile, direction:Direction):Tile
	{
		return tiles.getAt(getNeighborCell(getTileCell(tile), direction));
	}
	
	public function move(u:Int, v:Int, direction:Direction)
	{
		trace("move", u, v, direction);
		
		var group:Array<Tile> = [];
		
		var coordPropName;
		var sizePropName:String;
		
		var startIndex;
		var endIndex;
		
		switch(direction)
		{
			case Right:
				coordPropName = "v";
				sizePropName = "w";
				tiles.getRow(v, group);
				startIndex = w - 1;
				endIndex = -1;
				
			case Bottom:
				coordPropName = "u";
				sizePropName = "h";
				tiles.getCol(u, group);
				startIndex = h - 1;
				endIndex = -1;
				
			case Left:
				coordPropName = "v";
				sizePropName = "w";
				tiles.getRow(v, group);
				startIndex = 0;
				endIndex = w;
				
			case Top:
				coordPropName = "u";
				sizePropName = "h";
				tiles.getCol(u, group);
				startIndex = 0;
				endIndex = h;
		}
		trace(startIndex, endIndex);
		
		var size = Reflect.field(this, sizePropName);
		
		for (i in 0 ... size)
		{
			var k = direction == Right || direction == Bottom ? w - 1 - i : i;
			//trace(i);
			var j;
			switch(direction)
			{
				case Right:
					j = k + 1;
					if (j >= size)
					{
						j = 0;
					}
					//trace(k, v, j, v);
					tiles.swap(k, v, j, v);
					
				case Bottom:
					j = k + 1;
					if (j >= size)
					{
						j = 0;
					}
					tiles.swap(u, k, u, j);
					
				case Left:
					j = k - 1;
					if (j <0)
					{
						j = size - 1;
					}
					tiles.swap(k, v, j, v);
					
				case Top:
					j = k - 1;
					if (j <0)
					{
						j = size - 1;
					}
					tiles.swap(u, k, u, j);
			}
			
			
		}
		
		updateArcs();
		var movement=null;
		for (tile in group)
		{
			var cell:Array2Cell=new Array2Cell();	tiles.cellOf(tile, cell);
			/*
			switch(direction)
			{
				case Right:
					cell.x++;
					if (cell.x >= w)	cell.x = 0;
					
				case Bottom:
					cell.y++;
					if (cell.y >= h)	cell.y = 0;
					
				case Left:
					cell.x--;
					if (cell.x < 0)	cell.x = w - 1;
					
				case Top:
					cell.y--;
					if (cell.y < 0)	cell.y = h - 1;
			}
			*/
			
		
			movement=tile.moveTo(cell);
			//tile.u--;
			//if (tile.u < 0) tile.u = w - 1;
		}
		return movement;
	}
	
	function updateArcs()
	{
		for (tile in tiles)
		{
			tile.point.node.removeSingleArcs();
		}
		
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
						}
						
						if (tile1.point.node.getArc(tile0.point.node) == null)
						{
							tile1.point.node.addArc(tile0.point.node);
						}
						
					}
				}
			}
		}
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
		return (tile0.x < tile1.x && tile0.right && tile1.left) || (tile1.x < tile0.x && tile1.right && tile0.left);
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