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

function Player:DipositeItem(strItem, intAmount)

	if !ValidEntity(self) || !self.Data then return false end
	
	if !self.UseTarget.Bank or self.UseTarget:GetPos():Distance(self:GetPos()) > 100 then return end
	
	if self:HasItem(strItem, intAmount) && self:AddItemToBank(strItem, intAmount) then
	
		self:RemoveItem(strItem, intAmount)
		
		return true
		
	end
	
	return false
	
end

concommand.Add("UD_DipostiteItem", function(ply, command, args)

	ply:DipositeItem(args[1], tonumber(args[2] or 1))
	
end)

function Player:WithdrawItem(strItem, intAmount)

	if !ValidEntity(self) then return end
	
	if !self.UseTarget.Bank or self.UseTarget:GetPos():Distance(self:GetPos()) > 100 then return end
	
	if self:HasBankItem(strItem, intAmount) && self:AddItem(strItem, intAmount) then
	
		self:RemoveItemFromBank(strItem, intAmount)
		
		return true
		
	end
	
	return false
	
end
concommand.Add("UD_WithdrawItem", function(ply, command, args)

	ply:WithdrawItem(args[1], tonumber(args[2] or 1))
	
end)

