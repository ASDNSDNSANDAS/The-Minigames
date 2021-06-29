package;

import flixel.FlxG;
import flixel.FlxState;

class OptionsMenu extends MenuUIState
{
	override public function create()
	{
		super.create();
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.keys.pressed.BACKSPACE || FlxG.keys.pressed.ESCAPE)
		{
			FlxG.switchState(new MenuState());
		}

		super.update(elapsed);
	}
}
