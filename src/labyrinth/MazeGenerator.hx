package labyrinth;

import de.polygonal.ds.Array2;
import factories.TileFactory;

/**
 * ...
 * @author damrem
 */
class MazeGenerator
{
	public static function create(width:Int, height:Int):Array2<Ent>
	{
		var tiles = new Array2<Ent>(width, height);
		
		for (y in 0...height)
		{
			for(x in 0...width)
			{
				var tile = TileFactory.createEntity(x, y);
				tiles.set(x, y, tile);
			}
		}
		
		return tiles;
	}
	
}