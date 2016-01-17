package entities.physics;

import box2D.dynamics.B2Body;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2FixtureDef;
import box2D.dynamics.B2World;

/**
 * ...
 * @author damrem
 */
class Phy
{
	public var bodyDef:B2BodyDef;
	public var fixtureDef:B2FixtureDef;
	public var body:B2Body;
	
	public function new(bodyDef:B2BodyDef, fixtureDef:B2FixtureDef, world:B2World) 
	{
		this.bodyDef = bodyDef;
		this.fixtureDef = fixtureDef;
		//body = world.createBody(bodyDef);
		//body.createFixture(fixtureDef);
	}
	
}