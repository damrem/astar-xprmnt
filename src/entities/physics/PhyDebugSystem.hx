package entities.physics;

import ash.core.System;
import ash.tools.ListIteratingSystem;
import box2D.dynamics.B2DebugDraw;
import box2D.dynamics.B2World;
import openfl.display.DisplayObjectContainer;
import openfl.display.Sprite;

/**
 * ...
 * @author damrem
 */
class PhyDebugSystem extends System
{
	var world:B2World;

	public function new(world:B2World, host:DisplayObjectContainer) 
	{
		super();
		
		this.world = world;
		
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
		world.setDebugDraw(debugDraw);
	}
	
	override public function update(time:Float)
	{
		world.drawDebugData();
	}
	
}