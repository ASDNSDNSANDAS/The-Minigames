package;

#if windows
import Discord.DiscordClient;
#end
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import openfl.Lib;
import flixel.FlxG;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.ui.FlxUIState;
import flixel.math.FlxRect;
import flixel.util.FlxTimer;

class MenuUIState extends FlxUIState
{
	override function create()
	{
		if (transIn != null)
			trace('reg ' + transIn.region);

		super.create();
	}

    override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
	
	public function OpenURL(url:String)
	{
		#if linux
		Sys.command('/usr/bin/xdg-open', [url, "&"]);
		#else
		FlxG.openURL(url);
		#end
	}
}
