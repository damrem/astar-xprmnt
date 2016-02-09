package factories;
import ash.core.Entity;
import box2D.dynamics.B2BodyType;
import hxlpers.shapes.BoxShape;
import physics.B2;
import physics.PhysicalComponent;
import rendering.EntitySprite;
import rendering.Gfx;

/**
 * ...
 * @author damrem
 */
class WallFactory
{

	public static function createWallEntity(_x:Float, _y:Float, size:Float, color:UInt):Entity
	{
		var entity = new Entity();
		
		var shape = new BoxShape(size, size, color);
		var sprite = new EntitySprite(entity);
		sprite.addChild(shape);
		entity.add(new Gfx(sprite));
		
		var bodyDef = B2.createBodyDef(_x, _y, B2BodyType.STATIC_BODY);
		var fixtureDef = B2.createFixtureDef();
		fixtureDef.filter.categoryBits = CollisionBits.BOUNDARY_CATEGORY;
		fixtureDef.filter.maskBits = CollisionBits.BOUNDARY_MASK;
		trace("boundary", CollisionBits.BOUNDARY_CATEGORY, CollisionBits.BOUNDARY_MASK);
		entity.add(new PhysicalComponent(bodyDef, fixtureDef, B2.createSquareShape(size)));
		
		return entity;
	}
	
	
	
}