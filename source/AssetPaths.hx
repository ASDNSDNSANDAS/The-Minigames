package;

import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;
import openfl.utils.AssetType;
import openfl.utils.Assets as OpenFlAssets;

class AssetPaths
{
	inline public static var SOUND_EXT = #if web "mp3" #else "ogg" #end;

	static var currentLevel:String;

	static public function setCurrentLevel(name:String)
	{
		currentLevel = name.toLowerCase();
	}

	static function getPath(file:String, type:AssetType)
	{
		return getAssetsPath(file);
	}

    inline static public function file(file:String, type:AssetType = TEXT)
	{
		return getPath(file, type);
	}

	inline static function getAssetsPath(file:String)
	{
		return 'assets/$file';
	}

	inline static public function lua(key:String)
	{
		return getPath('data/$key.lua', TEXT);
	}

	inline static public function luaImage(key:String)
	{
		return getPath('data/$key.png', IMAGE);
	}

	inline static public function txt(key:String)
	{
		return getPath('data/$key.txt', TEXT);
	}

	inline static public function xml(key:String)
	{
		return getPath('data/$key.xml', TEXT);
	}

	inline static public function json(key:String)
	{
		return getPath('data/$key.json', TEXT);
	}

	static public function sound(key:String)
	{
		return getPath('sounds/$key.$SOUND_EXT', SOUND);
	}

	inline static public function soundRandom(key:String, min:Int, max:Int)
	{
		return sound(key + FlxG.random.int(min, max));
	}

	inline static public function music(key:String)
	{
		return getPath('music/$key.$SOUND_EXT', MUSIC);
	}

	inline static public function image(key:String)
	{
		return getPath('images/$key.png', IMAGE);
	}

	inline static public function font(key:String)
	{
		return 'assets/fonts/$key';
	}

	inline static public function getSparrowAtlas(key:String)
	{
		return FlxAtlasFrames.fromSparrow(image(key), file('images/$key.xml'));
	}

	inline static public function getPackerAtlas(key:String)
	{
		return FlxAtlasFrames.fromSpriteSheetPacker(image(key), file('images/$key.txt'));
	}
}
