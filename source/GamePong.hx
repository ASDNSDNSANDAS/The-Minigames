package;

import Controls.KeyboardScheme;
import flixel.FlxG;
import flixel.util.FlxAxes;
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

class GamePong extends PlayState
{
    var bouncerLeft:FlxSprite;
    var bouncerRight:FlxSprite;

    var wallTop:FlxSprite;
    var wallBottom:FlxSprite;

    var bouncerBall:FlxSprite;

    var scoreLeft:FlxText;
    var scoreRight:FlxText;

    var leftScore:Int = 0;
    var rightScore:Int = 0;

	override public function create()
	{
        // adding the poggers bouncers
        bouncerLeft = new FlxSprite(8, 0);
        bouncerLeft.makeGraphic(16, 64, FlxColor.RED);
        bouncerLeft.screenCenter(FlxAxes.Y);
        bouncerLeft.immovable = true;
        add(bouncerLeft);

        bouncerRight = new FlxSprite(FlxG.width - 24, 0);
        bouncerRight.makeGraphic(16, 64, FlxColor.CYAN);
        bouncerRight.screenCenter(FlxAxes.Y);
        bouncerRight.immovable = true;
        add(bouncerRight);

        // creating the walls so balls wont go out of bounds
        wallTop = new FlxSprite(0, 0).makeGraphic(FlxG.width, 8, FlxColor.WHITE);
        wallTop.immovable = true;
        add(wallTop);

        wallBottom = new FlxSprite(0, FlxG.height - 8).makeGraphic(FlxG.width, 8, FlxColor.WHITE);
        wallBottom.immovable = true;
        add(wallBottom);

        // our ball
        bouncerBall = new FlxSprite(0, 0).makeGraphic(16, 16, FlxColor.WHITE);
        bouncerBall.screenCenter(FlxAxes.XY);
        bouncerBall.velocity.y = 200; // makes it move down
        bouncerBall.velocity.x = -200; // makes it move left
        bouncerBall.elasticity = 1; // makes it bounce off things
        add(bouncerBall);

        // score duh
        scoreLeft = new FlxText(220, 32, 100, '$leftScore', 32);
        scoreLeft.color = FlxColor.WHITE;
        scoreLeft.alignment = FlxTextAlign.LEFT;
        add(scoreLeft);

        scoreRight = new FlxText(320, 32, 100, '$rightScore', 32);
        scoreRight.color = FlxColor.WHITE;
        scoreRight.alignment = FlxTextAlign.RIGHT;
        add(scoreRight);

        FlxG.collide(bouncerBall, wallBottom);
        FlxG.collide(bouncerBall, wallTop);
        FlxG.collide(bouncerBall, bouncerLeft);
        FlxG.collide(bouncerBall, bouncerRight);

		super.create();
	}

	override public function update(elapsed:Float)
	{
        // adding points and bringing the ball in the middle
        if (bouncerBall.x > bouncerRight.x)
        {
            leftScore += 1;
            bouncerBall.screenCenter(FlxAxes.XY);
        }
        else if (bouncerBall.x < bouncerLeft.x)
        {
            rightScore += 1;
            bouncerBall.screenCenter(FlxAxes.XY);
        }
        
        // updating the scores
        scoreLeft.text = '$leftScore';
        scoreRight.text = '$rightScore';

        if (FlxG.keys.pressed.UP)
        {
            bouncerLeft.velocity.y = -300;
        }
        else if (FlxG.keys.pressed.DOWN)
        {
            bouncerLeft.velocity.y = 300;
        }

		super.update(elapsed);
	}
}
