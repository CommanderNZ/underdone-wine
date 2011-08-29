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

	if !entVictim.Data.Challenge then return end

	if !entAttacker.Data.Challenge then return end

	if entVictim.Data.Challenge.Enemy != entAttacker.Data.Challenge.Enemy then return  -- Il ne sont pas en d�fi

	else
		if entVictim.Data.Challenge.Time != entAttacker.Data.Challenge.Time then 
		
			 entVictim.Data.Challenge.Time = entAttacker.Data.Challenge.Time  -- Syncronisation des date au cas il y a un d�calage 
			 
		end
		
	end 

	if os.time - entVictim.Data.Challenge.Time > 600 then return end

	if entVictim.Data.Challenge.Finish == 1 then return

	else

		if entVictim.Data.Challenge.Finish != entAttacker.Data.Challenge.Finish then
		
			 return -- Utilisation de fail ! Exemple d�fier une personne puis une autre enfin a voir ! 
			 
		end
		
	end

]]--


function GM:PlayerDeath(victim, weapon, killer)
		
		victim:Freeze(true)
		timer.Simple(10, function()
			
			if ValidEntity(victim) then
				
				victim:Freeze(false) 
				victim:ConCommand("+attack")
				timer.Simple(0.1, function() if ValidEntity(victim) then victim:ConCommand("-attack") end end)
			
			end
		end)
		if killer:IsNPC() && victim:IsPlayer() then
			
			if killer.Race == victim.Race then
				
				killer:AddEntityRelationship(victim, GAMEMODE.RelationLike, 99)
			end
		end
	end
	
	
local function PlayerAdjustDamage(entVictim, entInflictor, entAttacker, intAmount, tblDamageInfo)
	
	if !entVictim:IsPlayer() then return end
	
	if !entAttacker:IsPlayer() && entAttacker:GetOwner():IsPlayer() then
		
		entAttacker = entAttacker:GetOwner()
		
	end
	
	local clrDisplayColor = "red"
	local tblNPCTable = NPCTable(entAttacker:GetNWString("npc"))
	
	if entAttacker:IsPlayer() then
		
		tblDamageInfo:SetDamage(0)
	end
	
	if tblNPCTable then
		
		for strNPC,_ in pairs(GAMEMODE.DataBase.NPCs or {}) do
			
			local tblNPCTable = NPCTable(strNPC)
			
			if tblNPCTable.DamageCallBack && entVictim && entAttacker.Name && entAttacker.Name ==  tblNPCTable.Name then
				
				tblNPCTable:DamageCallBack(entAttacker, entVictim)
			end
		end
		
		tblDamageInfo:SetDamage((tblNPCTable.DamagePerLevel or 0) * entAttacker:GetNWInt("level"))
		tblDamageInfo:SetDamage(tblDamageInfo:GetDamage() * (1 / (((entVictim:GetArmorRating() - 1) / 10) + 1)))
		tblDamageInfo:SetDamage(math.Clamp(math.Round(tblDamageInfo:GetDamage() + math.random(-1, 1)), 0, 9999))
		
		if tblNPCTable.Race == "human" then tblDamageInfo:SetDamage(0) end
		
		if tblDamageInfo:GetDamage() > 0 then
			
			entVictim:CreateIndacator(tblDamageInfo:GetDamage(), tblDamageInfo:GetDamagePosition(), clrDisplayColor)
		else
			
			entVictim:CreateIndacator("Miss!", tblDamageInfo:GetDamagePosition(), "orange")
		end
	end		
end
hook.Add("EntityTakeDamage", "PlayerAdjustDamage", PlayerAdjustDamage)