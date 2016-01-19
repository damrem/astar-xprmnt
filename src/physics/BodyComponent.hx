package physics;

import box2D.dynamics.B2Body;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2FixtureDef;

/**
 * ...
 * @author damrem
 */
class BodyComponent
{
	public var bodyDef:B2BodyDef;
	public var fixtureDef:B2FixtureDef;
	public var b2body:B2Body;
	
	public function new(bodyDef:B2BodyDef, fixtureDef:B2FixtureDef) 
	{
		this.bodyDef = bodyDef;
		this.fixtureDef = fixtureDef;
	}
	
}