package physics;
import box2D.collision.shapes.B2PolygonShape;
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
	
	public static function createBoxShape(size:Float, angle:Float=0):B2PolygonShape 
	{
		var shape = new B2PolygonShape();
		var halfSize = size / 2;
		shape.setAsBox(size, size);
		return shape;
	}
	
	public static function createBodyDef(_x:Float, _y:Float, bodyType:B2BodyType=B2BodyType.DYNAMIC_BODY):B2BodyDef
	{
		var bodyDef = new B2BodyDef();
		bodyDef.type = bodyType;
		bodyDef.position.set(_x, _y);
		return bodyDef;
	}
	
	public static function createFixtureDef(density:Float = 1):B2FixtureDef
	{
		var fixtureDef = new B2FixtureDef();
		fixtureDef.density = density;
		return fixtureDef;
	}
	
}