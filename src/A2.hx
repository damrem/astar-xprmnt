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
	
	
	
	
	
}