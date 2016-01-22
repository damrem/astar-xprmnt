package controls;
import ash.core.Node;
import physics.BodyComponent;

/**
 * ...
 * @author damrem
 */
class KeyboardControlledNode extends Node<KeyboardControlledNode>
{
	public var controlled:KeyboardControlledComponent;
	public var body:BodyComponent;
	
	
}

typedef KeySet = {
	var left:Int;
	var up:Int;
	var right:Int;
	var down:Int;
};