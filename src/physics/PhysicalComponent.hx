package physics;

import box2D.collision.shapes.B2EdgeShape;
import box2D.collision.shapes.B2Shape;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2FixtureDef;

/**
 * ...
 * @author damrem
 */
class PhysicalComponent
{
	public var shape:B2Shape;
	public var bodyDef:B2BodyDef;
	public var fixtureDef:B2FixtureDef;
	public var body:B2Body;
	
	public function new(bodyDef:B2BodyDef, fixtureDef:B2FixtureDef, shape:B2Shape) 
	{
		this.shape = shape;
		this.bodyDef = bodyDef;
		this.fixtureDef = fixtureDef;
		this.fixtureDef.shape = shape;
	}
	
}