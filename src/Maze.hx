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
		
		
	}
	
	public function getNeighbor(tile:Tile, direction:Direction)
	{
		var cell:Array2Cell = new Array2Cell();
		tiles.cellOf(tile, cell);
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
		return tiles.getAt(cell);
	}
	
	/*
	public function getRow(v:UInt)
	{
		var row:Array<Tile> = [];
		for (i in v * w...(v + 1) * w)
		{
			row.push(tiles[i]);
		}
		return row;
	}
	*/
	
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
			trace(i);
			var j;
			switch(direction)
			{
				case Right:
					j = k + 1;
					if (j >= size)
					{
						j = 0;
					}
					trace(k, v, j, v);
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
			
		
			tile.moveTo(cell);
			//tile.u--;
			//if (tile.u < 0) tile.u = w - 1;
		}
	}
}