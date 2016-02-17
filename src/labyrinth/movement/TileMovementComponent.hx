package labyrinth.movement;

import box2D.common.math.B2Vec2;
import de.polygonal.ds.Array2.Array2Cell;
import hxlpers.Direction;

/**
 * ...
 * @author damrem
 */
class TileMovementComponent
{
	public var destCell:Array2Cell;
	public var position:B2Vec2;
	public var direction:Direction;
	
	public function new(destCell:Array2Cell, direction:Direction) 
	{
		this.destCell = destCell;
		this.direction = direction;
		position = new B2Vec2();
	}
	
	
}