package entities.labyrinth;
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
	var tiles:Array2<Tile>;
	
	public function new(width:Int, height:Int) 
	{
		tiles = new Array2(width, height);
		
		for (v in 0...h)
		{
			for(u in 0...w)
			{
				var tile = new Entity();
				tile.add(new Aperture());
				tiles.set(u, v, tile);
			}
		}
	}
	
}