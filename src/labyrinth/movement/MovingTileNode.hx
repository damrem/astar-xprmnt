package labyrinth.movement;

import ash.core.Node;
import labyrinth.movement.TileMovementComponent;
import physics.PhysicalComponent;

/**
 * ...
 * @author damrem
 */
class MovingTileNode extends Node<MovingTileNode>
{
	public var tile:TileComponent;
	public var physical:PhysicalComponent;
	public var movement:TileMovementComponent;
	
}