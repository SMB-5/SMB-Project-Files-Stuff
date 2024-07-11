local modVersion = "1.0.0"
--local menuKey = 'F1'
local enabled = true

-- You might be able to lazily fix your custom notes not working as intended by setting this on onCreate:
-- setProperty('PlayAsOpponent_ChangeSidesOnCountdown', false)

-- This up here, will make notes change sides on the moment they spawn,
-- instead of changing them all on countdown start

-- You can also manually do the checks yourself with this variable (don't worry, it can never be null):
-- local playAsOpponentEnabled = (getVar('PlayAsOpponent_Enabled') == true)

local blockVersionPrefixes = {'0.3', '0.4', '0.5', '0.6'} --From 0.3.1 (lua implementation update) to 0.6.3
local minimalRecommendedVersion = '0.7'
function onCreate()
	for k, v in pairs(blockVersionPrefixes) do
		if version:find('^'..v:gsub("^%s*(.-)%s*$", "%1")) ~= nil then
			debugPrint("------------------------------------------------------------")
			debugPrint("Minimal recommended version: "..minimalRecommendedVersion)
			debugPrint("Your Version: "..version)
			debugPrint("")
			debugPrint("Your Psych Engine is too outdated to run Play as Opponent!!")
			debugPrint("------------------------------------------------------------")
			close()
			return
		end
	end

	--luaDebugMode = true;
	addHaxeLibrary('Reflect')
	
	initSaveData('PlayAsOpponent_Settings');
	enabled = getDataFromSave('PlayAsOpponent_Settings', 'enabled', true)
	runHaxeCode(getTextFromFile('data/larceny-zardy/modules/HaxeFunctions.hx'), _, 'gimmeMyCallback')
	setVar('PlayAsOpponent_Version', version);
	setVar('PlayAsOpponent_Enabled', enabled);
	setVar('PlayAsOpponent_ChangeSidesOnCountdown', true)
end

local changeOnRuntime = false
function onCountdownStarted()
	if not enabled then
		return
	end

	if not middlescroll then
		for i = 0, getProperty('playerStrums.length') - 1 do
			setProperty('playerStrums.members['..i..'].x', _G['defaultOpponentStrumX'..i])
			setProperty('opponentStrums.members['..i..'].x', _G['defaultPlayerStrumX'..i])
			setOnLuas('defaultPlayerStrumX'..i, getProperty('playerStrums.members['..i..'].x'))
			setOnLuas('defaultOpponentStrumX'..i, getProperty('opponentStrums.members['..i..'].x'))
		end
	end

	for i = 0, getProperty('dadGroup.members.length') - 1 do
		setProperty('dadGroup.members['..i..'].isPlayer', true)
	end
	for i = 0, getProperty('boyfriendGroup.members.length') - 1 do
		setProperty('boyfriendGroup.members['..i..'].isPlayer', false)
		setProperty('boyfriendGroup.members['..i..'].hasMissAnimations', false)
	end

	changeOnRuntime = (getVar('PlayAsOpponent_ChangeSidesOnCountdown') ~= true)
	if not changeOnRuntime then
		local groups = {'notes.members', 'unspawnNotes'}
		for num, group in pairs(groups) do
			for id = 0, getProperty(group..'.length') - 1 do
				invertNote(group, id)
			end
		end
	end
	runHaxeFunction('changeHealthBarFunction');
end

function onSpawnNote(id, data, type, isSustain)
	if not enabled then
		return
	end

	if changeOnRuntime then
		invertNote('notes', id)
	end
end

function invertNote(group, id)
	-- make my own animation logic for note hits
	setPropertyFromGroup(group, id, 'extraData.noAnimation', getPropertyFromGroup(group, id, 'noAnimation'), true)
	setPropertyFromGroup(group, id, 'extraData.noMissAnimation', getPropertyFromGroup(group, id, 'noMissAnimation'), true)
	setPropertyFromGroup(group, id, 'noAnimation', true)
	setPropertyFromGroup(group, id, 'noMissAnimation', true)
	
	-- invert mustPress
	setPropertyFromGroup(group, id, 'mustPress', not getPropertyFromGroup(group, id, 'mustPress'))
end

function onUpdatePost(elapsed)
	if not enabled or inGameOver then
		return
	end

	if getProperty('dad.holdTimer') > stepCrochet * 0.0011 / getPropertyFromClass('flixel.FlxG', 'sound.music.pitch') * getProperty('dad.singDuration') and
	stringStartsWith(getProperty('dad.animation.curAnim.name'), 'sing') and not stringEndsWith(getProperty('dad.animation.curAnim.name'), 'miss') then
		keyIsBeingPressed = false
		for i = 0, getProperty('keysArray.length') do
			if keyPressed(getProperty('keysArray['..i..']')) then
				keyIsBeingPressed = true
				break
			end
		end
		
		if not keyIsBeingPressed then
			characterDance('dad')
		end
	end
end

function onDestroy()
	setPropertyFromClass('backend.ClientPrefs', 'data.ghostTapping', ghostTapping)
end

-- Fake note hits
-- the opponent's hit logic
function opponentNoteHit(note, noteData, noteType, isSustainNote)
	if not enabled then
		return
	end
	
	if getProperty('camZooming') and not camZooming then
		setProperty('camZooming', false)
	end

	if noteType == 'Hey!' and playAnim('boyfriend', 'hey', true) then
		setProperty('boyfriend.specialAnim', true)
		setProperty('boyfriend.heyTimer', 0.6)

		if playAnim('gf', 'cheer', true) then
			setProperty('gf.specialAnim', true)
			setProperty('gf.heyTimer', 0.6)
		end
	elseif getNoteProperty(note, 'noAnimation') then
		local alt = getNoteProperty(note, 'animSuffix')
		local char = 'boyfriend'
		local animToPlay = getProperty('singAnimations['..math.abs(noteData)..']')..alt
		if getNoteProperty(note, 'gfNote') then
			char = 'gf'
		end

		if playAnim(char, animToPlay, true) then
			setProperty(char..'.holdTimer', 0)
		end
	end

	-- Overwriting functions
	local result = callOnLuas('goodNoteHit', {note, noteData, noteType, isSustainNote}, true)
	if version == '0.7' then --retrocompatibility with 0.7
		return Function_StopLua
	end

	if result ~= nil and result ~= Function_StopHScript and result ~= Function_StopAll then
		callNoteFunc('goodNoteHit', note)
	end
	return Function_StopAll
end

-- your hit logic
camZooming = false
function goodNoteHit(note, noteData, noteType, isSustainNote)
	if not enabled then
		return
	end
	
	if songPath ~= 'tutorial' then
		setProperty('camZooming', true)
		camZooming = true
	end

	if noteType == 'Hey!' and playAnim(dad, 'hey', true) then
		setProperty('dad', 'specialAnim', true)
		setProperty('dad', 'heyTimer', 0.6)
	elseif not getNoteExtraData(note, 'noAnimation') then
		local alt = getNoteProperty(note, 'animSuffix')
		if altAnim and not gfSection then
			alt = '-alt'
		end

		local char = 'dad'
		local animToPlay = getProperty('singAnimations['..math.abs(noteData)..']')..alt
		if getNoteProperty(note, 'gfNote') then
			char = 'gf'
		end

		if playAnim(char, animToPlay, true) then
			setProperty(char..'.holdTimer', 0)
		end
	end

	-- Overwriting functions
	local result = callOnLuas('opponentNoteHit', {note, noteData, noteType, isSustainNote}, true)
	if version == '0.7' then --retrocompatibility with 0.7
		return Function_StopLua
	end

	if result ~= nil and result ~= Function_StopHScript and result ~= Function_StopAll then
		callNoteFunc('opponentNoteHit', note)
	end
	return Function_StopAll
end

function noteMiss(id, direction, noteType, isSustainNote)
	if not enabled then
		return
	end
	
	local char = 'dad'
	if id >= 0 and getNoteProperty(id, 'gfNote') then
		char = 'gf'
	end

	if id < 0 or (not getNoteExtraData(id, 'noMissAnimation') and getProperty('dad.hasMissAnimations')) then
		local singDirection = getProperty('singAnimations['..direction..']')
		playAnim(char, singDirection..'miss'..(id >= 0 and getNoteProperty(id, 'animSuffix') or ''), true);
	end
end

local wasStunned = false
function onGhostTap()
	if not enabled then
		return
	end
	
	wasStunned = getProperty('boyfriend.stunned')
	setProperty('boyfriend.stunned', false)
end

function noteMissPress(direction)
	noteMiss(-1, direction, '', false)
end

function onKeyPress(key)
	if not enabled then
		return
	end
	
	setProperty('boyfriend.stunned', wasStunned)
	wasStunned = false
end

-- Options menu
function onUpdate(elapsed)
	if keyboardJustPressed(menuKey) and startedCountdown then
		openCustomSubstate('playOpponent_OptionsMenu', true)
		runHaxeFunction('createMenu', {enabled})
	end
end

function onCustomSubstateUpdate(name, elapsed)
	if name == 'playOpponent_OptionsMenu' then
		if keyboardJustPressed(menuKey) or keyJustPressed('BACK') then
			closeCustomSubstate()
			return;
		end
		runHaxeFunction('updateMenu'--[[, {elapsed}]])
	end
end

function onCustomSubstateDestroy(name)
	if name == 'playOpponent_OptionsMenu' then
		runHaxeFunction('destroyMenu')
	end
end

function togglePlayAsOpponent(enable)
	if enabled ~= enable then
		setDataFromSave('PlayAsOpponent_Settings', 'enabled', enable)
		flushSaveData('PlayAsOpponent_Settings')
		restartSong()
		playSound('scrollMenu', 0.6)
	else
		playSound('cancelMenu', 0.6)
	end
end

-- Funcs
function getNoteExtraData(id, data)
	return getProperty('notes.members['..id..'].extraData.'..data, true)
end

function getNoteProperty(id, data)
	return getProperty('notes.members['..id..'].'..data)
end