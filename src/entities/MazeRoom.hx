package entities;

import ash.core.Engine;
import ash.tick.FrameTickProvider;
import box2D.dynamics.B2World;
import entities.physics.PhyDebugSystem;
import entities.physics.PhySystem;
import entities.randommove.RandomMove;
import entities.randommove.RandomMoveSystem;
import entities.selection.Selectable;
import entities.sync.PhyToGfxSyncSystem;
import hxlpers.colors.Colors;
import hxlpers.colors.RndColor;
import hxlpers.game.Room;
import hxlpers.Rnd;
import openfl.display.Sprite;

using hxlpers.display.SpriteSF;

/**
 * ...
 * @author damrem
 */
class MazeRoom extends Room
{
	var tickProvider:FrameTickProvider;
	var engine:Engine;
	var world:B2World;
	
	public var phyDebugSprite:Sprite;
	

	public function new(fullWidth:Float, fullHeight:Float, ratio:UInt) 
	{
		super(fullWidth, fullHeight, ratio);
		
		tickProvider = new FrameTickProvider(this);
		
		phyDebugSprite = new Sprite();
		
		world = new B2World(PhySystem.GRAVITY, true);
		
		engine = new Engine();
		engine.addSystem(new PhySystem(world), 1);
		addEntities();
		engine.addSystem(new RandomMoveSystem(), 5);
		engine.addSystem(new PhyToGfxSyncSystem(), 8);
		//engine.addSystem(new SelectionSystem(), 10);
		//engine.addSystem(new RenderSystem(this), 15);
		engine.addSystem(new PhyDebugSystem(world, this), 20);
		
		start();
	}
	
	public function start()
	{
		tickProvider.add( engine.update );
		tickProvider.start();	
	}
	
	function addEntities(nbEntities:UInt=50)
	{
		trace("addEntities");
		
		var creator = new EntityCreator(world);
		
		for (i in 0...nbEntities)
		{
			var _x = Rnd.float(w);
			var _y = Rnd.float(h);
			var size = Math.random() * 25;
			var color = RndColor.rgb(0.25, 0.5);
			var angle = Math.random() * Math.PI * 2;
			
			var entity;
			
			if (Rnd.chance())
			{
				entity = creator.createBallEntity(_x, _y, size, angle, color);
			}
			else
			{
				entity = creator.createBoxEntity(_x, _y, size, angle, color);
			}
			
			entity.add(new RandomMove(1));
			entity.add(new Selectable());
			
			engine.addEntity(entity);
		}
		
		
		var westWall = creator.createWallEntity( -h, 0, h, Colors.WHITE);
		engine.addEntity(westWall);


		var eastWall = creator.createWallEntity( w+h, 0, h, Colors.WHITE);
		engine.addEntity(eastWall);

		
		var northWall = creator.createWallEntity( 0, -w, w, Colors.WHITE);
		engine.addEntity(northWall);
		
		var southWall = creator.createWallEntity( 0, h+w, w, Colors.WHITE);
		engine.addEntity(southWall);
		
		//return maskedLayer;
	}
	
}