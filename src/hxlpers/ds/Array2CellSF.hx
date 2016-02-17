package hxlpers.ds;
import de.polygonal.ds.Array2.Array2Cell;
/**
 * ...
 * @author damrem
 */
class Array2CellSF
{

	public static function distance(user:Array2Cell, otherCell:Array2Cell):Float 
	{
		var dx = signedDistanceX(user, otherCell);
		var dy = signedDistanceY(user, otherCell);
		return Math.sqrt(dx * dx + dy * dy);
	}
	
	public static function distanceX(user:Array2Cell, otherCell:Array2Cell):Float 
	{
		return Math.abs(signedDistanceX(user, otherCell));
	}
	
	public static function distanceY(user:Array2Cell, otherCell:Array2Cell):Float 
	{
		return Math.abs(signedDistanceY(user, otherCell));
	}
	
	static function signedDistanceX(user:Array2Cell, otherCell:Array2Cell):Float 
	{
		return user.x - otherCell.x;
	}
	
	static function signedDistanceY(user:Array2Cell, otherCell:Array2Cell):Float 
	{
		return user.y - otherCell.y;
	}
	
}