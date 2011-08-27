    ///////////////////////////////////////////////////////////////////////////////////////
    //  _    _           _              _                   __          ___              //
    // | |  | |         | |            | |                  \ \        / (_)             //
    // | |  | |_ __   __| | ___ _ __ __| | ___  _ __   ___   \ \  /\  / / _ _ __   ___   //
    // | |  | | '_ \ / _` |/ _ \ '__/ _` |/ _ \| '_ \ / _ \   \ \/  \/ / | | '_ \ / _ \  //
    // | |__| | | | | (_| |  __/ | | (_| | (_) | | | |  __/    \  /\  /  | | | | |  __/  //
    //  \____/|_| |_|\__,_|\___|_|  \__,_|\___/|_| |_|\___|     \/  \/   |_|_| |_|\___|  //
    //                                                                                   //
    //       Last edit : Sandros	                                                     //
    //                                                                                   //
    ///////////////////////////////////////////////////////////////////////////////////////

local Player = FindMetaTable("Player")

function Player:GetTrade()

	if !ValidEntity(self) || !self.Data then return end
	
	return self.Data.Trade or {}
end

function Player:GetTradeItem(strItem)

	if !ValidEntity(self) || !self.Data then return end
	
	return self.Data.Trade[strItem]
end

function Player:AddItemTrade(strItem, intAmount)

	if !ValidEntity(self) || !self.Data then return false end
	
	local tblItemTable = ItemTable(strItem)
	
	if !tblItemTable then return false end
	
	if self:HasItem(strItem, intAmount) then
	
		self.Data.Trade = self.Data.Trade or {}
		
		local intNewTotal = (self.Data.Trade[strItem] or 0) + intAmount
		self.Data.Trade[strItem] = math.Clamp(intNewTotal, 0, intNewTotal)
		
		if SERVER then
		
			SendUsrMsg("UD_UpdateTradeItem", self, {strItem, intAmount})
		end
		
		if CLIENT then
		
			if GAMEMODE.TradeMenu then GAMEMODE.TradeMenu:LoadTrade() end
		end
		
		return true
	end
	
	return false
end

if CLIENT then

	usermessage.Hook("UD_UpdateTradeItem", function(usrMsg)
	
		LocalPlayer():AddItemTrade(usrMsg:ReadString(), usrMsg:ReadLong())
	end)
end