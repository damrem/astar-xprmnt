package physics;
import box2D.collision.shapes.B2PolygonShape;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2BodyType;
import box2D.dynamics.B2FixtureDef;
import box2D.dynamics.B2World;

/**
 * ...
 * @author damrem
 */
class B2
{
	public static var world:B2World;
	
	public static function createSquareShape(size:Float, x:Float=0, y:Float=0, angle:Float=0):B2PolygonShape 
	{
		/*var shape = new B2PolygonShape();
		//var halfSize = size / 2;
		shape.setAsOrientedBox(size, size, new B2Vec2(x,y), angle);
		return shape;*/
		return createRectShape(size, size, x, y, angle);
	}
	
	public static function createRectShape(width:Float, height:Float, x:Float=0, y:Float=0, angle:Float=0):B2PolygonShape 
	{
		var shape = new B2PolygonShape();
		//var halfSize = size / 2;
		shape.setAsOrientedBox(width, height, new B2Vec2(x,y), angle);
		return shape;
	}
	
	public static function createBodyDef(x:Float, y:Float, type:B2BodyType=B2BodyType.DYNAMIC_BODY):B2BodyDef
	{
		var bodyDef = new B2BodyDef();
		bodyDef.type = type;
		bodyDef.position.set(x, y);
		return bodyDef;
	}
	
	public static function createFixtureDef(density:Float = 1):B2FixtureDef
	{
		var fixtureDef = new B2FixtureDef();
		fixtureDef.density = density;
		return fixtureDef;
	}
	
}