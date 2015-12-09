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

	public function new() 
	{
		super();
		
		// Assets:
		// openfl.Assets.getBitmapData("img/assetname.jpg");
		
		graph = new Graph<AStarWaypoint>();
		
		var arcsHolder = new Sprite();
		addChild(arcsHolder);
		arcsHolder.graphics.lineStyle(1, 0xffff0000);
		
		pathCanvas = new Shape();
		addChild(pathCanvas);
		
		var maxU = Std.int(Lib.current.stage.stageWidth / 50);
		var maxV = Std.int(Lib.current.stage.stageHeight / 50);
		
		for(u in 0 ... maxU)
		{
			for (v in 0 ... maxV)
			{
				var tile = new Tile(u, v, graph);
				addChild(tile);
				
				tile.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent)
				{
					select(tile);
				});
				
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
		for (i in 0...numChildren)
		{
			getChildAt(i).alpha = 1;
		}
		
		selectedTile0 = selectedTile1;
		selectedTile1 = tile;
		if (selectedTile1 != null)
		{
			selectedTile1.alpha = 0.5;
		}
		if (selectedTile0 != null)
		{
			selectedTile0.alpha = 0.5;
		}

		pathCanvas.graphics.clear();
		pathCanvas.graphics.lineStyle(5, 0xffffff00);
		
		var path = new DA<AStarWaypoint>();
		
		if (selectedTile0 != null && selectedTile1 != null)
		{
			//astar.find(graph, se
			if (astar.find(graph, selectedTile0.point, selectedTile1.point, path))
			{
				pathCanvas.graphics.moveTo(path.get(0).x, path.get(0).y);
				for (p in path) {
					trace(p);
					pathCanvas.graphics.lineTo(p.x, p.y);
					trace(pathCanvas.x, pathCanvas.y, pathCanvas.width, pathCanvas.height, pathCanvas.parent);
				}
			}
			
		}
	}

}
