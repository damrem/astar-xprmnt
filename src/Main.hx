package;

import de.polygonal.ai.pathfinding.AStar;
import de.polygonal.ai.pathfinding.AStarWaypoint;
import de.polygonal.ds.DA;
import de.polygonal.ds.Graph;
import de.polygonal.ds.GraphNode;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.Lib;

/**
 * ...
 * @author damrem
 */
class Main extends Sprite 
{
	static public inline var THRESHOLD:Float = 50;
	
	var selectedTile0:Tile;
	var selectedTile1:Tile;
	
	var astar:AStar;
	var graph:Graph<AStarWaypoint>;
	
	var pathCanvas:Shape;
	var tiles:Array<Tile>;

	public function new() 
	{
		super();
		
		// Assets:
		// openfl.Assets.getBitmapData("img/assetname.jpg");
		
		graph = new Graph<AStarWaypoint>();
		
		tiles = [];
		var tileCanvas = new Sprite();
		addChild(tileCanvas);
		
		pathCanvas = new Shape();
		addChild(pathCanvas);
		
		var maxU = Std.int(Lib.current.stage.stageWidth / 50);
		var maxV = Std.int(Lib.current.stage.stageHeight / 50);
		
		for(u in 0 ... maxU)
		{
			for (v in 0 ... maxV)
			{
				var tile = new Tile(u, v, graph);
				tiles.push(tile);
				tileCanvas.addChild(tile);
				
				tile.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent)
				{
					select(tile);
				});
				
			}
		}
		
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
				
		
				
			
		/*
		for (po in graph)
		{
			for (pt in graph)
			{
				if (po != pt)
				{
					if (po.distanceTo(pt) <= THRESHOLD)
					{
						po.node.addArc(pt.node);
						arcsHolder.graphics.moveTo(po.x, po.y);
						arcsHolder.graphics.lineTo(pt.x, pt.y);
					}
				}
			}
		}
		*/
		
		astar = new AStar(graph);
		
	}
	
	function select(tile:Tile)
	{
		for (anyTile in tiles)
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

}
