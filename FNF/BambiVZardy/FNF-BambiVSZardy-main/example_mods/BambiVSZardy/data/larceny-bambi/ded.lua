local allowCountdown = false
function onGameOverStart()
	if not allowCountdown then 
		startVideo('zardyMyBeloved');
		allowCountdown = true;
		return Function_Stop;
	end
	return Function_Continue;
end