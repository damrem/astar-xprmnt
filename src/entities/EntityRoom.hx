package entities;

import ash.core.Engine;
import ash.tick.FrameTickProvider;
import box2D.dynamics.B2DebugDraw;
import box2D.dynamics.B2World;
import entities.physics.PhySystem;
import entities.randommove.RandomMove;
import entities.randommove.RandomMoveSystem;
import entities.rendering.RenderSystem;
import entities.selection.Selectable;
import entities.selection.SelectionSystem;
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
class EntityRoom extends Room
{
	var tickProvider:FrameTickProvider;
	var engine:Engine;
	var world:box2D.dynamics.B2World;
	
	public var phyDebugSprite:Sprite;
	

	public function new(fullWidth:Float, fullHeight:Float, ratio:UInt) 
	{
		super(fullWidth, fullHeight, ratio);
		
		tickProvider = new FrameTickProvider(this);
		
		
		world = new B2World(PhySystem.GRAVITY, true);
		debugWorld(world);
		
		engine = new Engine();
		engine.addSystem(new PhySystem(world), 1);
		engine.addSystem(new RandomMoveSystem(), 5);
		engine.addSystem(new PhyToGfxSyncSystem(), 8);
		engine.addSystem(new SelectionSystem(), 10);
		engine.addSystem(new RenderSystem(this), 15);
		
		addEntities();
		
		start();
	}
	
	function debugWorld(world:B2World)
	{
		phyDebugSprite = new Sprite();
		phyDebugSprite.mouseEnabled = false;
		
		var debugDraw = new B2DebugDraw();
		debugDraw.setSprite(phyDebugSprite);
		debugDraw.setDrawScale(cast(ratio));
		debugDraw.setFlags(
			//B2DebugDraw.e_aabbBit | 
			//B2DebugDraw.e_centerOfMassBit | 
			//B2DebugDraw.e_controllerBit | 
			//B2DebugDraw.e_jointBit | 
			//B2DebugDraw.e_pairBit | 
			B2DebugDraw.e_shapeBit
		);
		world.setDebugDraw(debugDraw);
		
	}
	
	public function start()
	{
		tickProvider.add( engine.update );
		tickProvider.start();	
	}
	
	
	
	function addEntities(nbEntities:UInt=50)
	{
		//entities = new Array<Sprite>();
		
		var creator = new EntityCreator(world);
		
		for (i in 0...nbEntities)
		{
			var _x = Rnd.float(w);
			var _y = Rnd.float(h);
			var size = Math.random() * 10;
			var color = RndColor.rgb(0.25, 0.5);
			var angle = Math.random() * Math.PI * 2;
			
			var entity;
			
			/*if (Rnd.chance())
			{
				entity = creator.createBallEntity(_x, _y, size, angle, color);
			}
			else*/
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