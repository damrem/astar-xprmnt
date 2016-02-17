package labyrinth;
import de.polygonal.ds.Array2.Array2Cell;

/**
 * ...
 * @author damrem
 */
class TileComponent
{
	public var bits(get, null):Int;
	var _bits:Int;
	
	public var cell:Array2Cell;
	
	public function new(x:Int, y:Int, ?_bits:Int)
	{
		trace(_bits);
		cell = new Array2Cell(x, y);
		
		if (_bits == null)
		{
			do
			{
				_bits = Std.random(16);
			}
			while (_bits == 0 || _bits == 1 || _bits == 2 || _bits == 4 || _bits == 8);
		}
		
		this._bits = _bits;
		
		
	}
	
	
	public var right(get, null):Bool;
	function get_right()
	{
		return _bits & 1 > 0;
	}
	
	public var bottom(get, null):Bool;
	function get_bottom()
	{
		return _bits & 2 > 0;
	}
	
	public var left(get, null):Bool;
	function get_left()
	{
		return _bits & 4 > 0;
	}
	
	public var top(get, null):Bool;
	function get_top()
	{
		return _bits & 8 > 0;
	}
	
	function get_bits():Int 
	{
		return _bits;
	}
}