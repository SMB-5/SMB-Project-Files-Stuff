function onCreate()

    makeLuaSprite('black', 'timerBar', 297.5, 22)
    makeLuaSprite('gray', 'gray', 303, 25.25)
    makeLuaSprite('green', 'greenreal', 303, 25.25)
    
    addLuaSprite('black', true)
    addLuaSprite('gray', true)
    addLuaSprite('green', true)
    
    setObjectCamera('black', 'hud')
    setObjectCamera('gray', 'hud')
    setObjectCamera('green', 'hud')
    
    scaleObject('black', 1.11, 1.11)
    scaleObject('gray', 1.965, .035)
    scaleObject('green', 1.965, .035)
    
    setProperty('timeBarBG.visible', false)
    setProperty('timeBar.visible', false)
    setProperty('black.alpha', 0)
    setProperty('gray.alpha', 0)
    setProperty('green.alpha', 0)
    setObjectOrder('black', 20)

    screenCenter("black", 'x')
    screenCenter("gray", 'x')
    screenCenter("green", 'x')

    setProperty('camZooming', true)

    if not downscroll then
        setProperty('black.y', getProperty('black.y')-1.5)
    end
end

function onCreatePost()
    makeLuaSprite('healthbaralt','healthBar2',getProperty('healthBar.bg.x'),getProperty('healthBar.bg.y'))
	addLuaSprite('healthbaralt', true)
	setObjectCamera('healthbaralt','camHUD')
	setObjectOrder('healthbaralt', getObjectOrder('healthBar'))

    setProperty('cameraSpeed', 2)

    setProperty('timeBarBG.visible', false)
    setProperty('timeBar.visible', false)
    setProperty('timeTxt.visible', true)
    setProperty('scoreTxt.visible', true)
    setProperty('healthBar.bg.visible', true)
    setTextFont('scoreTxt', 'comic.ttf')
    setTextFont('timeTxt', 'comic.ttf')
    if downscroll then
        setProperty('timeTxt.y', 670)
    else
        setProperty('timeTxt.y', 5)
    end
end

function onUpdate()
    scaleObject('green', 1.965 * getProperty("songPercent"), .035)

    if downscroll then -- downscroll only
        setProperty('black.y', 685)
        setProperty('gray.y', 690)
        setProperty('green.y', 690)
    end
end

function onSongStart()
    if timeBarType ~= 'Disabled' then
    setProperty('black.alpha', 1)
    setProperty('gray.alpha', 1)
    setProperty('green.alpha', 1)
--    runHaxeCode([[ <-- Focus application to always be on top
--		Application.current.window.focus();
--    ]])
end
end

function onStartCountdown()
    if songName == 'Blocked' or songName == 'Corn-Theft' or songName == 'Maze' or songName == 'Shredder' or songName == 'popcorn' or songName == 'Mealie' or songName == 'Indignancy' or songName == 'Screwed' or songName == 'Supernovae' or songName == 'Glitch' or songName == 'Master' or songName == 'Cheating' or songName == 'Unfairness' then
        setProperty('introSoundsSuffix', '-bambi')
    end
    if songName == 'Warmup' or songName == 'House' or songName == 'Insanity' or songName == 'Polygonized' or songName == 'Furiosity' or songName == 'Splitathon' or songName == 'Interdimensional' or songName == 'Rano' then
        setProperty('introSoundsSuffix', '-dave')
    end
end


function onStepHit()
    if curStep % 2 == 0 then
        if mustHitSection == true then
            cameraSetTarget('boyfriend')
        elseif mustHitSection == false then
            cameraSetTarget('dad')
        end
    end
end