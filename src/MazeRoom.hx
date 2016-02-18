package;

import box2D.dynamics.B2World;
import edge.Entity;
import edge.World;
import factories.SimpleEntityCreator;
import factories.TileFactory;
import factories.WallFactory;
import heroes.HeroFactory;
import hxlpers.colors.Colors;
import hxlpers.colors.RndColor;
import hxlpers.game.Room;
import hxlpers.Rnd;
import labyrinth.MazeComponent;
import labyrinth.MazeGenerator;
import openfl.display.Sprite;
import openfl.utils.Timer;
import physics.B2;
import physics.B2System;
import randommove.RandomMove;
import selection.Selectable;

using hxlpers.display.SpriteSF;

/**
 * ...
 * @author damrem
 */
class MazeRoom extends Room
{
	var world:World;
	var creator:SimpleEntityCreator;
	var timer:Timer;
	
	public var phyDebugSprite:Sprite;
	
	public static inline var MAZE_WIDTH:Int = 5;
	public static inline var MAZE_HEIGHT:Int = 5;
	

	public function new(fullWidth:Float, fullHeight:Float, ratio:UInt) 
	{
		super(fullWidth, fullHeight, ratio);
		
		phyDebugSprite = new Sprite();
		
		B2.world = new B2World(B2.GRAVITY, true);
		
		world = new World();
		
		world.engine.create([HeroFactory.createEntity(32, 32)]);
		
		for (entity in createWallEntities())
		{
			//engine.addEntity(entity);
		};
		
		var tileEntities = MazeGenerator.create(MAZE_WIDTH, MAZE_HEIGHT);
		var mazeEntity = [new MazeComponent(tileEntities)];
		
		world.engine.create([mazeEntity]);
		for (tile in tileEntities)
		{
			world.engine.create([tile]);
		}
		
		
		world.physics.add(new B2System());
		
		//engine.addSystem(new BuildTileBody(), 3);
		//engine.addSystem(new RandomMoveSystem(), 5);
		//engine.addSystem(new MoveMazeRandomly(), 10);
		//engine.addSystem(new MoveMaze(), 11);
		//engine.addSystem(new MoveTile(), 12);
		////engine.addSystem(new PhyToGfxSyncSystem(), 8);
		////engine.addSystem(new SelectionSystem(), 10);
		////engine.addSystem(new RenderSystem(this), 15);
		//engine.addSystem(new KeyboardControlSystem(), 18);
		//engine.addSystem(new HeroKeyboardMoveSystem(), 19);
		//engine.addSystem(new B2DebugDrawSystem(this), 20);
		
		start();
	}
	
	public function start()
	{
		world.start();	
	}
	
	
	
	function createWallEntities():Array<Array<{}>>
	{
		
		var entities = [];
		
		var w = MAZE_WIDTH * TileFactory.TILE_SIZE;
		var h = MAZE_HEIGHT * TileFactory.TILE_SIZE;
		
		var westWall = WallFactory.createWallEntity( -h, 0, h, Colors.WHITE);
		westWall.push(new SimpleComponent());
		entities.push(westWall);
		
		var eastWall = WallFactory.createWallEntity( w + h, 0, h, Colors.WHITE);
		eastWall.push(new SimpleComponent());
		entities.push(eastWall);
		//engine.addEntity(eastWall);

		
		var northWall = WallFactory.createWallEntity( 0, -w, w, Colors.WHITE);
		northWall.push(new SimpleComponent());
		entities.push(northWall);
		//engine.addEntity(northWall);
		
		var southWall = WallFactory.createWallEntity( 0, h + w, w, Colors.WHITE);
		southWall.push(new SimpleComponent());
		entities.push(southWall);
		//engine.addEntity(southWall);
		
		return entities;
		
		//return maskedLayer;
	}
	
}