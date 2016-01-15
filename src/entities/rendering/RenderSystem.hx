package entities.rendering;

import edge.ISystem;
import openfl.display.DisplayObjectContainer;

/**
 * ...
 * @author damrem
 */
class RenderSystem implements ISystem
{

	var layer:DisplayObjectContainer;
	
	public function new(layer:DisplayObjectContainer) 
	{
		this.layer = layer;
	}
	
	function update(gfx:Gfx)
	{
		
	}
	
	
	
	function nodeAdded(node:RenderNode) 
	{
		layer.addChild(node.gfx.entitySprite);
	}
	
	function nodeRemoved(node:RenderNode) 
	{
		layer.removeChild(node.gfx.entitySprite);
	}
	
	function updateNode(node:RenderNode, time:Float)
	{
		
	}
	
	
	
}