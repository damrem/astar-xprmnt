package;

import ash.core.Engine;
import ash.core.Entity;
import ash.tick.FrameTickProvider;
import box2D.dynamics.B2World;
import factories.HeroFactory;
import labyrinth.MazeSystem;
import physics.PhyDebugSystem;
import physics.PhySystem;
import randommove.RandomMove;
import randommove.RandomMoveSystem;
import selection.Selectable;
import sync.PhyToGfxSyncSystem;
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
	var creator:EntityCreator;
	
	public var phyDebugSprite:Sprite;
	

	public function new(fullWidth:Float, fullHeight:Float, ratio:UInt) 
	{
		super(fullWidth, fullHeight, ratio);
		
		tickProvider = new FrameTickProvider(this);
		
		phyDebugSprite = new Sprite();
		
		world = new B2World(PhySystem.GRAVITY, true);
		creator = new EntityCreator(world);
		
		engine = new Engine();
		
		var hero = creator.createBallEntity(50, 50, 50, 0, 0xff0000);
		
		engine.addEntity(hero);
		
		for (entity in createEntities())
		{
			engine.addEntity(entity);
		};
		
		
		engine.addSystem(new PhySystem(world), 1);
		engine.addSystem(new MazeSystem(5, 5), 2);
		
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
	
	function createEntities(nbEntities:UInt=50):Array<Entity>
	{
		var entities = new Array<Entity>();
		trace("addEntities");
		
		
		
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
			
			entities.push(entity);
			
			//engine.addEntity(entity);
		}
		
		
		var westWall = creator.createWallEntity( -h, 0, h, Colors.WHITE);
		entities.push(westWall);
		
		var eastWall = creator.createWallEntity( w + h, 0, h, Colors.WHITE);
		entities.push(eastWall);
		//engine.addEntity(eastWall);

		
		var northWall = creator.createWallEntity( 0, -w, w, Colors.WHITE);
		entities.push(northWall);
		//engine.addEntity(northWall);
		
		var southWall = creator.createWallEntity( 0, h + w, w, Colors.WHITE);
		entities.push(southWall);
		//engine.addEntity(southWall);
		
		return entities;
		
		//return maskedLayer;
	}
	
}