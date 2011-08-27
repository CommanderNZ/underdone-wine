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

concommand.Add("UD_PrivateMessage", function(ply, command, args)

	local plyTargetPlayer = player.GetByID(tonumber(args[1]))
	
	if !ValidEntity(plyTargetPlayer) then return end
	
	args[1] = ""
	
	plyTargetPlayer:ConCommand("UD_ToChatBox " .. string.gsub(ply:Nick(), " ", "_") .. " " .. table.concat(args, " "))
	
end)

concommand.Add("UD_FriendsMessage", function(ply, command, args)

	local plyTargetPlayer = player.GetByID(tonumber(args[1]))
	
	if !ValidEntity(plyTargetPlayer) then return end
	
	args[1] = ""
	
	if ply:HasBlocked(plyTargetPlayer) || plyTargetPlayer:HasBlocked(ply) then return end
	
	plyTargetPlayer:ConCommand("UD_ToChatBox " .. string.gsub(ply:Nick(), " ", "_") .. " " .. table.concat(args, " "))
	
end)

function Player:UserChangeModel(args)

	if !ValidEntity(self) then return end
	
	if !self.UseTarget.Appearance or self.UseTarget:GetPos():Distance(self:GetPos()) > 100 then return end
	
	if args[1] then
	
		for _,v in pairs(GAMEMODE.PlayerModel) do
		
			if table.HasValue( v, args[1] ) then
			
				self:SetModel(args[1])
				
				self.Data.Model = args[1]
				
				self:SaveGame()
				
			end
			
		end
		
	end
	
end
concommand.Add("UD_UserChangeModel", function(ply, command, args)
	ply:UserChangeModel(args)
end)
