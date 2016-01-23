package;

import ash.core.Engine;
import ash.core.Entity;
import ash.tick.FrameTickProvider;
import ash.tick.ITickProvider;
import box2D.dynamics.B2World;
import controls.KeyboardControlledComponent;
import controls.KeyboardControlSystem;
import factories.SimpleEntityCreator;
import factories.TileFactory;
import factories.WallFactory;
import hxlpers.colors.Colors;
import hxlpers.colors.RndColor;
import hxlpers.game.Room;
import hxlpers.Rnd;
import labyrinth.MazeGenerator;
import labyrinth.TileToPhysicsConvertSystem;
import openfl.display.Sprite;
import openfl.ui.Keyboard;
import openfl.utils.Timer;
import physics.B2;
import physics.B2DebugDrawSystem;
import physics.B2System;
import randommove.RandomMove;
import randommove.RandomMoveSystem;
import selection.Selectable;

using hxlpers.display.SpriteSF;

/**
 * ...
 * @author damrem
 */
class MazeRoom extends Room
{
	var tickProvider:ITickProvider;
	var engine:Engine;
	var creator:SimpleEntityCreator;
	var timer:Timer;
	
	public var phyDebugSprite:Sprite;
	
	public static inline var MAZE_WIDTH:Int = 5;
	public static inline var MAZE_HEIGHT:Int = 5;
	

	public function new(fullWidth:Float, fullHeight:Float, ratio:UInt) 
	{
		super(fullWidth, fullHeight, ratio);
		
		tickProvider = new FrameTickProvider(this);
		//cast(tickProvider, HaxeTimerTickProvider).timeAdjustment = 2;
		//timer = new Timer(1 / 60);
		
		phyDebugSprite = new Sprite();
		
		B2.world = new B2World(B2.GRAVITY, true);
		
		engine = new Engine();
		
		var hero = SimpleEntityCreator.createBallEntity(32, 32, 24, 0, 0xff0000);
		hero.add(new KeyboardControlledComponent( {
			left:Keyboard.LEFT, 
			up:Keyboard.UP, 
			right:Keyboard.RIGHT, 
			down:Keyboard.DOWN 
		}));
		hero.add(new SimpleComponent());
		engine.addEntity(hero);
		
		for (entity in createWallEntities())
		{
			engine.addEntity(entity);
		};
		
		for (tile in MazeGenerator.create(MAZE_WIDTH, MAZE_HEIGHT))
		{
			engine.addEntity(tile);
		}
		
		
		engine.addSystem(new B2System(), 1);
		
		engine.addSystem(new TileToPhysicsConvertSystem(), 3);
		engine.addSystem(new RandomMoveSystem(), 5);
		//engine.addSystem(new PhyToGfxSyncSystem(), 8);
		//engine.addSystem(new SelectionSystem(), 10);
		//engine.addSystem(new RenderSystem(this), 15);
		engine.addSystem(new KeyboardControlSystem(), 18);
		engine.addSystem(new B2DebugDrawSystem(this), 20);
		
		start();
	}
	
	public function start()
	{
		tickProvider.add( engine.update );
		tickProvider.start();	
	}
	
	function createSimpleEntities(nbEntities:UInt=50):Array<Entity>
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
				entity = factories.SimpleEntityCreator.createBallEntity(_x, _y, size, angle, color);
			}
			else
			{
				entity = factories.SimpleEntityCreator.createBoxEntity(_x, _y, size, angle, color);
			}
			
			entity.add(new SimpleComponent());
			entity.add(new RandomMove(1));
			entity.add(new Selectable());
			
			entities.push(entity);
			
			//engine.addEntity(entity);
		}
		return entities;
	}
	
	function createWallEntities():Array<Entity>
	{
		
		var entities = [];
		
		var w = MAZE_WIDTH * TileFactory.TILE_SIZE;
		var h = MAZE_HEIGHT * TileFactory.TILE_SIZE;
		
		var westWall = WallFactory.createWallEntity( -h, 0, h, Colors.WHITE);
		westWall.add(new SimpleComponent());
		entities.push(westWall);
		
		var eastWall = WallFactory.createWallEntity( w + h, 0, h, Colors.WHITE);
		eastWall.add(new SimpleComponent());
		entities.push(eastWall);
		//engine.addEntity(eastWall);

		
		var northWall = WallFactory.createWallEntity( 0, -w, w, Colors.WHITE);
		northWall.add(new SimpleComponent());
		entities.push(northWall);
		//engine.addEntity(northWall);
		
		var southWall = WallFactory.createWallEntity( 0, h + w, w, Colors.WHITE);
		southWall.add(new SimpleComponent());
		entities.push(southWall);
		//engine.addEntity(southWall);
		
		return entities;
		
		//return maskedLayer;
	}
	
}