package entities.selection;

import ash.core.Node;
import entities.rendering.Gfx;
import entities.selection.Selectable;

/**
 * ...
 * @author damrem
 */
class SelectableNode extends Node<SelectableNode>
{
	public var spriteComponent:Gfx;
	public var selectable:Selectable;
}