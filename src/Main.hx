package;

import de.polygonal.ai.pathfinding.AStar;
import de.polygonal.ai.pathfinding.AStarWaypoint;
import de.polygonal.ds.DA;
import de.polygonal.ds.Graph;
import de.polygonal.ds.GraphNode;
import motion.Actuate;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.events.KeyboardEvent;
import openfl.events.MouseEvent;
import openfl.Lib;

/**
 * ...
 * @author damrem
 */
class Main extends Sprite 
{
	
	var selectedTile0:Tile;
	var selectedTile1:Tile;
	
	var astar:AStar;
	var graph:Graph<AStarWaypoint>;
	
	var pathCanvas:Shape;
	var tiles:Array<Tile>;
	
	var hero:Hero;
	var heroIsMoving:Bool;

	public function new() 
	{
		super();
		
		// Assets:
		// openfl.Assets.getBitmapData("img/assetname.jpg");
		
		graph = new Graph<AStarWaypoint>();
		astar = new AStar(graph);
		
		tiles = [];
		var tileCanvas = new Sprite();
		addChild(tileCanvas);
		
		var maxV = Std.int(Lib.current.stage.stageHeight / Tile.SIZE);
		var maxU = maxV;//Std.int(Lib.current.stage.stageWidth / Tile.SIZE);
		
		for (v in 0 ... maxV)
		{
			for(u in 0 ... maxU)
			{
				var tile = new Tile(u, v, graph);
				tiles.push(tile);
				tileCanvas.addChild(tile);
				
				tile.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent)
					{
						select(tile);
					}
				);
				
			}
		}
		
		for (v in 0 ... maxV)
		{
			for (u in 0 ... maxU)
			{
				tiles[v * maxU + u].rightNeighbor = tiles[v * maxU + u + 1];
				tiles[v * maxU + u].bottomNeighbor = tiles[v * maxU + u + maxU];
				trace(tiles[16]);
				trace(Type.typeof(16));
				trace(Type.typeof(v * maxU + u + maxU));
				tiles[v * maxU + u].leftNeighbor = tiles[v * maxU + u - 1];
				tiles[v * maxU + u].topNeighbor = tiles[v * maxU + u - maxU];
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
				
		pathCanvas = new Shape();
		addChild(pathCanvas);
		
		hero = new Hero();
		addChild(hero);
		hero.moveToTile(tiles[0]);
		trace(hero.currentTile);
		
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		
		
	}
	
	private function onKeyDown(e:KeyboardEvent):Void 
	{
		trace(e);
		
		if (!hero.isMoving)
		{
			var destTile:Tile=null;
			switch(e.keyCode)
			{
				case 37:
					destTile = hero.currentTile.leftNeighbor;
					
				case 38:
					destTile = hero.currentTile.topNeighbor;
					
				case 39:
					destTile = hero.currentTile.rightNeighbor;
					
					
				case 40:
					destTile = hero.currentTile.bottomNeighbor;
					
			}
			
			if (destTile != null && hero.currentTile.point.node.getArc(destTile.point.node)!=null)
			{
				hero.moveToTile(destTile);
			}
		}
		/*
		37 left
		38 top
		39 right
		40 bottom
		*/
	}
	
	//function moveHeroToTile
	
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
