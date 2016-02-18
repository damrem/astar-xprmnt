package factories;

import box2D.dynamics.B2BodyType;
import edge.Entity;
import hxlpers.shapes.BoxShape;
import physics.B2;
import physics.PhysicalShapedComponent;
import rendering.EntitySprite;
import rendering.Gfx;

/**
 * ...
 * @author damrem
 */
class WallFactory
{

	public static function createWallEntity(_x:Float, _y:Float, size:Float, color:UInt):Ent
	{
		var entity = [];
		
		var shape = new BoxShape(size, size, color);
		var sprite = new EntitySprite(entity);
		sprite.addChild(shape);
		entity.push(new Gfx(sprite));
		
		var bodyDef = B2.createBodyDef(_x, _y, B2BodyType.STATIC_BODY);
		var fixtureDef = B2.createFixtureDef();
		fixtureDef.filter.categoryBits = CollisionBits.BOUNDARY_CATEGORY;
		fixtureDef.filter.maskBits = CollisionBits.BOUNDARY_MASK;
		trace("boundary", CollisionBits.BOUNDARY_CATEGORY, CollisionBits.BOUNDARY_MASK);
		entity.push(new PhysicalShapedComponent(bodyDef, fixtureDef, B2.createSquareShape(size)));
		
		return entity;
	}
	
	
	
}