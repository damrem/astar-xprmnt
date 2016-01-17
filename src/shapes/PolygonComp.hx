package shapes;

import openfl.geom.Point;

/**
 * ...
 * @author damrem
 */
class PolygonComp
{

	public var vertices:Array<Point>;
	
	public function new(?vertices:Array<Point>)
	{
		this.vertices = vertices == null ? [] : vertices;
	}
	
}