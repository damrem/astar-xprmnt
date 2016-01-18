package;
import ash.core.Entity;
import box2D.collision.shapes.B2CircleShape;
import box2D.collision.shapes.B2PolygonShape;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2BodyType;
import box2D.dynamics.B2FixtureDef;
import box2D.dynamics.B2World;
import physics.Phy;
import rendering.EntitySprite;
import rendering.Gfx;
import hxlpers.shapes.BoxShape;
import hxlpers.shapes.DiskShape;

/**
 * ...
 * @author damrem
 */
class EntityCreator
{
	var world:B2World;

	public function new(world:B2World) 
	{
		this.world = world;
		
	}
	
	public function createBallEntity(_x:Float, _y:Float, size:Float, angle:Float, color:UInt):Entity
	{
		trace("ball");
		var radius = size / 2;
		
		var entity = new Entity();
		
		var shape = new DiskShape(radius, color);
		var sprite = new EntitySprite(entity);
		sprite.addChild(shape);
		entity.add(new Gfx(sprite));
		
		var bodyDef = createBodyDef(_x, _y);
		var fixtureDef = createFixtureDef();
		fixtureDef.shape = new B2CircleShape(radius);
		entity.add(new Phy(bodyDef, fixtureDef, world));
		
		return entity;
	}
	
	public function createBoxEntity(_x:Float, _y:Float, size:Float, angle:Float, color:UInt):Entity
	{
		trace("box");
		var entity = new Entity();
		
		var shape = new BoxShape(size, size, color, 0, 0, true);
		var sprite = new EntitySprite(entity);
		sprite.addChild(shape);
		entity.add(new Gfx(sprite));
		
		var bodyDef = createBodyDef(_x, _y);
		var fixtureDef = createFixtureDef();
		fixtureDef.shape = createBoxShape(size/2, angle);
		entity.add(new Phy(bodyDef, fixtureDef, world));
		
		return entity;
	}
	
	public function createWallEntity(_x:Float, _y:Float, size:Float, color:UInt):Entity
	{
		trace("wall");
		var entity = new Entity();
		
		var shape = new BoxShape(size, size, color);
		var sprite = new EntitySprite(entity);
		sprite.addChild(shape);
		entity.add(new Gfx(sprite));
		
		var bodyDef = createBodyDef(_x, _y, B2BodyType.STATIC_BODY);
		var fixtureDef = createFixtureDef();
		fixtureDef.shape = createBoxShape(size);
		entity.add(new Phy(bodyDef, fixtureDef, world));
		
		return entity;
	}
	
	function createBoxShape(size:Float, angle:Float=0):B2PolygonShape 
	{
		var shape = new B2PolygonShape();
		var halfSize = size / 2;
		shape.setAsBox(size, size);
		return shape;
	}
	
	function createBodyDef(_x:Float, _y:Float, bodyType:B2BodyType=B2BodyType.DYNAMIC_BODY):B2BodyDef
	{
		var bodyDef = new B2BodyDef();
		bodyDef.type = bodyType;
		bodyDef.position.set(_x, _y);
		return bodyDef;
	}
	
	function createFixtureDef(density:Float = 1):B2FixtureDef
	{
		var fixtureDef = new B2FixtureDef();
		fixtureDef.density = density;
		return fixtureDef;
	}
	
	
	
}