package labyrinth;
import ash.core.Entity;
import de.polygonal.ds.Array2;

/**
 * ...
 * @author damrem
 */
class MazeComponent
{

	public var tiles:Array2<Entity>;
	
	public function new(tiles:Array2<Entity>)
	{
		this.tiles = tiles;
		
	}
	
}