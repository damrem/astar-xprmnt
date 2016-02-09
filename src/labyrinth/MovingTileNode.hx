package labyrinth;

import ash.core.Node;
import physics.BodyComponent;

/**
 * ...
 * @author damrem
 */
class MovingTileNode extends Node<MovingTileNode>
{
	public var aperture:TileApertureComponent;
	public var body:BodyComponent;
	public var movement:TileMovementComponent;
	
}