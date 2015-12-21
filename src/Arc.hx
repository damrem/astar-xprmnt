package;



import hxmath.math.Vector2;
import openfl.geom.Point;

/**
 * ...
 * @author damrem
 */
class Arc
{
	var points:Array<Point>;
	var center:Point;
	
	public function new(xCenter:Float, yCenter:Float, radius:Float, angleStart:Float, angleOffset:Float, granularity:UInt) 
	{
		center = new Point(xCenter, yCenter);
		points = new Array<Point>();
		
		var interAngle = - angleOffset / granularity;
		var currentAngle = angleStart;
		
		for (i in 0 ... granularity+1)
		{
			var v = Vector2.fromPolar(currentAngle, radius);
			v = Vector2.add(v, new Vector2(xCenter, yCenter));
			points.push(new Point(v.x, v.y));
			currentAngle += interAngle;
		}
	}
	
	public function iterator()
	{
		return points.iterator();
	}
	
	public function get(i:UInt)
	{
		return points[i];
	}
	
	
	
}