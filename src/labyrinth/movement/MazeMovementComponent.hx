package labyrinth.movement;
import hxlpers.Direction;

/**
 * ...
 * @author damrem
 */
class MazeMovementComponent
{
	public var direction:Direction;
	public var coord:Int;

	public function new(direction:Direction, coord:Int) 
	{
		this.direction = direction;
		this.coord = coord;
		
	}
	
}