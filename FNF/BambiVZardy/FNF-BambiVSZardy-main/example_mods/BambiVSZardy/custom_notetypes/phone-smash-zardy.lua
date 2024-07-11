function onSpawnNote()
	--Iterate over all notes
	for i = 0, getProperty('notes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('notes', i, 'noteType') == 'phone-smash-zardy' then
			setPropertyFromGroup('notes', i, 'texture', 'NOTE_phone'); --Change texture
			setPropertyFromGroup('notes', i, 'rgbShader.enabled', false);
			setPropertyFromGroup('notes', i, 'noteSplashData.disabled', true);
			--setPropertyFromGroup('unspawnNotes', i, 'scale.x', 0.60) 
			--setPropertyFromGroup('unspawnNotes', i, 'scale.y', 0.60)
           	setPropertyFromGroup('notes', i, 'offsetX', 20);
			   setPropertyFromGroup('notes', i, 'animSuffix', '-alt')

		   if getPropertyFromGroup('notes', i, 'isSustainNote') then
				setPropertyFromGroup('notes', i, 'offset.x', '-5')
			end

			if getPropertyFromGroup('notes', i, 'mustPress') == true then --Lets Opponent's instakill notes get ignored
				setPropertyFromGroup('notes', i, 'ignoreNote', false); --Miss has no penalties
			else
				setPropertyFromGroup('notes', i, 'ignoreNote', false);
			end
		end
	end
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'phone-smash-zardy' then
		setPropertyFromGroup('notes', i, 'animSuffix', '-alt')
		playAnim('boyfriend', 'singThrow', true)
		setProperty('boyfriend.specialAnim', true)
	end
end

function noteMiss(id, noteData, noteType, isSustainNote)
	if noteType == 'phone-smash-zardy' then
		playAnim('boyfriend', 'singThrow', true)
		setProperty('boyfriend.specialAnim', true)
		if noteData == 0 then
			noteTweenAlpha('bye1', 4, 0, 0.30, 'linear')
			runTimer('hi1', 2)
		elseif noteData == 1 then
			noteTweenAlpha('bye2', 5, 0, 0.30, 'linear')
			runTimer('hi2', 2)
		elseif noteData == 2 then
			noteTweenAlpha('bye3', 6, 0, 0.30, 'linear')
			runTimer('hi3', 2)
		elseif noteData == 3 then
			noteTweenAlpha('bye4', 7, 0, 0.30, 'linear')
			runTimer('hi4', 2)
		end
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'hi1' then
		noteTweenAlpha('hi1', 4, 1, 0.30, 'linear')
	end
	if tag == 'hi2' then
		noteTweenAlpha('hi2', 5, 1, 0.30, 'linear')
	end
	if tag == 'hi3' then
		noteTweenAlpha('hi3', 6, 1, 0.30, 'linear')
	end
	if tag == 'hi4' then
		noteTweenAlpha('hi4', 7, 1, 0.30, 'linear')
	end
	if tag == 'bruh' then
	triggerEvent('Change Character', 'dad', 'zardyMyBeloved-zardy')
	end
end