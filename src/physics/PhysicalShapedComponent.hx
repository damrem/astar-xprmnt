package physics;

import box2D.collision.shapes.B2Shape;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2FixtureDef;
import edge.IComponent;

/**
 * ...
 * @author damrem
 */
class PhysicalShapedComponent implements IComponent
{
	public var bodyDef:B2BodyDef;
	public var fixtureDef:B2FixtureDef;
	public var body:B2Body;
	
	public function new(bodyDef:B2BodyDef, fixtureDef:B2FixtureDef, shape:B2Shape) 
	{
		this.bodyDef = bodyDef;
		this.fixtureDef = fixtureDef;
		this.fixtureDef.shape = shape;
		
	}
	
}