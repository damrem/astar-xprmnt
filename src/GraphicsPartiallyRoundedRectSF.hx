package;
import openfl.display.Graphics;
import openfl.geom.Point;

/**
 * ...
 * @author damrem
 */
/*
class GraphicsPartiallyRoundedRectSF
{

	public static function drawRoundRectComplex(user:Graphics, x:Float, y:Float, width:Float, height:Float, topLeftRadius:Float, topRightRadius:Float, bottomLeftRadius:Float, bottomRightRadius:Float, ?granularity:UInt) 
	{
		
		var initialPoint:Point = new Point();
		if (topLeftRadius > 0)
		{
			var arc = new Arc(topLeftRadius, topLeftRadius, topLeftRadius, Math.PI, - Math.PI / 2, Std.int(topLeftRadius));
			for (point in arc)
			{
				if (point == arc.get(0))
				{
					initialPoint = point;
					user.moveTo(point.x, point.y);
					continue;
				}
				user.lineTo(point.x, point.y);
			}
		}
		else
		{
			user.moveTo(0, 0);
		}
		
		if (topRightRadius > 0)
		{
			var arc = new Arc(width - topRightRadius, topRightRadius, topRightRadius, Math.PI/2, - Math.PI / 2, Std.int(topRightRadius));
			for (point in arc)
			{
				user.lineTo(point.x, point.y);
			}
		}
		else
		{
			user.moveTo(width, 0);
		}
		
		if (bottomRightRadius > 0)
		{
			var arc = new Arc(width - bottomRightRadius, height - bottomRightRadius, bottomRightRadius, 0, - Math.PI / 2, Std.int(bottomRightRadius));
			for (point in arc)
			{
				user.lineTo(point.x, point.y);
			}
		}
		else
		{
			user.moveTo(width, height);
		}
		
		if (bottomLeftRadius > 0)
		{
			var arc = new Arc(bottomLeftRadius, height - bottomLeftRadius, bottomLeftRadius, - Math.PI / 2, - Math.PI / 2, Std.int(bottomLeftRadius));
			for (point in arc)
			{
				user.lineTo(point.x, point.y);
			}
		}
		else
		{
			user.moveTo(width, height);
		}
		
		user.lineTo(initialPoint.x, initialPoint.y);
	}
	
	
	
}*/