function onSpawnNote()
	--Iterate over all notes
	for i = 0, getProperty('notes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('notes', i, 'noteType') == 'phone' then
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
	if noteType == 'phone' then
		setPropertyFromGroup('notes', i, 'animSuffix', '-alt')
	end
end

