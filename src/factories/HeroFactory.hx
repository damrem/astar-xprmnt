package factories;
import ash.core.Entity;
import box2D.dynamics.B2World;
import controls.KeyboardControlledComponent;
import openfl.ui.Keyboard;
import physics.BodyComponent;

/**
 * ...
 * @author damrem
 */
class HeroFactory
{
	public static var SIZE:Float = 25;
	
	public static function createHero(x:Float, y:Float):Entity
	{
		var hero = SimpleEntityCreator.createBallEntity(x, y, 24, 0, 0xff0000);
		
		var keyMap = new Map<Int, Dynamic>();
		keyMap.set(Keyboard.LEFT, HeroCommand.Left);
		keyMap.set(Keyboard.UP, HeroCommand.Up);
		keyMap.set(Keyboard.RIGHT, HeroCommand.Right);
		keyMap.set(Keyboard.DOWN, HeroCommand.Down);
		keyMap.set(Keyboard.SPACE, HeroCommand.Shoot);
		hero.add(new KeyboardControlledComponent(keyMap));
		
		hero.add(new SimpleComponent());
		
		return hero;
	}
	
}

enum HeroCommand {
	Left;
	Up;
	Right;
	Down;
	Shoot;
}