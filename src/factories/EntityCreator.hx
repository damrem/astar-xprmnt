package factories;
import ash.core.Entity;
import box2D.collision.shapes.B2CircleShape;
import hxlpers.shapes.BoxShape;
import hxlpers.shapes.DiskShape;
import physics.B2;
import physics.BodyComponent;
import rendering.EntitySprite;
import rendering.Gfx;

/**
 * ...
 * @author damrem
 */
class EntityCreator
{
	public function new() 
	{
	}
	
	public static function createBallEntity(_x:Float, _y:Float, size:Float, angle:Float, color:UInt):Entity
	{
		var radius = size / 2;
		
		var entity = new Entity();
		
		var shape = new DiskShape(radius, color);
		var sprite = new EntitySprite(entity);
		sprite.addChild(shape);
		entity.add(new Gfx(sprite));
		
		var bodyDef = B2.createBodyDef(_x, _y);
		var fixtureDef = B2.createFixtureDef();
		fixtureDef.shape = new B2CircleShape(radius);
		entity.add(new BodyComponent(bodyDef, fixtureDef));
		
		return entity;
	}
	
	public static function createBoxEntity(_x:Float, _y:Float, size:Float, angle:Float, color:UInt):Entity
	{
		var entity = new Entity();
		
		var shape = new BoxShape(size, size, color, 0, 0, true);
		var sprite = new EntitySprite(entity);
		sprite.addChild(shape);
		entity.add(new Gfx(sprite));
		
		var bodyDef = B2.createBodyDef(_x, _y);
		var fixtureDef = B2.createFixtureDef();
		fixtureDef.shape = B2.createBoxShape(size/2, angle);
		entity.add(new BodyComponent(bodyDef, fixtureDef));
		
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