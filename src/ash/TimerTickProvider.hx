package ash;
import ash.signals.Signal1;
import ash.tick.ITickProvider;
import openfl.events.TimerEvent;
import openfl.Lib;
import openfl.utils.Timer;


/**
 * ...
 * @author damrem
 */
class TimerTickProvider implements ITickProvider
{
	public var playing(default, null):Bool;
	var timer:Timer;
	var signal:Signal1<Float>;
	var previousTime:Float;
	var maximumFrameTime:Float;
	var hxTimer:haxe.Timer;
	
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
		timer = new Timer(1 / fps);
		
		hxTimer = new haxe.Timer(Std.int(1000 / fps));
		hxTimer.run = run;
	}
	
	function run()
	{
		trace("run");
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
        timer.addEventListener(TimerEvent.TIMER, dispatchTick);
		timer.start();
        playing = true;
    }

    public function stop():Void
    {
        playing = false;
		timer.stop();
        timer.removeEventListener(TimerEvent.TIMER, dispatchTick);
    }
	
	private function dispatchTick(event:TimerEvent):Void
    {
        var temp:Float = previousTime;
        previousTime = Lib.getTimer();
        var frameTime:Float = ( previousTime - temp ) / 1000;
        if (frameTime > maximumFrameTime)
            frameTime = maximumFrameTime;
		trace(frameTime * timeAdjustment);
        signal.dispatch(frameTime * timeAdjustment);
    }
	
}