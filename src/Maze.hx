package;

import de.polygonal.ai.pathfinding.AStar;
import de.polygonal.ai.pathfinding.AStarWaypoint;
import de.polygonal.ds.Graph;
import openfl.display.Sprite;
import openfl.events.MouseEvent;

class Maze extends Sprite
{
	public var tiles:Array<Tile>;
	var graph:Graph<AStarWaypoint>;
	var astar:AStar;
	public function new(w:UInt, h:UInt)
	{
		super();
		
		tiles = [];
		graph = new Graph<AStarWaypoint>();
		astar = new AStar(graph);
		
		for (v in 0...h)
		{
			for(u in 0...w)
			{
				var tile = new Tile(u, v, graph);
				tiles.push(tile);
				addChild(tile);
				/*
				tile.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent)
					{
						select(tile);
					}
				);
				*/
			}
		}
	}
}