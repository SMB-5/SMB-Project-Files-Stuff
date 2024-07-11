package substates;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.util.FlxColor;

import flixel.FlxSubState;
import objects.HealthIcon;
import states.MainMenuState;
import backend.WeekData;
import backend.Song;
import backend.Highscore;

using StringTools;

class ChooseSideSubState extends MusicBeatSubstate
{
	var bg:FlxSprite;
	var alphabetArray:Array<Alphabet> = [];
	var onYes:Bool = false;
	var askText:Alphabet;
	var yesText:Alphabet;
	var noText:Alphabet;
	var curDifficulty:Int = -1;
	private static var lastDifficultyName:String = '';
	var scoreBG:FlxSprite;
	var scoreText:FlxText;
	var lerpScore:Int = 0;
	var lerpRating:Float = 0;
	var intendedScore:Int = 0;
	var intendedRating:Float = 0;
	var bottomString:String;
	var bottomText:FlxText;
	var bottomBG:FlxSprite;


	public function new()
	{

		super();

		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0;
		bg.scrollFactor.set();
		add(bg);

		scoreText = new FlxText(FlxG.width * 0.7, 5, 0, "", 32);
		scoreText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, RIGHT);

		scoreBG = new FlxSprite(scoreText.x - 6, 0).makeGraphic(1, 66, 0xFF000000);
		scoreBG.alpha = 0.6;
		//add(scoreBG);
		//I could not position this aaaaaagggggghhhhhh!!!

		add(scoreText);

		bottomBG = new FlxSprite(0, FlxG.height - 26).makeGraphic(FlxG.width, 26, 0xFF000000);
		bottomBG.alpha = 0.6;
		//add(bottomBG);

		var leText:String = "Press RESET to Reset your Score and Accuracy.";
		bottomString = leText;
		var size:Int = 16;
		bottomText = new FlxText(bottomBG.x, bottomBG.y + 4, FlxG.width, leText, size);
		bottomText.setFormat(Paths.font("vcr.ttf"), size, FlxColor.WHITE, CENTER);
		bottomText.scrollFactor.set();
		add(bottomText);

		Difficulty.list = Difficulty.defaultList.copy();
		if(lastDifficultyName == '')
		{
			lastDifficultyName = Difficulty.getDefault();
		}
		curDifficulty = Math.round(Math.max(0, Difficulty.defaultList.indexOf(lastDifficultyName)));

		var text:Alphabet = new Alphabet(0, 180, "", true);
		text.screenCenter(X);
		alphabetArray.push(text);
		text.alpha = 0;
		add(text);

		askText = new Alphabet(0, text.y + 200, 'Choose A Side', true);
		//askText.screenCenter(X);
		askText.x = 385;
		askText.y = 0;
		add(askText);

		yesText = new Alphabet(0, text.y + 150, 'Zardy', true);
		yesText.screenCenter(X);
		yesText.x -= 180;
		add(yesText);
		noText = new Alphabet(0, text.y + 150, 'Bambi', true);
		noText.screenCenter(X);
		noText.x += 280;
		add(noText);
		updateOptions();

        scoreBG.y = -167;
		scoreText.y = -167;
	}

	override function update(elapsed:Float)
	{
		bg.alpha += elapsed * 1.5;
		if(bg.alpha > 0.6) bg.alpha = 0.6;

		for (i in 0...alphabetArray.length) {
			var spr = alphabetArray[i];
			spr.alpha += elapsed * 2.5;
		}

		lerpScore = Math.floor(FlxMath.lerp(intendedScore, lerpScore, Math.exp(-elapsed * 24)));
		lerpRating = FlxMath.lerp(intendedRating, lerpRating, Math.exp(-elapsed * 12));

		if (Math.abs(lerpScore - intendedScore) <= 10)
			lerpScore = intendedScore;
		if (Math.abs(lerpRating - intendedRating) <= 0.01)
			lerpRating = intendedRating;

		var ratingSplit:Array<String> = Std.string(CoolUtil.floorDecimal(lerpRating * 100, 2)).split('.');
		if(ratingSplit.length < 2) { //No decimals, add an empty space
			ratingSplit.push('');
		}
		
		while(ratingSplit[1].length < 2) { //Less than 2 decimals in it, add decimals then
			ratingSplit[1] += '0';
		}

		scoreText.text = 'PERSONAL BEST: ' + lerpScore + ' (' + ratingSplit.join('.') + '%)';
		positionHighscore();

		if(controls.UI_LEFT_P || controls.UI_RIGHT_P) {
			FlxG.sound.play(Paths.sound('scrollMenu'), 1);
			onYes = !onYes;
			updateOptions();
		}
		if(controls.RESET){
			FlxG.sound.play(Paths.sound('cancelMenu'), 1);
			if(onYes){
				Highscore.resetSong("larceny-zardy", 1);
				intendedScore = Highscore.getScore("larceny-zardy", 1);
				intendedRating = Highscore.getRating("larceny-zardy", 1);
			}
			else {
			    Highscore.resetSong("larceny-bambi", 1);
				intendedScore = Highscore.getScore("larceny-bambi", 1);
				intendedRating = Highscore.getRating("larceny-bambi", 1);
			}
		}
		if(controls.BACK) {
			FlxG.sound.play(Paths.sound('cancelMenu'), 1);
			close();
			MusicBeatState.switchState(new MainMenuState());
		} else if(controls.ACCEPT) {
			if(onYes) {
			PlayState.storyDifficulty = 1;
			PlayState.isStoryMode = false;
			PlayState.SONG = Song.loadFromJson('larceny-zardy', 'larceny');
            LoadingState.loadAndSwitchState(new PlayState());
			}
			else
			{
			PlayState.storyDifficulty = 1;
			PlayState.isStoryMode = false;
			PlayState.SONG = Song.loadFromJson('larceny-bambi', 'larceny');
            LoadingState.loadAndSwitchState(new PlayState());
			}
		}
		super.update(elapsed);
	}

		private function positionHighscore() {
		scoreText.x = FlxG.width - scoreText.width - -56;
		scoreBG.scale.x = FlxG.width - scoreText.x + 6;
		scoreBG.x = FlxG.width - (scoreBG.scale.x / 2);
	    }

	function updateOptions() {
		var scales:Array<Float> = [0.75, 1];
		var alphas:Array<Float> = [0.6, 1.25];
		var confirmInt:Int = onYes ? 1 : 0;

        if (!onYes)
		{
		intendedScore = Highscore.getScore("larceny-bambi", 1);
		intendedRating = Highscore.getRating("larceny-bambi", 1);
		}

		if (onYes)
		{
		intendedScore = Highscore.getScore("larceny-zardy", 1);
		intendedRating = Highscore.getRating("larceny-zardy", 1);
		}

		yesText.alpha = alphas[confirmInt];
		yesText.scale.set(scales[confirmInt], scales[confirmInt]);
		noText.alpha = alphas[1 - confirmInt];
		noText.scale.set(scales[1 - confirmInt], scales[1 - confirmInt]);
	}
}