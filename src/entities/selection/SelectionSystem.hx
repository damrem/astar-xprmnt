package entities.selection;

import ash.core.Engine;
import ash.core.NodeList;
import ash.core.System;
import ash.tools.ListIteratingSystem;
import entities.randommove.RandomMove;
import entities.rendering.EntitySprite;
import entities.selection.SelectableNode;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.filters.GlowFilter;

/**
 * ...
 * @author damrem
 */
class SelectionSystem extends ListIteratingSystem<SelectableNode>
{

	var glow:GlowFilter;
	
	public function new() 
	{
		super(SelectableNode, updateNode, added, removed);
		glow = new GlowFilter(0xffffff);
	}
	
	function added(node:SelectableNode)
	{
		node.spriteComponent.entitySprite.addEventListener(MouseEvent.ROLL_OVER, onRollOver);
		node.spriteComponent.entitySprite.addEventListener(MouseEvent.ROLL_OUT, onRollOut);
		node.spriteComponent.entitySprite.addEventListener(MouseEvent.CLICK, onClick);
		node.spriteComponent.entitySprite.buttonMode = true;
	}
	
	function removed(node:SelectableNode)
	{
		node.spriteComponent.entitySprite.removeEventListener(MouseEvent.ROLL_OVER, onRollOver);
		node.spriteComponent.entitySprite.removeEventListener(MouseEvent.ROLL_OUT, onRollOut);
		node.spriteComponent.entitySprite.removeEventListener(MouseEvent.CLICK, onClick);
		node.spriteComponent.entitySprite.buttonMode = false;
	}
	
	private function onClick(e:MouseEvent):Void 
	{
		var sprite = cast(e.currentTarget, EntitySprite);
		var entity = sprite.entity;
		
		var selectable = cast(entity.get(Selectable), Selectable);
		selectable.isSelected = !selectable.isSelected;
		
		if (entity.get(RandomMove) != null)
		{
			trace("remove");
			sprite.parent.addChild(sprite);
			entity.remove(RandomMove);
			trace(entity.components);
		}
		else
		{
			trace("add");
			entity.add(new RandomMove());
			trace(entity.components);
		}
	}
	
	function onRollOver(e:MouseEvent):Void 
	{
		cast(e.currentTarget, EntitySprite).alpha = 0.25;
	}
	
	function onRollOut(e:MouseEvent):Void 
	{
		cast(e.currentTarget, EntitySprite).alpha = 1;
	}
	
	function updateNode(node:SelectableNode, time:Float)
	{
		if (node.selectable.isSelected)
		{
			node.spriteComponent.entitySprite.filters = [glow];
		}
		else
		{
			node.spriteComponent.entitySprite.filters = null;
		}
	}
	
	
}