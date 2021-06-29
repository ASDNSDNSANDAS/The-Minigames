/*package;

import flixel.FlxState;

class GamePickerState extends MenuState
{
	override public function create()
	{
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}*/

// PLACEHOLDER MENU

package;

import Controls.KeyboardScheme;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.effects.FlxFlicker;
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

class GamePickerState extends MenuUIState
{
	var selectedMenu:Int = 0;
	var selectedMouse:Int = -1;
	var selectedOption:Bool = false;

	var gameOptions:Array<String> = ['Pong', 'Tetris', 'something', 'something'];

	var menuItem:FlxText;
	var menuItems:FlxTypedGroup<FlxText>;

	var mouseOverlay0:FlxSprite;
	var mouseOverlay1:FlxSprite;
	var mouseOverlay2:FlxSprite;
	var mouseOverlay3:FlxSprite;

	override function create()
	{
		mouseOverlay0 = new FlxSprite(50, 130).makeGraphic(500, 64, 0x00000000, false); // this works fuck you kek
		mouseOverlay1 = new FlxSprite(50, 210).makeGraphic(500, 64, 0x00000000, false);
		mouseOverlay2 = new FlxSprite(50, 290).makeGraphic(500, 64, 0x00000000, false);
		mouseOverlay3 = new FlxSprite(50, 370).makeGraphic(500, 64, 0x00000000, false);

		var bg:FlxSprite = new FlxSprite(0, 0).loadGraphic(AssetPaths.image('bg'));
		add(bg);

		menuItems = new FlxTypedGroup<FlxText>();
		add(menuItems);

		for (i in 0...gameOptions.length)
		{
			menuItem = new FlxText(50, 130, 0, gameOptions[i], 64);
			menuItem.ID = i;
			menuItems.add(menuItem);
			menuItem.y = 130 + (i * 80);
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		selectedOption = false;

		if (FlxG.keys.pressed.BACKSPACE || FlxG.keys.pressed.ESCAPE)
		{
			FlxG.switchState(new MenuState());
		}

		if (FlxG.mouse.overlaps(menuItems)) // this works so fuck you kek
		{
			if (FlxG.mouse.overlaps(mouseOverlay0))
			{
				mouseIsOverlayed();
				selectedMouse = 0;
				selectedOption = true;

				if (FlxG.mouse.justPressed)
				{
					mouseClickedMenu();
				}
			}
			else if (FlxG.mouse.overlaps(mouseOverlay1))
			{
				mouseIsOverlayed();
				selectedMouse = 1;
				selectedOption = true;
				
				if (FlxG.mouse.justPressed)
				{
					mouseClickedMenu();
				}
			}
			else if (FlxG.mouse.overlaps(mouseOverlay2))
			{
				mouseIsOverlayed();
				selectedMouse = 2;
				selectedOption = true;

				if (FlxG.mouse.justPressed)
				{
					mouseClickedMenu();
				}
			}
			else if (FlxG.mouse.overlaps(mouseOverlay3))
			{
				mouseIsOverlayed();
				selectedMouse = 3;
				selectedOption = true;

				if (FlxG.mouse.justPressed)
				{
					mouseClickedMenu();
				}
			}
		}

		if (!selectedOption)
		{
			if (FlxG.keys.justPressed.UP)
			{
				changeMenuOption(-1);
				selectionMoved();
			}

			if (FlxG.keys.justPressed.DOWN)
			{
				changeMenuOption(1);
				selectionMoved();
			}

			if (FlxG.keys.justPressed.ENTER)
			{
				selectedOption = true;
				// FlxFlicker.flicker(menuItem, 1, 0.04, true, true);

				menuItems.forEach(function(spr:FlxText)
				{
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						var chosenOption:String = gameOptions[selectedMenu];

						switch (chosenOption)
						{
							case 'Pong':
								FlxG.switchState(new GamePong());
							case 'Tetris':
								// FlxG.switchState(new GameTetris());
							case 'something':
								// nothing
							case 'something':
								// nothing
						}
					});
				});
			}
		}
	}

	function mouseIsOverlayed()
	{
		menuItems.forEach(function(option:FlxText)
		{
			var optionY:Int = 130 + (option.ID * 80);

			if (option.ID != selectedMouse)
			{
				option.color = FlxColor.WHITE;
				// FlxTween.linearMotion(option, 50, optionY, 100, optionY, 130, false); // for now disabled
			}

			if (option.ID == selectedMouse)
			{
				option.color = FlxColor.YELLOW;
				// FlxTween.linearMotion(option, 100, optionY, 50, optionY, 130, false); // for now disabled
			}
		});
	}

	function selectionMoved()
	{
		menuItems.forEach(function(option:FlxText)
		{
			var optionY:Int = 130 + (option.ID * 80);

			if (option.ID != selectedMenu)
			{
				option.color = FlxColor.WHITE;
				// FlxTween.linearMotion(option, 50, optionY, 100, optionY, 130, false); // for now disabled
			}

			if (option.ID == selectedMenu)
			{
				option.color = FlxColor.YELLOW;
				// FlxTween.linearMotion(option, 100, optionY, 50, optionY, 130, false); // for now disabled
			}
		});
	}

	function mouseClickedMenu()
	{
		new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			var chosenOption:String = gameOptions[selectedMouse];

			switch (chosenOption)
			{
				case 'Pong':
					FlxG.switchState(new GamePong());
				case 'Tetris':
				// FlxG.switchState(new GameTetris());
				case 'something':
				// nothing
				case 'something':
					// nothing
			}
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
