package physics;

import ash.core.System;
import box2D.dynamics.B2DebugDraw;
import openfl.display.DisplayObjectContainer;
import openfl.display.Sprite;

/**
 * ...
 * @author damrem
 */
class B2DebugDrawSystem extends System
{
	public function new(host:DisplayObjectContainer) 
	{
		super();
		
		var sprite = new Sprite();
		sprite.mouseEnabled = false;
		host.addChild(sprite);
		
		var debugDraw = new B2DebugDraw();
		debugDraw.setSprite(sprite);
		debugDraw.setDrawScale(1);
		debugDraw.setFlags(
		
			//B2DebugDraw.e_aabbBit | 
			//B2DebugDraw.e_centerOfMassBit | 
			//B2DebugDraw.e_controllerBit | 
			//B2DebugDraw.e_jointBit | 
			//B2DebugDraw.e_pairBit | 
			B2DebugDraw.e_shapeBit
		);
		B2.world.setDebugDraw(debugDraw);
	}
	
	override public function update(time:Float)
	{
		B2.world.drawDebugData();
	}
	
}