    ///////////////////////////////////////////////////////////////////////////////////////
    //  _    _           _              _                   __          ___              //
    // | |  | |         | |            | |                  \ \        / (_)             //
    // | |  | |_ __   __| | ___ _ __ __| | ___  _ __   ___   \ \  /\  / / _ _ __   ___   //
    // | |  | | '_ \ / _` |/ _ \ '__/ _` |/ _ \| '_ \ / _ \   \ \/  \/ / | | '_ \ / _ \  //
    // | |__| | | | | (_| |  __/ | | (_| | (_) | | | |  __/    \  /\  /  | | | | |  __/  //
    //  \____/|_| |_|\__,_|\___|_|  \__,_|\___/|_| |_|\___|     \/  \/   |_|_| |_|\___|  //
    //                                                                                   //
    //       Last edit : Sandros Batman06                                                //
    //                                                                                   //
    ///////////////////////////////////////////////////////////////////////////////////////
	
	

local function PlayerAdjustDamage (entVictim, entInflictor, entAttacker, intAmount, tblDamageInfo)

if !entVictim.Data.Challenge then return end

if !entAttacker.Data.Challenge then return end

if entVictim.Data.Challenge.Enemy != entAttacker.Data.Challenge.Enemy then return  -- Il ne sont pas en défi

else
	if entVictim.Data.Challenge.Time != entAttacker.Data.Challenge.Time then 
	
		 entVictim.Data.Challenge.Time = entAttacker.Data.Challenge.Time  -- Syncronisation des date au cas il y a un décalage 
		 
	end
	
end 

if os.time - entVictim.Data.Challenge.Time > 600 then return end

if entVictim.Data.Challenge.Finish == 1 then return

else

	if entVictim.Data.Challenge.Finish != entAttacker.Data.Challenge.Finish then
	
		 return -- Utilisation de fail ! Exemple défier une personne puis une autre enfin a voir ! 
		 
	end
	
end

end

hook.Add("EntityTakeDamage", "PlayerAdjustDamage", PlayerAdjustDamage)