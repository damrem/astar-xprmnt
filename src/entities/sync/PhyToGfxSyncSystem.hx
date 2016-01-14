package entities.sync;

import ash.tools.ListIteratingSystem;

using hxlpers.math.MathSF;

/**
 * ...
 * @author damrem
 */
class PhyToGfxSyncSystem extends ListIteratingSystem<PhyGfxNode>
{

	public function new() 
	{
		super(PhyGfxNode, updateNode);
		
	}
	
	function updateNode(node:PhyGfxNode, time:Float) 
	{
		var pos = node.phy.body.getPosition();
		node.gfx.entitySprite.x = pos.x;
		node.gfx.entitySprite.y = pos.y;
		node.gfx.entitySprite.rotation = node.phy.body.getAngle().toDegrees(); 
	}
	
	
	
}