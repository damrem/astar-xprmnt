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
	
	static public function getNeighbor<T>(user:Array2<T>, x:T, direction:Direction):T
	{
		var cell = user.getNeighborCell(user.getCellOf(x), direction);
		if (cell == null) return null;
		return user.getAt(cell);
	}
	
	static public function areVNeighbors<T>(user:Array2<T>, x:T, y:T):Bool
	{
		var dy = user.getCellOf(x).y - user.getCellOf(y).y;
		return user.sameCol(x, y) && dy * dy == 1;
	}
	
	static public function areHNeighbors<T>(user:Array2<T>, x:T, y:T):Bool
	{
		var dx = user.getCellOf(x).x - user.getCellOf(y).x;
		return user.sameRow(x, y) && dx * dx == 1;
	}
	
	static public function areNeighbors<T>(user:Array2<T>, x:T, y:T):Bool
	{
		return user.areHNeighbors(x, y) || user.areVNeighbors(x, y);
	}
	
	
	static public function move<T>(user:Array2<T>, colIndex:Int, rowIndex:Int, direction:Direction):Array<T>
	{
		var colOrRow:Array<T> = [];
		
		switch(direction)
		{
			case Right:
				user.getRow(rowIndex, colOrRow);
				colOrRow.unshift(colOrRow.pop());
				user.setRow(rowIndex, colOrRow);
				
			case Bottom:
				user.getCol(colIndex, colOrRow);
				colOrRow.unshift(colOrRow.pop());
				user.setCol(colIndex, colOrRow);
				
			case Left:
				user.getRow(rowIndex, colOrRow);
				colOrRow.push(colOrRow.shift());
				user.setRow(rowIndex, colOrRow);
				
			case Top:
				user.getCol(colIndex, colOrRow);
				colOrRow.push(colOrRow.shift());
				user.setCol(colIndex, colOrRow);
		}
		
		return colOrRow;
	}
	
}