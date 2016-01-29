package heroes;
import ash.core.Node;
import controls.KeyboardControlledComponent;
import physics.BodyComponent;

/**
 * ...
 * @author damrem
 */
class HeroControlNode extends Node<HeroControlNode>
{
	public var controlled:KeyboardControlledComponent;
	public var body:BodyComponent;
}

