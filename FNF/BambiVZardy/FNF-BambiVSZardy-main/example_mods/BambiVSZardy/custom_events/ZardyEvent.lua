local grabbed = false
local indices = {57, 56, 55, 54, 53, 52, 51, 50, 49, 48, 47, 46, 45, 44, 43, 42, 41, 40, 39, 38, 37, 36, 35, 34, 33, 32, 31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0}

-- keyGetter getPropertyFromClass('flixel.FlxG', 'keys.justPressed.?')
function onCreate()
	--variables--
	py = getProperty('boyfriend.y') - 150
	px = getProperty('boyfriend.x')
	pxb = getProperty('boyfriend.x') + 100
	pxc = getProperty('boyfriend.x') + 200
	pxd = getProperty('boyfriend.x') + 300
	k1 = 'n/a'
	k2 = 'n/a'
	k3 = 'n/a'
	k4 = 'n/a'
	stun = false
	finished = false
	counter = 0;
	
	makeAnimatedLuaSprite('ZardyWeek2_Vines', 'ZardyWeek2_Vines', 570, 440)
    addAnimationByIndices('ZardyWeek2_Vines', 'ZardyWeek2_Vines', 'Vine Whip instance 1', '0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50')
    addAnimationByIndices('ZardyWeek2_Vines', 'ZardyWeek2_Vines2', 'Vine Whip instance 1', '50,49,48,47,46,45,44,43,42,41,40,39,38,37,36,35,34,33,32,31,30,29,28,27,26,25,24,23,22,21,20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0')
    scaleObject('ZardyWeek2_Vines', 0.9, 0.9);
	
	--sprites--
	--key1
	makeLuaSprite('arrow1', 'zardy/arrow1', px, py);
	makeLuaSprite('arrow2', 'zardy/arrow2', px, py);
	makeLuaSprite('arrow3', 'zardy/arrow3', px, py);
	makeLuaSprite('arrow4', 'zardy/arrow4', px, py);
	--key2
	makeLuaSprite('arrowb1', 'zardy/arrow1', pxb, py);
	makeLuaSprite('arrowb2', 'zardy/arrow2', pxb, py);
	makeLuaSprite('arrowb3', 'zardy/arrow3', pxb, py);
	makeLuaSprite('arrowb4', 'zardy/arrow4', pxb, py);
	--key3
	makeLuaSprite('arrowc1', 'zardy/arrow1', pxc, py);
	makeLuaSprite('arrowc2', 'zardy/arrow2', pxc, py);
	makeLuaSprite('arrowc3', 'zardy/arrow3', pxc, py);
	makeLuaSprite('arrowc4', 'zardy/arrow4', pxc, py);
	--key4
	makeLuaSprite('arrowd1', 'zardy/arrow1', pxd, py);
	makeLuaSprite('arrowd2', 'zardy/arrow2', pxd, py);
	makeLuaSprite('arrowd3', 'zardy/arrow3', pxd, py);
	makeLuaSprite('arrowd4', 'zardy/arrow4', pxd, py);
	
	
	--new sprite system
	addLuaSprite('arrow1', true);
	addLuaSprite('arrow2', true);
	addLuaSprite('arrow3', true);
	addLuaSprite('arrow4', true);
	
	addLuaSprite('arrowb1', true);
	addLuaSprite('arrowb2', true);
	addLuaSprite('arrowb3', true);
	addLuaSprite('arrowb4', true);
	
	addLuaSprite('arrowc1', true);
	addLuaSprite('arrowc2', true);
	addLuaSprite('arrowc3', true);
	addLuaSprite('arrowc4', true);
	
	addLuaSprite('arrowd1', true);
	addLuaSprite('arrowd2', true);
	addLuaSprite('arrowd3', true);
	addLuaSprite('arrowd4', true);
	
	setProperty('arrow1.visible', false);
	setProperty('arrow2.visible', false);
	setProperty('arrow3.visible', false);
	setProperty('arrow4.visible', false);
	
	setProperty('arrowb1.visible', false);
	setProperty('arrowb2.visible', false);
	setProperty('arrowb3.visible', false);
	setProperty('arrowb4.visible', false);
	
	setProperty('arrowc1.visible', false);
	setProperty('arrowc2.visible', false);
	setProperty('arrowc3.visible', false);
	setProperty('arrowc4.visible', false);
	
	setProperty('arrowd1.visible', false);
	setProperty('arrowd2.visible', false);
	setProperty('arrowd3.visible', false);
	setProperty('arrowd4.visible', false);

	scaleObject('arrow1', 0.5, 0.5);
	scaleObject('arrow2', 0.5, 0.5);
	scaleObject('arrow3', 0.5, 0.5);
	scaleObject('arrow4', 0.5, 0.5);

	scaleObject('arrowb1', 0.5, 0.5);
	scaleObject('arrowb2', 0.5, 0.5);
	scaleObject('arrowb3', 0.5, 0.5);
	scaleObject('arrowb4', 0.5, 0.5);

	scaleObject('arrowc1', 0.5, 0.5);
	scaleObject('arrowc2', 0.5, 0.5);
	scaleObject('arrowc3', 0.5, 0.5);
	scaleObject('arrowc4', 0.5, 0.5);

	scaleObject('arrowd1', 0.5, 0.5);
	scaleObject('arrowd2', 0.5, 0.5);
	scaleObject('arrowd3', 0.5, 0.5);
	scaleObject('arrowd4', 0.5, 0.5);
end

function onEvent(n, v1, v2)
	if n == 'ZardyEvent' and stun == false then

	grabThatMF()

	--cameraFlash('other', '0xFFFFFF', '0.2');
	
	elseif n == 'ZardyEvent' and stun == true then
		setProperty('health', -500);
	end
end

function hidePrevious()
	setProperty(k1v, false);
	setProperty(k2v, false);
	setProperty(k3v, false);
	setProperty(k4v, false);
end

function showArrows()
	setProperty(k1v, true);
	setProperty(k2v, true);
	setProperty(k3v, true);
	setProperty(k4v, true);
	--debugPrint(k1v);
end

function startPressin()
	setProperty('strumsBlocked', {true, true, true, true}) 
	triggerEvent('Screen Shake', '', '0.1, 0.009');
	stun = true;
	finished = false;
end

function heDone()
	counter = 0;
	stun = false;
	finished = false;
	setProperty('boyfriend.stunned', false);
	characterPlayAnim('boyfriend', 'axe', true);
	playSound('bf_vine_defeat')
	runTimer('flush2', 0.4)
	setProperty('boyfriend.specialAnim', true);
	setProperty('strumsBlocked', {false, false, false, false}) 
	hidePrevious()
end

function onTimerCompleted(tag)
	if tag == 'grab' then

		if botPlay then
			heDone()
			playSound('bf_grabbed_by_vine')
		end

		characterPlayAnim('boyfriend', 'heldByVine', true);
		setProperty('boyfriend.specialAnim', true);
		playSound('bf_grabbed_by_vine')
		k1 = string.format('arrow%i', getRandomInt(1, 4, true));
		k2 = string.format('arrowb%i', getRandomInt(1, 4, true));
		k3 = string.format('arrowc%i', getRandomInt(1, 4, true));
		k4 = string.format('arrowd%i', getRandomInt(1, 4, true));
	
		k1v = (k1..'.visible')
		k2v = (k2..'.visible')
		k3v = (k3..'.visible')
		k4v = (k4..'.visible')
	
		--debugPrint(k1..' '.. k2 ..' '.. k3 ..' '.. k4 )
	
		hidePrevious();
		showArrows();
		startPressin();
	end

	if tag == 'flush' then
		--characterPlayAnim('boyfriend', 'dodge', true);
		--setProperty('boyfriend.specialAnim', true);
		playAnim('ZardyWeek2_Vines','ZardyWeek2_Vines2',true)
		runTimer('flush3', 0.88)
	end

	if tag == 'flush2' then
		playSound('bf_axe_chop')
		runTimer('flush', 0.09)
	end

	if tag == 'flush4' then
		removeLuaSprite('ZardyWeek2_Vines', false)
	end

	if tag == 'flush3' then
		characterPlayAnim('boyfriend', 'idle', true);
		setProperty('boyfriend.specialAnim', true);
		runTimer('flush4', 1.23)
		--setProperty('vine.alpha', 0)
	end
end

function onUpdatePost()
	--KEY 1
	if stun == true and k1 == 'arrow1' and counter == 0 and keyJustPressed('left') then
	counter = (counter + 1)
	setProperty(k1v, false);
	
	elseif stun == true and k1 == 'arrow2' and counter == 0 and keyJustPressed('down') then
	counter = (counter + 1)
	setProperty(k1v, false);
	
	elseif stun == true and k1 == 'arrow3' and counter == 0 and keyJustPressed('up') then
	counter = (counter + 1)
	setProperty(k1v, false);
	
	elseif stun == true and k1 == 'arrow4' and counter == 0 and keyJustPressed('right') then
	counter = (counter + 1)
	setProperty(k1v, false);
	
	--KEY 2
	elseif stun == true and k2 == 'arrowb1' and counter == 1 and keyJustPressed('left') then
	counter = (counter + 1)
	setProperty(k2v, false);
	
	elseif stun == true and k2 == 'arrowb2' and counter == 1 and keyJustPressed('down') then
	counter = (counter + 1)
	setProperty(k2v, false);
	
	elseif stun == true and k2 == 'arrowb3' and counter == 1 and keyJustPressed('up') then
	counter = (counter + 1)
	setProperty(k2v, false);
	
	elseif stun == true and k2 == 'arrowb4' and counter == 1 and keyJustPressed('right') then
	counter = (counter + 1)
	setProperty(k2v, false);
	
	
	--KEY 3
	elseif stun == true and k3 == 'arrowc1' and counter == 2 and keyJustPressed('left') then
	counter = (counter + 1)
	setProperty(k3v, false);
	
	elseif stun == true and k3 == 'arrowc2' and counter == 2 and keyJustPressed('down') then
	counter = (counter + 1)
	setProperty(k3v, false);
	
	elseif stun == true and k3 == 'arrowc3' and counter == 2 and keyJustPressed('up') then
	counter = (counter + 1)
	setProperty(k3v, false);
	
	elseif stun == true and k3 == 'arrowc4' and counter == 2 and keyJustPressed('right') then
	counter = (counter + 1)
	setProperty(k3v, false);
	
	
	--KEY 4 (FINAL KEY)
	elseif stun == true and k4 == 'arrowd1' and counter == 3 and keyJustPressed('left') then
	counter = (counter + 1)
	setProperty(k4v, false);
	finished = true;
	
	elseif stun == true and k4 == 'arrowd2' and counter == 3 and keyJustPressed('down') then
	counter = (counter + 1)
	setProperty(k4v, false);
	finished = true;
	
	elseif stun == true and k4 == 'arrowd3' and counter == 3 and keyJustPressed('up') then
	counter = (counter + 1)
	setProperty(k4v, false);
	finished = true;
	
	elseif stun == true and k4 == 'arrowd4' and counter == 3 and keyJustPressed('right') then
	counter = (counter + 1)
	setProperty(k4v, false);
	finished = true;
	
	elseif finished == true then
	heDone();
	end
end

function grabThatMF()
	grabbed = true
	--debugPrint("IM GRABBING THAT MF");
	addLuaSprite('ZardyWeek2_Vines', false)
	playAnim('ZardyWeek2_Vines','ZardyWeek2_Vines',true)
	--debugPrint("playin grab");

	runTimer('grab', 1.55)
end
