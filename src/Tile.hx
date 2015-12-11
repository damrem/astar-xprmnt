package;

import de.polygonal.ai.pathfinding.AStarWaypoint;
import de.polygonal.ds.Graph;
import de.polygonal.ds.GraphNode;
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
	public static inline var SIZE:Float = 50;
	
	public var right:Bool;
	public var bottom:Bool;
	public var left:Bool;
	public var top:Bool;
	
	public var point:AStarWaypoint;
	var openness:Int;
	var bound:openfl.display.Shape;
	public var v:Float;
	public var u:Float;
	public var rightNeighbor:Tile;
	
	public function new(u:Float,v:Float,graph:Graph<AStarWaypoint>) 
	{
		super();
		this.v = v;
		this.u = u;
		
		
		
		point = new AStarWaypoint();
		point.node = new GraphNode<AStarWaypoint>(graph, point);
		graph.addNode(point.node);
		
		point.x = u;
		point.y = v;
		
		x = (u+0.5) * SIZE;
		y = (v+0.5) * SIZE;
		
		do
		{
			openness = Std.random(16);
		}
		while (openness==0||openness == 1 || openness == 2 || openness == 4 || openness == 8);
		
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
		//graphics.beginFill(0xffffff);
		graphics.beginBitmapFill(Assets.getBitmapData("img/stones.jpg"));
		
		dtl();
		dtr();
		dbl();
		dbr();

		if (openness == 0)	dc();
		
		if (!right)		dr();
		if (!bottom)	db();
		if (!left)		dl();
		if (!top)		dt();
		
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
	
	function drawBound()
	{
		bound = new Shape();
		addChild(bound);
		bound.graphics.lineStyle(1, 0x000000);
		bound.graphics.drawRect( -SIZE/2, -SIZE/2, SIZE-1, SIZE-1);
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
		bound.transform.colorTransform = new ColorTransform(1, 1, 1, yes?1:0.25, yes?255:0, yes?255:0, yes?255:0);
	}
	
	public function sameRow(otherTile:Tile)
	{
		return v == otherTile.v;
	}
	
	public function sameCol(otherTile:Tile)
	{
		return u == otherTile.u;
	}
	
	public function hasLeftNeighbor(otherTile:Tile)
	{
		return sameRow(otherTile) && u == otherTile.u + 1;
	}
	
	public function hasRightNeighbor(otherTile:Tile)
	{
		return sameRow(otherTile) && u == otherTile.u - 1;
	}
	
	public function hasTopNeighbor(otherTile:Tile)
	{
		return sameCol(otherTile) && v == otherTile.v + 1;
	}
	
	public function hasBottomNeighbor(otherTile:Tile)
	{
		return sameCol(otherTile) && v == otherTile.v - 1;
	}
	
	public function hasNeighbor(otherTile:Tile)
	{
		return hasBottomNeighbor(otherTile) || hasTopNeighbor(otherTile) || hasRightNeighbor(otherTile) || hasLeftNeighbor(otherTile);
	}
	
	public function hasLeftConnection(otherTile:Tile)
	{
		return hasLeftNeighbor(otherTile) && left && otherTile.right;
	}
	
	public function hasRightConnection(otherTile:Tile)
	{
		return hasRightNeighbor(otherTile) && right && otherTile.left;
	}
	
	public function hasTopConnection(otherTile:Tile)
	{
		return hasTopNeighbor(otherTile) && top && otherTile.bottom;
	}
	
	public function hasBottomConnection(otherTile:Tile)
	{
		return hasBottomNeighbor(otherTile) && bottom && otherTile.top;
	}
	
	public function hasConnection(otherTile:Tile)
	{
		return hasLeftConnection(otherTile) || hasRightConnection(otherTile) || hasTopConnection(otherTile) || hasBottomConnection(otherTile);
	}
	
	function dq(x:Float, y:Float, w:Float, h:Float)
	{
		var s = SIZE / 4;
		graphics.drawRect((x-2) * s, (y-2) * s, w * s, h * s);
	}
	
	override public function toString():String
	{
		return (right?">":"") + (bottom?"v":"") + (left?"<":"") + (top?"^":"");
	}
	
}