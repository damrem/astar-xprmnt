package physics;

import edge.Entity;
import edge.ISystem;
import edge.View;

/**
 * ...
 * @author damrem
 */
class B2System implements ISystem
{
	var timeDelta:Float;
	
	var physicalShapeds:View<{physicalShaped:PhysicalShapedComponent}>;
	
	public function update()
	{
		B2.world.step(timeDelta, 8, 3);
	}
	
	public function physicalShapedsAdded(entity:Entity, node:PhysicalShapedNode)
	{
		node.physicalShaped.body = B2.world.createBody(node.physicalShaped.bodyDef);
		node.physicalShaped.body.createFixture(node.physicalShaped.fixtureDef);
	}
	
	public function physicalShapedsRemoved(entity:Entity, node:PhysicalShapedNode)
	{
		node.physicalShaped.body.DestroyFixture(node.physicalShaped.body.getFixtureList());
		B2.world.destroyBody(node.physicalShaped.body);
	}
	
}