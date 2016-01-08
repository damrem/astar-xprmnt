package;

import de.polygonal.ai.pathfinding.AStarWaypoint;
import de.polygonal.ds.Array2.Array2Cell;
import de.polygonal.ds.Graph;
import de.polygonal.ds.GraphNode;
import motion.Actuate;
import motion.easing.Linear;
import openfl.Assets;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.geom.ColorTransform;
/**
 * ...
 * @author damrem
 */
class Tile extends Sprite
{
	public static inline var SIZE:Float = 32;
	
	public var right:Bool;
	public var bottom:Bool;
	public var left:Bool;
	public var top:Bool;
	
	public var point:AStarWaypoint;
	var openness:Int;
	var bound:openfl.display.Shape;
	//public var v:Int;
	//public var u:Int;
	public var rightNeighbor:Tile;
	public var bottomNeighbor:Tile;
	public var leftNeighbor:Tile;
	public var topNeighbor:Tile;
	
	public function new(graph:Graph<AStarWaypoint>) 
	{
		super();
		//this.v = v;
		//this.u = u;
		
		
		
		point = new AStarWaypoint();
		point.node = new GraphNode<AStarWaypoint>(graph, point);
		graph.addNode(point.node);
		
		//point.x = u;
		//point.y = v;
		
		//x = (u+0.5) * SIZE;
		//y = (v+0.5) * SIZE;
		
		do
		{
			openness = Std.random(16);
		}
		while (openness==0||openness == 1 || openness == 2 || openness == 4 || openness == 8);
		
		right = openness & 1 > 0;
		bottom = openness & 2 > 0;
		left = openness & 4 > 0;
		top = openness & 8 > 0;
		
		right = false;
		bottom = false;
		left = true;
		top = true;
		
		draw();
	}
	
	function draw() 
	{
		var thickness = SIZE / 4;
		var far = SIZE * 3 / 4;
		var halfSize = SIZE / 2;
		graphics.clear();
		//graphics.beginFill(0xffffff);
		graphics.beginBitmapFill(Assets.getBitmapData("img/stones.jpg"));
		
		dtl(top && left);
		dtr(top && right);
		dbl(bottom && left);
		dbr(bottom && right);
		
		

		if (openness == 0)	dc();
		
		if (!right)
		{
			dr();
		}
		if (!bottom)
		{
			db();
		}
		if (!left)
		{
			dl();
		}
		if (!top)
		{
			dt();
		}
		
		drawBound();
		drawZone();
		select(false);
		
		graphics.endFill();
		
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
	
	function dtl(rounded:Bool=true)
	{
		dCorner(0, 0, 1, 1, rounded);
	}
	
	function dtr(rounded:Bool=true)
	{
		dCorner(3, 0, 1, 1, rounded);
	}
	
	function dbl(rounded:Bool=true)
	{
		dCorner(0, 3, 1, 1, rounded);
	}
	
	function dbr(rounded:Bool=true)
	{
		dCorner(3, 3, 1, 1, rounded);
	}
	
	function dc()
	{
		dq(1, 1, 2, 2);
	}
	
	function drawBound()
	{
		bound = new Shape();
		addChild(bound);
		bound.graphics.lineStyle(1, 0x000000);
		bound.graphics.drawRect( -SIZE/2, -SIZE/2, SIZE, SIZE);
		bound.graphics.endFill();
	}
	
	function drawZone()
	{
		var zone = new Shape();
		addChild(zone);
		zone.graphics.beginFill(0, 0);
		zone.graphics.drawRect( -SIZE / 2, -SIZE / 2, SIZE, SIZE);
		zone.graphics.endFill();
	}
	
	public function select(yes:Bool=true)
	{
		bound.transform.colorTransform = new ColorTransform(1, 1, 1, 1, yes?255:0, yes?255:0, yes?255:0);
	}
	
	
	function dq(x:Float, y:Float, w:Float, h:Float)
	{
		var s = SIZE / 4;
		graphics.drawRect((x-2) * s, (y-2) * s, w * s, h * s);
	}
	
	
	
	function dCorner(x:Float, y:Float, w:Float, h:Float,rounded:Bool=false)
	{
		var s = SIZE / 4;
		var r = s / 2;
		var rtl:Float = 0;
		var rtr:Float = 0;
		var rbr:Float = 0;
		var rbl:Float = 0;
		if (rounded)
		{
			if (x == 0 && y == 0) rbr = r;
			else if	(x == 3 && y == 0) rbl = r;
			else if	(x == 3 && y == 3) rtl = r;
			else if	(x == 0 && y == 3) rtr = r;
		}
		else
		{
			var xOrigin:Float = 0;
			var yOrigin:Float = 0;
			var xCenter:Float = 0;
			var yCenter:Float = 0;
			var angleStart:Float = 0;
			
			if (x == 0 && y == 0) 
			{
				xOrigin = -s;
				yOrigin = -s;
				angleStart = -Math.PI / 2;

				graphics.moveTo(xOrigin, yOrigin);
				var arc = new Arc(xCenter, yCenter, s, angleStart, Math.PI / 2, Std.int(s));
				for (p in arc)
				{
					graphics.lineTo(p.x, p.y);
				}
				graphics.lineTo(xOrigin, yOrigin);
			}
			else if	(x == 3 && y == 0) 
			{
				xOrigin = s;
				yOrigin = -s;
				angleStart = 0*Math.PI / 2;
				
				graphics.moveTo(xOrigin, yOrigin);
				var arc = new Arc(xCenter, yCenter, s, angleStart, Math.PI / 2, Std.int(s));
				for (p in arc)
				{
					graphics.lineTo(p.x, p.y);
				}
				graphics.lineTo(xOrigin, yOrigin);
			}
			else if	(x == 3 && y == 3) 
			{
				xOrigin = s;
				yOrigin = s;
				angleStart = 1*Math.PI / 2;
				
				graphics.moveTo(xOrigin, yOrigin);
				var arc = new Arc(xCenter, yCenter, s, angleStart, Math.PI / 2, Std.int(s));
				for (p in arc)
				{
					graphics.lineTo(p.x, p.y);
				}
				graphics.lineTo(xOrigin, yOrigin);
			}
			else if	(x == 0 && y == 3) 
			{
				xOrigin = s;
				yOrigin = s;
				xCenter = 3 * s;
				yCenter = 3 * s;
				angleStart = Math.PI / 2;
			}
			
			
		}
		graphics.drawRoundRectComplex((x - 2) * s, (y - 2) * s, w * s, h * s, rtl, rtr, rbl, rbr);
	}
	
	public function moveTo(cell:Array2Cell, isInit:Bool=false)
	{
		var duration = isInit?0:0.5;
		return Actuate.tween(this, duration, {
			x:(cell.x + 0.5) * SIZE,
			y:(cell.y + 0.5) * SIZE
		})
		.ease(Linear.easeNone);
	}
	
	override public function toString():String
	{
		return (right?">":"") + (bottom?"v":"") + (left?"<":"") + (top?"^":"");
	}
	
}