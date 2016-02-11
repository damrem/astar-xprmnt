package labyrinth.movement;

import box2D.common.math.B2Vec2;
import de.polygonal.ds.Array2.Array2Cell;

/**
 * ...
 * @author damrem
 */
class TileMovementComponent
{
	public var destCell:Array2Cell;
	public var position:B2Vec2;
	
	public function new(destCell:Array2Cell) 
	{
		this.destCell = destCell;
	}
	
	
}