package ash;
import ash.signals.Signal1;
import ash.tick.ITickProvider;
import haxe.Timer;
import openfl.Lib;


/**
 * ...
 * @author damrem
 */
class HaxeTimerTickProvider implements ITickProvider
{
	public var playing(default, null):Bool;
	var timer:Timer;
	var signal:Signal1<Float>;
	var previousTime:Float;
	var maximumFrameTime:Float;
	
	/**
     * Applies a time adjustment factor to the tick, so you can slow down or speed up the entire engine.
     * The update tick time is multiplied by this value, so a value of 1 will run the engine at the normal rate.
     */
    public var timeAdjustment:Float = 1;
	
	public function new(fps:Int, maximumFrameTime:Float = 9999999999999999.0) 
	{
		this.maximumFrameTime = maximumFrameTime;
		playing = false;
		signal = new Signal1<Float>();
		timer = new Timer(Std.int(1000 / fps));
	}
	
	public function add(listener:Float->Void):Void 
	{
		signal.add(listener);
	}
	
	public function remove(listener:Float->Void):Void 
	{
		signal.remove(listener);
	}
	
	public function start():Void
    {
		timer.run = dispatchTick;
        playing = true;
    }

    public function stop():Void
    {
        playing = false;
		timer.run = noop;
    }
	
	function dispatchTick():Void
    {
        var temp:Float = previousTime;
        previousTime = Lib.getTimer();
        var frameTime:Float = ( previousTime - temp ) / 1000;
        if (frameTime > maximumFrameTime)
            frameTime = maximumFrameTime;
		trace(frameTime * timeAdjustment);
        signal.dispatch(frameTime * timeAdjustment);
    }
	
	function noop()
	{
	}
	
}