package labyrinth;
import hxlpers.Direction;

/**
 * ...
 * @author damrem
 */
class MazeMovementComponent
{
	public var direction:Direction;
	public var y:Int;
	public var x:Int;

	public function new(x:Int, y:Int, direction:Direction) 
	{
		trace(x, y, direction);
		this.x = x;
		this.y = y;
		this.direction = direction;
		
	}
	
}