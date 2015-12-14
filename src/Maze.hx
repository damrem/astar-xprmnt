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
				tiles.set(u, v, new Tile(u, v, graph));
				/*var tile = new Tile(u, v, graph);
				tiles.push(tile);*/
			}
		}
		for (tile in tiles)
		{
			addChild(tile);
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
		trace("moveRowLeft", v);
		var group:Array<Tile> = [];
		var dest:Int;
		
		switch(direction)
		{
			case Right:
				tiles.getRow(v, group);
			case Bottom:
				tiles.getCol(u, group);
			case Left:
				tiles.getRow(v, group);
			case Top:
				tiles.getCol(u, group);
		}
		
		for (tile in group)
		{
			var cell:Array2Cell;	tiles.cellOf(tile, cell);
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
			
			
		
			tile.moveU(coordDest);
			//tile.u--;
			//if (tile.u < 0) tile.u = w - 1;
		}
	}
}