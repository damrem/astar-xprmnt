package;
import de.polygonal.ds.Array2;

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
	
	
	
}