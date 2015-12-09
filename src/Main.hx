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
	
	var selectedP0:AStarWaypoint;
	var selectedSpr0:Sprite;
	
	var selectedP1:AStarWaypoint;
	var selectedSpr1:Sprite;
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
				trace(tile);
				addChild(tile);
				trace(tile.parent);
				
				/*
				var spr = new Sprite();
				spr.graphics.beginFill(0xffff0000);
				spr.graphics.drawCircle(0, 0, 4);
				spr.graphics.endFill();
				spr.x = p.x;
				spr.y = p.y;
				addChild(spr);
				
				
				spr.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent)
				{
					select(spr, p);
				});
				*/
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
	
	function select(spr:Sprite, p:AStarWaypoint)
	{
		for (i in 0...numChildren)
		{
			getChildAt(i).alpha = 1;
		}
		
		selectedSpr0 = selectedSpr1;
		selectedSpr1 = spr;
		if (selectedSpr1 != null)
		{
			selectedSpr1.alpha = 0.5;
		}
		if (selectedSpr0 != null)
		{
			selectedSpr0.alpha = 0.5;
		}

		selectedP0 = selectedP1;
		selectedP1 = p;
		
		pathCanvas.graphics.clear();
		pathCanvas.graphics.lineStyle(5, 0xffffff00);
		
		var path = new DA<AStarWaypoint>();
		
		if (selectedP0 != null && selectedP1 != null)
		{
			//astar.find(graph, se
			if (astar.find(graph, selectedP0, selectedP1, path))
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
