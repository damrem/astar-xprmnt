package labyrinth;
import labyrinth.Maze;
import hxlpers.Direction;
using hxlpers.ds.Array2SF;
#if debug
import de.polygonal.ds.error.Assert;
typedef D = Assert;
#end




/**
 * ...
 * @author damrem
 */
class MazeTestCase
{
	var maze:labyrinth.Maze;
	
	public function new()
	{
		testGetNeighbor();
		//testGetConnectedNeighbors();
		//testAreConnected();
		testRealCase();
	}

	public function setup()
	{
		maze = new labyrinth.Maze(4, 4);
	}
	
	function testGetNeighbor()
	{
		setup();
		
		var center;
		var neighbor;
		var expected;
		
		center = maze.tiles.get(1, 1);

		neighbor = maze.tiles.getNeighbor(center, hxlpers.Direction.Right);
		expected = maze.tiles.get(2, 1);
		D.assert(neighbor == expected, "right neighbor");
		
		neighbor = maze.tiles.getNeighbor(center, hxlpers.Direction.Down);
		expected = maze.tiles.get(1, 2);
		D.assert(neighbor == expected, "bottom neighbor");
		
		neighbor = maze.tiles.getNeighbor(center, hxlpers.Direction.Left);
		expected = maze.tiles.get(0, 1);
		D.assert(neighbor == expected, "left neighbor");
		
		neighbor = maze.tiles.getNeighbor(center, hxlpers.Direction.Up);
		expected = maze.tiles.get(1, 0);
		D.assert(neighbor == expected, "top neighbor");
		
		center = maze.tiles.get(0, 0);

		neighbor = maze.tiles.getNeighbor(center, hxlpers.Direction.Left);
		expected = null;
		D.assert(neighbor == expected, "no left neighbor");
		
		neighbor = maze.tiles.getNeighbor(center, hxlpers.Direction.Up);
		expected = null;
		D.assert(neighbor == expected, "no top neighbor");	
	}
	
	/*
	function testGetConnectedNeighbors()
	{
		var center;
		var connecteds;

		setup();

		for (tile in maze.tiles)
		{
			tile.right = tile.bottom = tile.left = tile.top = true;
		}
		
		center = maze.tiles.get(1, 1);
		connecteds = maze.getConnectedNeighbors(center);
		D.assert(connecteds.length == 4);
		
		var current;
		
		current = maze.tiles.get(0, 0);
		current.right = current.bottom = current.left = current.top = false;
		
		maze.move(0, 1, Direction.Bottom);
		connecteds = maze.getConnectedNeighbors(center);
		D.assert(connecteds.length == 3);
		D.assert(connecteds.indexOf(current) < 0, "connected neighbor");
		
		maze.move(0, 1, Direction.Bottom);
		connecteds = maze.getConnectedNeighbors(center);
		D.assert(connecteds.length == 4);
		
		maze.move(0, 2, Direction.Right);
		connecteds = maze.getConnectedNeighbors(center);
		D.assert(connecteds.length == 3);
		D.assert(connecteds.indexOf(current) < 0, "connected neighbor");
		
	}
	*/
	/*
	function testAreConnected()
	{
		setup();
		
		maze.tiles.get(0, 0).right = true;	maze.tiles.get(1, 0).left = true;
		
		maze.tiles.get(0, 2).right = false;

		D.assert(maze.areHConnected(maze.tiles.get(0, 0), maze.tiles.get(1, 0)));

		maze.move(0, 0, Direction.Bottom);
		D.assert(!maze.areHConnected(maze.tiles.get(0, 0), maze.tiles.get(1, 0)));
		
		//maze.tiles.get(
	}
	*/
	
	function testRealCase()
	{
		setup();
		
		maze.tiles.get(0, 0).openness = 15;
		maze.tiles.get(1, 0).openness = 11;
		maze.tiles.get(2, 0).openness = 5;
		maze.tiles.get(3, 0).openness = 3;
		
		maze.tiles.get(0, 1).openness = 10;
		maze.tiles.get(1, 1).openness = 3;
		maze.tiles.get(2, 1).openness = 7;
		maze.tiles.get(3, 1).openness = 6;
		
		maze.tiles.get(0, 2).openness = 12;
		maze.tiles.get(1, 2).openness = 6;
		maze.tiles.get(2, 2).openness = 13;
		maze.tiles.get(3, 2).openness = 6;
		
		maze.tiles.get(0, 3).openness = 6;
		maze.tiles.get(1, 3).openness = 5;
		maze.tiles.get(2, 3).openness = 6;
		maze.tiles.get(3, 3).openness = 11;
		
		maze.move(0, 0, hxlpers.Direction.Right);
		
		D.assert(maze.tiles.get(0, 0).openness == 3);
		D.assert(maze.tiles.get(1, 0).openness == 15);
		D.assert(maze.tiles.get(2, 0).openness == 11);
		D.assert(maze.tiles.get(3, 0).openness == 5);
		
		D.assert(maze.tiles.get(0, 1).openness == 10);
		D.assert(maze.tiles.get(1, 1).openness == 3);
		D.assert(maze.tiles.get(2, 1).openness == 7);
		D.assert(maze.tiles.get(3, 1).openness == 6);
		
		D.assert(maze.tiles.areNeighbors(maze.tiles.get(0, 0), maze.tiles.get(1, 0)));
		D.assert(maze.tiles.get(0, 0).right);
		D.assert(maze.tiles.get(1, 0).left);
		D.assert(maze.areHConnected(maze.tiles.get(0, 0), maze.tiles.get(1, 0)));
		D.assert(!maze.areVConnected(maze.tiles.get(0, 0), maze.tiles.get(1, 0)));
		//D.assert(maze.areConnected(maze.tiles.get(0, 0), maze.tiles.get(1, 0)));
	}
	
}