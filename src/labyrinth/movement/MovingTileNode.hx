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
	public var aperture:TileApertureComponent;
	public var physical:PhysicalComponent;
	public var movement:TileMovementComponent;
	
}