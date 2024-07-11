import haxe.Int32;

// Switch Menu
var screen:FlxSprite;
var text:Alphabet;
var textEnabled:Alphabet;
var textDisabled:Alphabet;
var hoverOn:Bool = true;
function createMenu(enabled:Bool)
{
	screen = new FlxSprite();
	screen.makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
	screen.cameras = [game.camOther];
	screen.scrollFactor.set();
	screen.alpha = 0;
	FlxTween.tween(screen, {alpha: 0.6}, 0.5, {ease: FlxEase.sineOut});
	game.add(screen);

	text = new Alphabet(FlxG.width/2, 220, '', true);
	text.cameras = [game.camOther];
	text.setAlignmentFromString('Centered');
	text.scrollFactor.set();
	text.text = 'Toggle\nPlay as Opponent';
	game.add(text);

	textEnabled = new Alphabet(FlxG.width / 2 - 175, 420, '', true);
	textEnabled.cameras = [game.camOther];
	textEnabled.setAlignmentFromString('Centered');
	textEnabled.scrollFactor.set();
	textEnabled.text = 'On';
	game.add(textEnabled);
	
	textDisabled = new Alphabet(FlxG.width / 2 + 175, 420, '', true);
	textDisabled.cameras = [game.camOther];
	textDisabled.setAlignmentFromString('Centered');
	textDisabled.scrollFactor.set();
	textDisabled.text = 'Off';
	game.add(textDisabled);

	hoverOn = enabled;
	updateHover();
}

function destroyMenu()
{
	game.remove(screen);
	game.remove(text);
	game.remove(textEnabled);
	game.remove(textDisabled);
	screen.destroy();
	text.destroy();
	textEnabled.destroy();
	textDisabled.destroy();
}

function updateMenu(/*elapsed:Float*/)
{
	if (game.controls.UI_LEFT_P || game.controls.UI_RIGHT_P)
	{
		hoverOn = !hoverOn;
		updateHover();
	}
	
	if(game.controls.ACCEPT)
		parentLua.call('togglePlayAsOpponent', [hoverOn]);
}

function updateHover()
{
	textEnabled.alpha = hoverOn ? 1 : 0.4;
	textDisabled.alpha = !hoverOn ? 1 : 0.4;
	
	textEnabled.scale.set(1.0, 1.0);
	textDisabled.scale.set(1.0, 1.0);
	if (!hoverOn)
		textEnabled.scale.set(0.75, 0.75);
	else
		textDisabled.scale.set(0.75, 0.75);
	FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
}

// Other callbacks
function changeHealthBarFunction()
{
	game.healthBar.valueFunction = function() return 2 - game.health;
}

function gimmeMyCallback()
{
	createCallback('callNoteFunc', function(name:String, id:Int) {
		if(game.callOnHScript != null) //null checking for 0.7 compatibility
			game.callOnHScript(name, [game.notes.members[id]]);
	});
}