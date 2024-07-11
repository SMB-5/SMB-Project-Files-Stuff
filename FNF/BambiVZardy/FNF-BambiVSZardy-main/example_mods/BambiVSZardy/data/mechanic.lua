local lol = false
local didcoolthing = false
local position = -1
local gaming = false
local length = 4 
function onCreate()
    makeAnimatedLuaSprite('ZardyWeek2_Vines', 'ZardyWeek2_Vines', 200, 420)
    addAnimationByIndices('ZardyWeek2_Vines', 'ZardyWeek2_Vines', 'Vine Whip instance 1', '0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50')
    addAnimationByIndices('ZardyWeek2_Vines', 'ZardyWeek2_Vines2', 'Vine Whip instance 1', '50,49,48,47,46,45,44,43,42,41,40,39,38,37,36,35,34,33,32,31,30,29,28,27,26,25,24,23,22,21,20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0')
    scaleObject('ZardyWeek2_Vines', 0.9, 0.9);
end
function onEvent(name,value1,value2)
    if name == 'zardy vines' then
            triggerEvent('Change Character', '0', 'bf')
            addLuaSprite('ZardyWeek2_Vines', false)
            runTimer('penericouwu', 1.5);
            playAnim('ZardyWeek2_Vines','ZardyWeek2_Vines',true)
    end
    if name == 'zardy thing' then
        startTheFucking()
        lol = true
end
end
function onTimerCompleted(tag)
    if tag == 'p' then
        removeLuaSprite('ZardyWeek2_Vines', false)
        triggerEvent('Change Character', '0', 'bambi-player') 
    end
    if tag == 'l' then
        setProperty('strumsBlocked', {false, false, false, false}) 
    end
    if tag == 'v' then
        runTimer('p',2.15)
        playAnim('ZardyWeek2_Vines','ZardyWeek2_Vines2',true)

    end
    if tag == '1a' then
        triggerEvent('Play Animation', 'dodge', 'bf')
    end

    if tag == 'penericouwu'  then
        triggerEvent('Play Animation', 'hurt', 'bf')
        triggerEvent('zardy thing', '', '')
        playSound('bf_grabbed_by_vine')
        runTimer('waza', 0.5);
end
if tag == 'waza' then
triggerEvent('Play Animation', 'waza', 'bf')
end
end
function startTheFucking()
    setProperty('strumsBlocked', {true, true, true, true})
    generateShit()
    position = -1
end
function onCreatePost()
    runHaxeCode([[
        grpNotes = [];
        randArray = [];
        daCoolTween = null;
    ]])
end
function generateShit()
    addHaxeLibrary('StrumNote')
    addHaxeLibrary('Note')
    addHaxeLibrary('Std')
    runHaxeCode([=[
        randArray = [for (i in 0...]=]..tostring(length)..[=[) FlxG.random.int(0, 3)];

        for (i in grpNotes) { i.kill(); game.remove(i); i.destroy(); }

        grpNotes = [];

        var colArray = ['purple', 'blue', 'green', 'red'];

        for (i in 0...randArray.length) {
            cool = new StrumNote(0, 0, randArray[i], 0);
            if (!PlayState.isPixelStage) cool.animation.addByPrefix('color', colArray[cool.noteData] + '0', 24, true);
            cool.playAnim('static');
            cool.ID = i;
            cool.scrollFactor.set(1, 1);
            cool.x = game.boyfriend.x + (game.boyfriend.width / 2) - ((Note.swagWidth * randArray.length) / 2);
            cool.x += Note.swagWidth * i;
            cool.y = game.boyfriend.y - Note.swagWidth - 5;
            game.add(cool);
            grpNotes[i] = cool;
        }

        var tag = 'ajgnaidngkjsfohijaoihjpdafgnadjoiashmfmhiobad';

        daCoolTween = FlxTween.num(6.1, 0, 2, { ease: FlxEase.expoOut, onComplete: function(_) {
            if(game.modchartTweens.exists(tag)) {
                game.callOnLuas('onTweenCompleted', [tag]);
                game.modchartTweens.remove(tag);
            } } }, function(num) {
                for (j in grpNotes) {
                    j.x = game.boyfriend.x + (game.boyfriend.width / 2) - ((Note.swagWidth * randArray.length) / 2);
                    j.x += Note.swagWidth * j.ID;
                    j.y = game.boyfriend.y - Note.swagWidth - 5;
                    j.x += FlxG.random.float(-num, num);
                    j.y += FlxG.random.float(-num, num);
                    j.angle = FlxG.random.float(-num / 2, num / 2);
                }
            });

        if(game.modchartTweens.exists(tag)) {
            game.modchartTweens.get(tag).cancel();
            game.modchartTweens.get(tag).destroy();
            game.modchartTweens.remove(tag);
        }
        game.modchartTweens.set(tag, daCoolTween);
        for (j in 0...grpNotes.length) {
            var strum = grpNotes[j];
            strum.playAnim('confirm', true);
            strum.animation.finishCallback = function() {
                if (PlayState.isPixelStage) strum.playAnim(colArray[strum.noteData]);
                else strum.playAnim('color', true);
            }
        }
     

        game.setOnLuas('randArray', randArray);
    ]=])
    didcoolthing = false
    gaming = true
end
function onKeyPress(k)
    if getProperty('health') > 0.05 then
    if randArray ~= nil and #randArray > 0 and gaming then
        if k == randArray[1] then
            position = position + 1
            runHaxeCode([[
                var strum = grpNotes[]]..tostring(position)..[[];
                strum.playAnim('pressed', true);
                strum.resetAnim = 0.15;
            ]])
            table.remove(randArray, 1)
            if #randArray < 1 and not didcoolthing then
                runHaxeCode([[
                    if (daCoolTween != null) daCoolTween.cancel();
                    for (j in grpNotes) {
                        j.acceleration.y = FlxG.random.float(300, 600);
                        j.velocity.y = FlxG.random.float(-200, -300);
                        j.velocity.x = FlxG.random.float(-10, 10);
                        j.angularVelocity = FlxG.random.float(-15, 15);
                        FlxTween.tween(j, { alpha: 0 }, 0.2 / game.playbackRate, {
                            onComplete: function(tween:FlxTween)
                            {
                                j.kill();
                                game.remove(j);
                            },
                            startDelay: Conductor.crochet * 0.002 / game.playbackRate
                        });
                    }
                    game.playerStrums.forEach(function(str) { str.alpha = 1; });
                    game.isCameraOnForcedPos = false;
                    game.moveCameraSection();
                ]])
                playSound('bf_vine_defeat')
                runTimer('v',0.4)
                lol = false
                runTimer('l',1.2)
                if getProperty('health') > 0.1 then
                runTimer('1a',1.1)
                end
                triggerEvent('Play Animation', 'teodiolelux', 'bf')
                didcoolthing = true
                gaming = false
            end
        else
            startTheFucking()
        end
    end
end
end
function onUpdatePost()
    if botPlay and getRandomBool(4) then onKeyPress(randArray[1]) end
end