package;
import de.polygonal.ds.Array2;

using A2;

/**
 * ...
 * @author damrem
 */
class A2
{

	static public function getCellOf<T>(user:Array2<T>, x:T):Array2Cell
	{
		var cell = new Array2Cell();
		user.cellOf(x, cell);
		return cell;
	};
	
	static public function sameRow<T>(user:Array2<T>, x:T, y:T):Bool
	{
		return user.getCellOf(x).y == user.getCellOf(y).y;
	}
	
	static public function sameCol<T>(user:Array2<T>, x:T, y:T):Bool
	{
		return user.getCellOf(x).x == user.getCellOf(y).x;
	}
	
	static public function getNeighborCell<T>(user:Array2<T>, refCell:Array2Cell, direction:Direction, wrapped=false):Array2Cell
	{
		var cell = new Array2Cell(refCell.x, refCell.y);
		switch(direction)
		{
			case Right:
				cell.x++;
				if (cell.x >= user.getW())
				{
					if (!wrapped) return null;
					cell.x = 0;
				}
				
			case Bottom:
				cell.y++;
				if (cell.y >= user.getH())
				{
					if (!wrapped) return null;
					cell.y = 0;
				}
				
			case Left:
				cell.x--;
				if (cell.x < 0)
				{
					if (!wrapped) return null;
					cell.x = user.getW() - 1;
				}
				
			case Top:
				cell.y--;
				if (cell.y < 0)
				{
					if (!wrapped) return null;
					cell.y = user.getH() - 1;
				}
				
		}
		return cell;
	}
	
	
	
}