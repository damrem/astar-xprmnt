package labyrinth;
import ash.core.Entity;
import ash.core.System;
import ash.tools.ListIteratingSystem;
import de.polygonal.ds.Array2;

/**
 * ...
 * @author damrem
 */
class MazeSystem extends System
{
	var tiles:Array2<Entity>;
	
	public function new(width:Int, height:Int) 
	{
		super();
		
		tiles = new Array2<Entity>(width, height);
		
		for (y in 0...height)
		{
			for(x in 0...width)
			{
				var tile = new Entity();
				tile.add(new TileApertureComponent());
				tiles.set(x, y, tile);
			}
		}
	}
	
}