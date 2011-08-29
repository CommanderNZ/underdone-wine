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
	
local function PlayerAdjustDamage(entVictim, entInflictor, entAttacker, intAmount, tblDamageInfo)
	
	if !entVictim:IsPlayer() then tblDamageInfo:SetDamage(0)  end
	
	if !entAttacker:IsPlayer() && entAttacker:GetOwner():IsPlayer() then
		
		entAttacker = entAttacker:GetOwner()
		
	end
	
	local clrDisplayColor = "red"
	local tblNPCTable = NPCTable(entAttacker:GetNWString("npc"))
	
	if entAttacker:IsPlayer() then
	
		if !entVictim.Data.Challenge and !entAttacker.Data.Challenge then return tblDamageInfo:SetDamage(0)  end

		if entVictim.Data.Challenge.Enemy != entAttacker.Data.Challenge.Enemy then tblDamageInfo:SetDamage(0)   -- Il ne sont pas en défi

		else
			if entVictim.Data.Challenge.Time != entAttacker.Data.Challenge.Time then 
			
				 entVictim.Data.Challenge.Time = entAttacker.Data.Challenge.Time  -- Syncronisation des date au cas il y a un décalage 
				 
			end
			
		end 

		if os.time - entVictim.Data.Challenge.Time > 600 then tblDamageInfo:SetDamage(0)  end

		if entVictim.Data.Challenge.Finish == 1 then tblDamageInfo:SetDamage(0) 

		else

			if entVictim.Data.Challenge.Finish != entAttacker.Data.Challenge.Finish then
			
				 tblDamageInfo:SetDamage(0)  -- Utilisation de fail ! Exemple défier une personne puis une autre enfin a voir ! 
				 
			end
			
		end
		
		getAdjustDamage(entVictim,entInflictor)
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