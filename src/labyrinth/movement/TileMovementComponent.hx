package labyrinth.movement;

import box2D.common.math.B2Vec2;
import de.polygonal.ds.Array2.Array2Cell;
import factories.TileFactory;

/**
 * ...
 * @author damrem
 */
class TileMovementComponent
{
	public var destCell:Array2Cell;
	public var position:B2Vec2;
	
	public function new(originCell:Array2Cell, destCell:Array2Cell) 
	{
		this.destCell = destCell;
		position = new B2Vec2(TileFactory.posXfromCellX(originCell.x), TileFactory.posYfromCellY(originCell.y));
	}
	
	
}