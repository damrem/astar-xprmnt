package controls;

/**
 * ...
 * @author damrem
 */
class KeyboardControlledComponent
{
	public var leftKeyCode:Int;
	public var upKeyCode:Int;
	public var rightKeyCode:Int;
	public var downKeyCode:Int;
	public var shootKeyCode:Int;

	public function new(leftKeyCode:Int, upKeyCode:Int, rightKeyCode:Int, downKeyCode:Int, shootKeyCode:Int)
	{
		this.shootKeyCode = shootKeyCode;
		this.downKeyCode = downKeyCode;
		this.rightKeyCode = rightKeyCode;
		this.upKeyCode = upKeyCode;
		this.leftKeyCode = leftKeyCode;
	}
	
}