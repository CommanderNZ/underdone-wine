    ///////////////////////////////////////////////////////////////////////////////////////
    //  _    _           _              _                   __          ___              //
    // | |  | |         | |            | |                  \ \        / (_)             //
    // | |  | |_ __   __| | ___ _ __ __| | ___  _ __   ___   \ \  /\  / / _ _ __   ___   //
    // | |  | | '_ \ / _` |/ _ \ '__/ _` |/ _ \| '_ \ / _ \   \ \/  \/ / | | '_ \ / _ \  //
    // | |__| | | | | (_| |  __/ | | (_| | (_) | | | |  __/    \  /\  /  | | | | |  __/  //
    //  \____/|_| |_|\__,_|\___|_|  \__,_|\___/|_| |_|\___|     \/  \/   |_|_| |_|\___|  //
    //                                                                                   //
    //       Last edit : Batman06                                                        //
    //                                                                                   //
    ///////////////////////////////////////////////////////////////////////////////////////
	

function GM:ChangeMapTimed(strNewMap, intChangeTime)

	intChangeTime = intChangeTime or 10
	GAMEMODE.StopSaving = true
	
	for _, ply in pairs(player.GetAll()) do
	
		if ValidEntity(ply) then
		
			ply:CreateNotification("Saving Accounts")
			ply:SaveGame()
			ply:CreateNotification("Server changing map to " .. strNewMap .. " in " .. intChangeTime .. " seconds")
			
			for i = 1, intChangeTime do
			
				timer.Simple(i, function() ply:CreateNotification(tostring(intChangeTime - (i - 1)) .. " ...") end)
				
			end
			
		end
		
	end
	
	timer.Simple(intChangeTime, function() game.ConsoleCommand("changelevel " .. strNewMap .. "\n") end)
	
end

concommand.Add("UD_Admin_ChangeMap", function(ply, command, args) 

	if ply:IsAdmin() && args[1] then
	
		local strNewMap = args[1]
		local intChangeTime = args[2] || 10
		
		GAMEMODE:ChangeMapTimed(strNewMap, intChangeTime)
		
	end
	
end)

function GM:AdminBackup()

	for _, ply in pairs(player.GetAll()) do
	
		local strSteamID = string.Replace(ply:SteamID(), ":", "!")
		
		if strSteamID != "STEAM_ID_PENDING" then
		
			local strFileName = "UnderDone/" .. strSteamID .. ".txt"
			local tblSaveTable = table.Copy(ply.Data)
			
			tblSaveTable.Inventory = {}
			
			--Polkm: Space saver loop
			for strItem, intAmount in pairs(ply.Data.Inventory or {}) do
			
				if intAmount > 0 then tblSaveTable.Inventory[strItem] = intAmount end
				
			end
			
			tblSaveTable.Bank = {}
			
			for strItem, intAmount in pairs(ply.Data.Bank or {}) do
			
				if intAmount > 0 then tblSaveTable.Bank[strItem] = intAmount end
				
			end
			
			tblSaveTable.Quests = {}
			
			for strQuest, tblInfo in pairs(ply.Data.Quests or {}) do
			
				if tblInfo.Done then
				
					tblSaveTable.Quests[strQuest] = {Done = true}
					
				else
				
					tblSaveTable.Quests[strQuest] = tblInfo
					
				end
				
			end
			
			tblSaveTable.Exp = ply:GetNWInt("exp")
			
			file.Write(strFileName, Json.Encode(tblSaveTable))
			
			ply:ChatPrint("Admin has saved a backup of player data")
			
		end
		
	end
	
end

concommand.Add("UD_Admin_SaveBackup", function(ply, command, args)
 
	local tblRow = db.GetBySteamID(ply:SteamID())
	
	if ply:IsAdmin() then
	
		GAMEMODE:AdminBackup()
		
	end
	
end)

function GM:AdminSetUsergroup(args)

	local player = player.GetByID(args[1])
	
	player.Data.Usergroup = args[2]
	
	player:SetUserGroup(args[2])
	
	player:SaveGame()
	
end
concommand.Add("UD_Admin_SetUserGroup", function(ply, command, args)

	local tblRow = db.GetBySteamID(ply:SteamID())
	
	if ply:IsSuperAdmin() then
	
		if !args && !args[1] then return end
		
		if !args[2] then return end
		
		GAMEMODE:AdminSetUsergroup(args)
		
	end
	
end)
