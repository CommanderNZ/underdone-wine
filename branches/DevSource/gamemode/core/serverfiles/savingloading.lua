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
	
local Player = FindMetaTable("Player")


DB = {}
DB.elem = { ["Id"] = "",
			["Sid"] = "STEAM_ID_PENDING",
			["Name"] = "",
			["Model"] = "",
			["Inventory"] = "",
			["Bank"] = "",
			["Quests"] = "",
			["Friends"] = "",
			["Exp"] = ""
			}
			
function checkTable(Table)
	for k,v in pairs(DB.elem) do
		for ki,vi in pairs(Table) do
		
			if ki == k then
				Table[ki] = vi
			else
				Table[ki] = v
			end
		end
	end
	return Table
end

if !ValidEntity(GM.Config) then GM.Config = {} or GM.Config end
	
if !ValidEntity(GM.Config.DB) then GM.Config.DB = {} or GM.Config.DB end
	
if !ValidEntity(GM.Config.DB.Type) then GM.Config.DB.Type = "sqllite" or GM.Config.DB.Type end
	
if GM.Config.DB.Type == "sqllite" then
	
	DB.send = function(Table, Player)

		Table = checkTable(Table)
		if sql.Query('SELECT Id WHERE Sid = `' .. Player .. '`') then
			sql.Query('UPDATE ud_player SET `Name` = `' .. Player:Nick() .. '`, `Model` = `' .. Table.Model .. '`, `Inventory` = `' .. Table.Inventory .. '`, `Bank` = `' .. Table.Bank .. '`, `Quests` = `' .. Table.Quests .. '`, `Friends` = `' .. Table.Friends .. '`, `Exp` = `' .. Player:GetNWInt("exp") .. '` WHERE Sid = `' .. Player .. '`')
		else
			sql.Query('INSERT INTO ud_player (`Sid`, `Name`, `Model`, `Inventory`, `Bank`, `Quests`, `Friends`, `Exp`) VALUES(`' .. Player:Nick() .. '`, `' .. Table.Model .. '`, `' .. Table.Inventory .. '`, `' .. Table.Bank .. '`, `' .. Table.Quests .. '`, `' .. Table.Friends .. '`,  `' .. Player:GetNWInt("exp") .. '`)')
		end
		
	end
	
elseif GM.Config.GM.Type == "txt" then
	
	DB.send = function(Table)
	
		Table = checkTable(Table)
		
		local strSteamID = string.Replace(Table.Sid, ":", "!")
		
		if strSteamID != "STEAM_ID_PENDING" then
		
			local strFileName = "UnderDone/" .. strSteamID .. ".txt"
			
			Table.Exp = self:GetNWInt("exp")

			file.Write(strFileName, Json.Encode(Table))
			
		end
		
	end
	
end

hook.Add("InitPostEntity", "CreateTable", function()
	if GM.Config.DB.Type == "sqllite" then
		sql.Query([[
			CREATE TABLE IF NOT EXIST`ud_player` (
					`Id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY ,
					`Sid` VARCHAR( 30 ) NOT NULL ,
					`Name` VARCHAR( 25 ) NOT NULL ,
					`Model` TEXT NOT NULL ,
					`Inventory` TEXT NOT NULL ,
					`Bank` TEXT NOT NULL ,
					`Quests` TEXT NOT NULL ,
					`Friends` TEXT NOT NULL ,
					`Exp` TEXT NOT NULL
					) ENGINE = MYISAM ;]])
	end
end)

function DB.get(Player) 
	
	
end


function Player:NewGame()

	self:SetNWInt("exp", 0)
	self:AddItem("money", 100)
	self:AddItem("item_smallammo_small", 3)
	self:AddItem("item_healthkit", 2)
	self:AddItem("weapon_melee_axe", 1)
	self:AddItem("weapon_ranged_junkpistol", 1)
	
	--[[
	self:AddItem("item_canspoilingmeat", 1)
	self:AddItem("weapon_melee_fryingpan", 1)
	self:AddItem("weapon_melee_cleaver", 1)
	self:AddItem("weapon_melee_leadpipe", 1)
	self:AddItem("weapon_melee_circularsaw", 1)
	self:AddItem("weapon_melee_wrench", 1)
	self:AddItem("weapon_melee_knife", 1)
	self:AddItem("weapon_ranged_heavymacgun", 1)
	self:AddItem("weapon_ranged_junksmg", 1)
	self:AddItem("armor_helm_chefshat", 1)
	self:AddItem("armor_helm_junkhelmet", 1)
	self:AddItem("armor_helm_scannergoggles", 1)
	self:AddItem("armor_chest_junkarmor", 1)
	self:AddItem("armor_sheild_cog", 1)
	self:AddItem("armor_sheild_saw", 1)
	]]
	
	self:SaveGame()
	
	print("New Game")
	
end

function Player:LoadGame()

	self.Data = {}
	self.Race = "human"
	
	local Data = {}
	
	for name, stat in pairs(GAMEMODE.DataBase.Stats) do self:SetStat(name, stat.Default) end
	
	local tblDecodedTable = {}
	local strSteamID = string.Replace(self:SteamID(), ":", "!") // A vir� !
	
	if strSteamID != "STEAM_ID_PENDING" then
	
		local strFileName = "UnderDone/" .. strSteamID .. ".txt"
		
		if file.Exists(strFileName) then
		
			tblDecodedTable = Json.Decode(file.Read(strFileName))
			
		else
		
			self:NewGame()
			
		end
		
	end
	
	if tblDecodedTable != {} then
	
		self:SetNWInt("exp", tblDecodedTable.Exp or 0)
		self:SetNWInt("SkillPoints", self:GetDeservedSkillPoints())
		
		if tblDecodedTable.Skills then
		
			local tblAllSkillsTable = table.ClearKeys( table.Copy( GAMEMODE.DataBase.Skills ) )
			
			table.sort(tblAllSkillsTable, function(statA, statB) return statA.Tier < statB.Tier end)
			
			for _, tblSkill in pairs(tblAllSkillsTable or {}) do
			
				if self:CanHaveSkill(tblSkill.Name) && tblDecodedTable.Skills[tblSkill.Name] then
				
					self:BuySkill(tblSkill.Name, tblDecodedTable.Skills[tblSkill.Name])
					
				end
				
			end
			
		end
		
		self:SetModel(tblDecodedTable.Model or "models/player/Group01/male_02.mdl")
		self.Data.Model = tblDecodedTable.Model or "models/player/Group01/male_02.mdl"
		
		if tblDecodedTable.Usergroup then
		
			self:SetUserGroup(tblDecodedTable.Usergroup)
			
		end
		
		self:GiveItems(tblDecodedTable.Inventory)
		
		for strItem, intAmount in pairs(tblDecodedTable.Bank or {}) do self:AddItemToBank(strItem, intAmount) end
		
		for slot, item in pairs(tblDecodedTable.Paperdoll or {}) do self:UseItem(item) end
		
		for strQuest, tblInfo in pairs(tblDecodedTable.Quests or {}) do self:UpdateQuest(strQuest, tblInfo) end
		
		for strFriends, tblInfo in pairs(tblDecodedTable.Friends or {}) do self:AddFriend(strFriends, tblInfo.Blocked) end
		
		for strBook, boolRead in pairs(tblDecodedTable.Library or {}) do self:AddBookToLibrary(strBook) end
		
		for strMaster, intExp in pairs(tblDecodedTable.Masters or {}) do self:SetMaster(strMaster, intExp) end
		
	end
	
	self.Loaded = true
	self:SetNWBool("Loaded", true)
	
	hook.Call("UD_Hook_PlayerLoad", GAMEMODE, self)
	
	for _, ply in pairs(player.GetAll()) do
	
		if ply != self && ply.Data && ply.Data.Paperdoll then
		
			for slot, item in pairs(ply.Data.Paperdoll) do
			
				SendUsrMsg("UD_UpdatePapperDoll", self, {ply, slot, item})
				
			end
			
		end
		
	end
	
end

function Player:SaveGame()

	if !self.Loaded or GAMEMODE.StopSaving or !self.Data then return end
	
	local tblSaveTable = table.Copy(self.Data)
	
	tblSaveTable.Inventory = {}
	
	--Polkm: Space saver loop
	for strItem, intAmount in pairs(self.Data.Inventory or {}) do
	
		if intAmount > 0 then tblSaveTable.Inventory[strItem] = intAmount end
		
	end
	
	tblSaveTable.Bank = {}
	
	for strItem, intAmount in pairs(self.Data.Bank or {}) do
	
		if intAmount > 0 then tblSaveTable.Bank[strItem] = intAmount end
		
	end
	
	tblSaveTable.Quests = {}
	
	for strQuest, tblInfo in pairs(self.Data.Quests or {}) do
	
		if tblInfo.Done then
		
			tblSaveTable.Quests[strQuest] = {Done = true}
			
		else 
		
			tblSaveTable.Quests[strQuest] = tblInfo
			
		end
		
	end	
	
	tblSaveTable.Friends = {}
	
	for strFriends, tblInfo in pairs(self.Data.Friends or {}) do
	
		if tblInfo.Blocked then
		
			tblSaveTable.Friends[strFriends] = {Blocked = true}
			
		else
		
			tblSaveTable.Friends[strFriends] = {}
			
		end
		
	end	
	
	local strSteamID = string.Replace(self:SteamID(), ":", "!")
	
	if strSteamID != "STEAM_ID_PENDING" then
	
		local strFileName = "UnderDone/" .. strSteamID .. ".txt"
		
		tblSaveTable.Exp = self:GetNWInt("exp")
		
		file.Write(strFileName, Json.Encode(tblSaveTable))
		
	end
	
end

local function PlayerSave(ply) ply:SaveGame() end

hook.Add("PlayerDisconnected", "PlayerSavePlayerDisconnected", PlayerSave)

hook.Add("UD_Hook_PlayerLevelUp", "PlayerSaveUD_Hook_PlayerLevelUp", PlayerSave)

hook.Add("ShutDown", "PlayerSaveShutDown", function() for _, ply in pairs(player.GetAll()) do PlayerSave(ply) end end)