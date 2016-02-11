package physics;

import box2D.collision.shapes.B2Shape;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2FixtureDef;

/**
 * ...
 * @author damrem
 */
class PhysicalShapedComponent extends PhysicalComponent
{
	public function new(bodyDef:B2BodyDef, fixtureDef:B2FixtureDef, shape:B2Shape) 
	{
		super(bodyDef, fixtureDef);
		this.fixtureDef.shape = shape;
	}
	
}