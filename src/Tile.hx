package;

import de.polygonal.ai.pathfinding.AStarWaypoint;
import de.polygonal.ds.Graph;
import de.polygonal.ds.GraphNode;
import openfl.display.Sprite;

/**
 * ...
 * @author damrem
 */
class Tile extends Sprite
{
	public static inline var SIZE:Float = 50;
	
	public var right:Bool;
	public var bottom:Bool;
	public var left:Bool;
	public var top:Bool;
	
	var point:AStarWaypoint;
	
	public function new(u:Float,v:Float,graph:Graph<AStarWaypoint>) 
	{
		super();
		
		point = new AStarWaypoint();
		point.node = new GraphNode<AStarWaypoint>(graph, point);
		graph.addNode(point.node);
		
		x = point.x = u * SIZE;
		y = point.y = v * SIZE;
		
		var openBits = Std.random(16);
		trace(openBits);
		right = openBits & 1 > 0;
		bottom = openBits & 2 > 0;
		left = openBits & 4 > 0;
		top = openBits & 8 > 0;
		draw();
	}
	
	function draw() 
	{
		var thickness = SIZE / 4;
		var far = SIZE * 3 / 4;
		var halfSize = SIZE / 2;
		graphics.clear();
		graphics.beginFill(0xffffff);
		if (right)
		{
			graphics.beginFill(0xffff00, 0.5);
			trace( -halfSize+far, -halfSize, thickness, SIZE);
			graphics.drawRect(-halfSize+far, -halfSize, thickness, SIZE);
		}
		if (bottom)
		{
			graphics.beginFill(0xff00ff,0.5);
			graphics.drawRect(-halfSize, -halfSize+far, SIZE, thickness);
		}
		if (left)
		{
			graphics.beginFill(0x00ffff,0.5);
			graphics.drawRect(-halfSize, -halfSize, thickness, SIZE);
		}
		if (top)
		{
			graphics.beginFill(0xf0f0f0,0.5);
			graphics.drawRect(-halfSize, -halfSize, SIZE, thickness);
		}
		graphics.endFill();
		trace(this, parent, x, y, width, height);
	}
	
	override public function toString():String
	{
		return (right?">":"") + (bottom?"v":"") + (left?"<":"") + (top?"^":"");
	}
	
}