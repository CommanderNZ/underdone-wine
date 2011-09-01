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
	
	

--[[
	
		if !entVictim.Data.Challenge or !entAttacker.Data.Challenge then  tblDamageInfo:SetDamage(0) return end

		if entVictim.Data.Challenge.Enemy != entAttacker.Data.Challenge.Enemy then tblDamageInfo:SetDamage(0) return  -- Il ne sont pas en défi

		else
			if entVictim.Data.Challenge.Time != entAttacker.Data.Challenge.Time then 
			
				 entVictim.Data.Challenge.Time = entAttacker.Data.Challenge.Time  -- Syncronisation des date au cas il y a un décalage 
				 
			end
			
		end 

		if os.time - entVictim.Data.Challenge.Time > 600 then tblDamageInfo:SetDamage(0) return  end

		if entVictim.Data.Challenge.Finish == 1 then tblDamageInfo:SetDamage(0) return 

		else

			if entVictim.Data.Challenge.Finish != entAttacker.Data.Challenge.Finish then
			
				 tblDamageInfo:SetDamage(0) return -- Utilisation de fail ! Exemple défier une personne puis une autre enfin a voir ! 
				 
			end
			
		end
		
		getAdjustDamage(entVictim,entInflictor)


]]--



local function getAdujstDamage( entVictim, tblDamageInfo )

	tblDamageInfo:SetDamage(math.Round(tblDamageInfo:GetDamage() * (1 / entVictim:GetNWInt("level"))))	
	
	if math.random(1, math.Round(20 / (1 + (entAttacker:GetStat("stat_luck") / 50)))) == 1 then
	
		tblDamageInfo:SetDamage(math.Round(tblDamageInfo:GetDamage() * 2))
		
		entAttacker:CreateIndacator("Crit!", tblDamageInfo:GetDamagePosition(), "blue", true)
		
		clrDisplayColor = "blue"
		
	end
	
	local clrDisplayColor = "red"
	
	if tblDamageInfo:GetDamage() > 0 then
			
		entVictim:CreateIndacator(tblDamageInfo:GetDamage(), tblDamageInfo:GetDamagePosition(), clrDisplayColor)
		
	else
		
		entVictim:CreateIndacator("Miss!", tblDamageInfo:GetDamagePosition(), "orange")
			
	end

end


local function PlayerDamagePlayer(entVictim, entInflictor, entAttacker, intAmount, tblDamageInfo)

	if !entVictim:IsPlayer() then return end
	
	if !entAttacker:IsPlayer() then return end
	
	print("attack player")
	
end

hook.Add("EntityTakeDamage", "PlayerAdjustDamage", PlayerDamagePlayer)