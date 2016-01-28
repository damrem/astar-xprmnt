package controls;
import box2D.common.math.B2Vec2;

import hxlpers.Direction;

/**
 * ...
 * @author damrem
 */
class KeyboardControlledComponent
{
	public var keyMap:Map<Int, Dynamic>;
	public var vDirection:Direction;
	public var hDirection:Direction;
	public var impulse:B2Vec2;
	public var reactivity:Float = 5000;
	public var keyStates:Map<Int, KeyState>;

	public function new(?keyMap:Map<Int, Dynamic>)
	{
		this.keyMap = keyMap == null ? new Map<Int, Dynamic>() : keyMap;
		keyStates = new Map<Int, KeyState>();
		//this.keySet = keyCodeSet;
		impulse = new B2Vec2();
		hDirection = vDirection = Direction.None;
	}
	
}

typedef KeySet = {
	var left:Int;
	var up:Int;
	var right:Int;
	var down:Int;
	var shoot:Int;
};