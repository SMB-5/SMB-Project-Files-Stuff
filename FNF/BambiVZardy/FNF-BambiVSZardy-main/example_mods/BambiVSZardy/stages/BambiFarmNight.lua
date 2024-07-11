function onCreate()

	makeLuaSprite('sky','sky_night', -300,-150)
	addLuaSprite('sky',false)
	scaleObject('sky', 1, 1)
	setScrollFactor('sky', 0.4, 0.4);

	makeLuaSprite('house','gm_flatgrass', 400,50)
	addLuaSprite('house',false)
	scaleObject('house', 0.5, 0.5)
	setScrollFactor('house', 0.6, 0.6);

	makeLuaSprite('hills','orangey hills', 0, 130)
	addLuaSprite('hills',false)
	setScrollFactor('hills', 0.8, 0.8);

	makeLuaSprite('farm','funfarmhouse', 400,150)
	addLuaSprite('farm',false)
	setScrollFactor('farm', 0.8, 0.8);

	makeLuaSprite('farmlandbackground','grass lands',-320, 470)
	addLuaSprite('farmlandbackground',false)

	makeLuaSprite('fence1','cornFence', -150,170)
	addLuaSprite('fence1',false)

	makeLuaSprite('fence2','cornFence2', 1400,170)
	addLuaSprite('fence2',false)

	makeLuaSprite('sign','sign', 240, 320)
	addLuaSprite('sign',false)

	makeLuaSprite('corn','cornbag',1500, 520)
	addLuaSprite('corn',false)

	makeLuaSprite('farmlandnightoverlay','splitathonoverlay',-400,-1600)
	addLuaSprite('farmlandnightoverlay',true)

	scaleObject('farmlandnightoverlay', 3, 3)

end

function onBeatHit( ... )--for every beat
   -- body
end

function onStepHit( ... )--for every step
	-- body
end

function onUpdate( ... )
	-- body
end