package;

import Controls.KeyboardScheme;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flash.system.System;
import lime.app.Application;
#if windows
import Discord.DiscordClient;
#end

using StringTools;

class MenuState extends MenuUIState
{
	var selectedMenu:Int = 0;

	var menuOptions:Array<String> = ['Choose a Game', 'Multiplayer', 'Options', 'Exit'];
	var menuItem:FlxText;
	var menuItems:FlxTypedGroup<FlxText>;

	override function create()
	{
		var bg:FlxSprite = new FlxSprite(0, 0).loadGraphic(AssetPaths.image('bg'));
		add(bg);
		add(menuItems);

		for (i in 0...menuOptions.length)
		{
			menuItem = new FlxText(50, 70, 0, menuOptions[i], 64);
			menuItem.ID = i;
			menuItems.add(menuItem);
			menuItem.y = 60 + (i * 80);
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		var selectedOption:Bool = false; // this makes it player not able to move to a different option after he pressed

		if (!selectedOption)
		{
			if (FlxG.keys.justPressed.UP)
			{
				changeMenuOption(-1);
			}

			if (FlxG.keys.justPressed.DOWN)
			{
				changeMenuOption(1);
			}

			if (FlxG.keys.justPressed.ENTER)
			{
				selectedOption = true;

				menuItems.forEach(function(spr:FlxSprite)
				{
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						var chosenOption:String = menuOptions[selectedMenu];

						switch (chosenOption)
						{
							case 'Choose a Game':
								FlxG.switchState(new GamePickerState());
							case 'Multiplayer':
								OpenURL('https://www.youtube.com/watch?v=dQw4w9WgXcQ');
							case 'Options':
								FlxG.switchState(new OptionsMenu());
							case 'Exit':
								System.exit(0);
						}
					});
				});
			}
		}

		menuItems.forEach(function(option:FlxText)
		{
			menuItem.color = FlxColor.WHITE;

			if (option.ID == selectedMenu)
				option.color = FlxColor.YELLOW;
		});
	}

	function changeMenuOption(number:Int = 0)
	{
		selectedMenu += number;

		if (selectedMenu >= menuItems.length)
			selectedMenu = 0;
		if (selectedMenu < 0)
			selectedMenu = menuItems.length - 1;
	}
}
