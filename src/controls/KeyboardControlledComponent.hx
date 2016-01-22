package controls;
import box2D.common.math.B2Vec2;
import controls.KeyboardControlledNode.KeySet;
import hxlpers.Direction;

/**
 * ...
 * @author damrem
 */
class KeyboardControlledComponent
{
	public var keySet:KeySet;
	public var vDirection:Direction;
	public var hDirection:Direction;
	public var impulse:B2Vec2;
	public var reactivity:Float = 5000;

	public function new(keyCodeSet:KeySet)
	{
		this.keySet = keyCodeSet;
		impulse = new B2Vec2();
		hDirection = vDirection = Direction.None;
	}
	
}