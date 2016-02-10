package labyrinth;
import ash.core.Node;
import physics.PhysicalComponent;
import rendering.Gfx;

/**
 * ...
 * @author damrem
 */
class TileNode extends Node<TileNode>
{
	public var aperture:TileApertureComponent;
	public var physical:PhysicalComponent;
}