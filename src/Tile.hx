package;

import de.polygonal.ai.pathfinding.AStarWaypoint;
import de.polygonal.ds.Graph;
import de.polygonal.ds.GraphNode;
import openfl.display.Shape;
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
	
	public var point:AStarWaypoint;
	var openness:Int;
	
	public function new(u:Float,v:Float,graph:Graph<AStarWaypoint>) 
	{
		super();
		
		point = new AStarWaypoint();
		point.node = new GraphNode<AStarWaypoint>(graph, point);
		graph.addNode(point.node);
		
		x = point.x = u * SIZE;
		y = point.y = v * SIZE;
		
		openness = Std.random(16);
		trace(openness);
		right = openness & 1 > 0;
		bottom = openness & 2 > 0;
		left = openness & 4 > 0;
		top = openness & 8 > 0;
		draw();
	}
	
	function draw() 
	{
		var thickness = SIZE / 4;
		var far = SIZE * 3 / 4;
		var halfSize = SIZE / 2;
		graphics.clear();
		graphics.beginFill(0xffffff);
		
		dtl();
		dtr();
		dbl();
		dbr();

		if (openness == 0)	dc();
		
		if (!right)		dr();
		if (!bottom)	db();
		if (!left)		dl();
		if (!top)		dt();
		
		bound();
		
		graphics.endFill();
		trace(this, parent, x, y, width, height);
	}
	
	function dl()
	{
		dq(0, 1, 1, 2);
	}
	
	function dt()
	{
		dq(1, 0, 2, 1);
	}
	
	function dr()
	{
		dq(3, 1, 1, 2);
	}
	
	function db()
	{
		dq(1, 3, 2, 1);
	}
	
	function dtl()
	{
		dq(0, 0, 1, 1);
	}
	
	function dtr()
	{
		dq(3, 0, 1, 1);
	}
	
	function dbl()
	{
		dq(0, 3, 1, 1);
	}
	
	function dbr()
	{
		dq(3, 3, 1, 1);
	}
	
	function dc()
	{
		dq(1, 1, 2, 2);
	}
	
	function bound()
	{
		var bound = new Shape();
		addChild(bound);
		bound.graphics.lineStyle(1, 0xff0000);
		bound.graphics.drawRect( 0, 0, SIZE-1, SIZE-1);
		bound.graphics.endFill();
	}
	
	
	
	function dq(x:Float, y:Float, w:Float, h:Float)
	{
		var s = SIZE / 4;
		graphics.drawRect(x * s, y * s, w * s, h * s);
	}
	
	override public function toString():String
	{
		return (right?">":"") + (bottom?"v":"") + (left?"<":"") + (top?"^":"");
	}
	
}