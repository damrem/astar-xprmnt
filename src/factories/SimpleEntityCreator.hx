package factories;
import ash.core.Entity;
import box2D.collision.shapes.B2CircleShape;
import hxlpers.shapes.BoxShape;
import hxlpers.shapes.DiskShape;
import physics.B2;
import physics.PhysicalComponent;
import physics.PhysicalShapedComponent;
import rendering.EntitySprite;
import rendering.Gfx;

/**
 * ...
 * @author damrem
 */
class SimpleEntityCreator
{
	public static function createBallEntity(_x:Float, _y:Float, size:Float, angle:Float, color:UInt, collisionCategory:Int=0x0001, collisionMask:Int=0xffff):Entity
	{
		var radius = size / 2;
		
		var entity = new Entity();
		
		var shape = new DiskShape(radius, color);
		var sprite = new EntitySprite(entity);
		sprite.addChild(shape);
		entity.add(new Gfx(sprite));
		
		var bodyDef = B2.createBodyDef(_x, _y);
		bodyDef.linearDamping = 25;
		var fixtureDef = B2.createFixtureDef();
		fixtureDef.filter.categoryBits = collisionCategory;
		fixtureDef.filter.maskBits = collisionMask;
		entity.add(new PhysicalShapedComponent(bodyDef, fixtureDef, new B2CircleShape(radius)));
		
		return entity;
	}
	
	public static function createBoxEntity(_x:Float, _y:Float, size:Float, angle:Float, color:UInt, collisionCategory:Int=0x0001, collisionMask:Int=0xffff):Entity
	{
		var entity = new Entity();
		
		var shape = new BoxShape(size, size, color, 0, 0, true);
		var sprite = new EntitySprite(entity);
		sprite.addChild(shape);
		entity.add(new Gfx(sprite));
		
		var bodyDef = B2.createBodyDef(_x, _y);
		var fixtureDef = B2.createFixtureDef();
		fixtureDef.filter.categoryBits = collisionCategory;
		fixtureDef.filter.maskBits = collisionMask;
		entity.add(new PhysicalShapedComponent(bodyDef, fixtureDef, B2.createSquareShape(size / 2, angle)));
		
		return entity;
	}
	/*
	public function createMultiboxEntity(x:Float, y:Float):Entity
	{
		var bodyDef = createBodyDef(x, y);
		var fixtureDef = createFixtureDef();
		
	}
	*/
	
	
	
	
}