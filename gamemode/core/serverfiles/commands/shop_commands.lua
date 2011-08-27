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

function Player:BuyItem(strItem)

	if !ValidEntity(self) then return end
	
	if !self.UseTarget.Shop or self.UseTarget:GetPos():Distance(self:GetPos()) > 100 then return end
	
	local tblNPCTable = NPCTable(self.UseTarget:GetNWString("npc"))
	local tblShopTable = ShopTable(tblNPCTable.Shop)
	local tblItemTable = ItemTable(strItem)
	
	if tblNPCTable && tblShopTable && tblShopTable.Inventory[strItem] then
	
		if tblItemTable.QuestNeeded && !self:HasCompletedQuest(tblItemTable.QuestNeeded) then return end
		
		local tblItemInfo = tblShopTable.Inventory[strItem]
		local intQuest = tblItemInfo.QuestNeeded
		local intPrice = tblItemInfo.Price or self:GetItemBuyPrice(strItem)
		
		if self:HasItem("money", intPrice) && self:AddItem(strItem, 1) then
		
			self:RemoveItem("money", intPrice)
			
		end
		
	end
	
end
concommand.Add("UD_BuyItem", function(ply, command, args) ply:BuyItem(args[1]) end)

function Player:SellItem(strItem, intAmount)

	if !ValidEntity(self) then return end
	
	if !self.UseTarget.Shop or self.UseTarget:GetPos():Distance(self:GetPos()) > 100 then return end
	
	intAmount = intAmount or 1
	
	local tblNPCTable = NPCTable(self.UseTarget:GetNWString("npc"))
	
	if tblNPCTable && tblNPCTable.Shop && self:HasItem(strItem, intAmount) then
	
		local tblItemTable = ItemTable(strItem)
		
		if tblItemTable.SellPrice > 0 && self:RemoveItem(strItem, intAmount) then
		
			self:AddItem("money", tblItemTable.SellPrice * intAmount)
			
		end
		
	end
	
end
concommand.Add("UD_SellItem", function(ply, command, args) ply:SellItem(args[1], tonumber(args[2])) end)
