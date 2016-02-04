package labyrinth;
import hxlpers.Direction;

/**
 * ...
 * @author damrem
 */
class MazeMoveComponent
{
	public var y:Int;
	public var x:Int;

	public function new(x:Int, y:Int, direction:Direction) 
	{
		trace(x, y, direction);
		this.y = y;
		this.x = x;
		
	}
	
}