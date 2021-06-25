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
	var menuItems = new FlxTypedGroup<FlxText>();

	var menuItem:FlxText;

	var curSelected:Int = 0;

	var menuOptions:Array<String> = ['Choose a Game', 'Multiplayer', 'Options', 'Exit'];

	var camFollow:FlxObject;

	override function create()
	{
		add(menuItems);

		for (i in 0...menuOptions.length)
		{
			menuItem = new FlxText(50, 70);
			menuItem.ID = i;
			menuItem.screenCenter(X);
			menuItems.add(menuItem);
			menuItem.scrollFactor.set();
			menuItem.antialiasing = true;
			menuItem.y = 60 + (i * 160);
		}
	}

	var selectedOption:Bool = false;

	override function update(elapsed:Float)
	{
		if (!selectedOption)
		{
			if (FlxG.keys.justPressed.UP)
			{
				changeItem(-1);
			}

			if (FlxG.keys.justPressed.DOWN)
			{
				changeItem(1);
			}

			if (FlxG.keys.justPressed.ENTER)
			{
				selectedOption = true;

				menuItems.forEach(function(spr:FlxSprite)
				{
					if (curSelected != spr.ID)
					{
						FlxTween.tween(spr, {alpha: 0}, 1.3, {
							ease: FlxEase.quadOut,
							onComplete: function(twn:FlxTween)
							{
								spr.kill();
							}
						});
					}
					else
					{
						new FlxTimer().start(1, function(tmr:FlxTimer)
						{
							var chosenOption:String = menuOptions[curSelected];

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
					}
				});
			}
		}

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.screenCenter(X);
		});
		
		super.update(elapsed);
	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y);
			}

			spr.updateHitbox();
		});
	}
}
