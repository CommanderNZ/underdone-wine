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
	
concommand.Add("UD_InvitePlayer", function(ply, command, args)

	local plyPlayer = player.GetByID(tonumber(args[1]))
	
	if !ValidEntity(ply) || !ValidEntity(plyPlayer) then return false end
	
	if #(ply.Squad or {}) >= 5 then return false end
	
	plyPlayer:UpdateInvites(ply, 1)
	
end)

concommand.Add("UD_KickSquadPlayer", function(ply, command, args)

	local plyPlayer = player.GetByID(tonumber(args[1]))
	
	if !ValidEntity(ply) || !ValidEntity(plyPlayer) then return false end
	
	if ply:GetNWEntity("SquadLeader") != ply or !ply:IsInSquad(plyPlayer) then return end
	
	plyPlayer:SetNWEntity("SquadLeader", plyPlayer)
	
	timer.Simple(0.5, function()
	
		for _, plyPlayer in pairs(player.GetAll()) do
		
			plyPlayer:UpdateSquadTable()
			
		end
		
	end)
	
end)

concommand.Add("UD_LeaveSquad", function(ply, command, args)

	if !ValidEntity(ply) then return false end
	
	ply:SetNWEntity("SquadLeader", ply)
	
	timer.Simple(0.5, function()
	
		for _, plyPlayer in pairs(player.GetAll()) do
		
			plyPlayer:UpdateSquadTable()
			
		end
		
	end)
	
end)

concommand.Add("UD_AcceptInvite", function(ply, command, args)

	local plyInviter = player.GetByID(tonumber(args[1]))
	
	if !ValidEntity(ply) || !ValidEntity(plyInviter) then return false end
	
	if !ply.Invites[plyInviter] == 1 then return end
	
	plyInviter:SetNWEntity("SquadLeader", plyInviter)
	
	ply:SetNWEntity("SquadLeader", plyInviter)
	
	ply:UpdateInvites(plyInviter, 0)
	
	timer.Simple(0.5, function()
	
		for _, plyPlayer in pairs(player.GetAll()) do
		
			plyPlayer:UpdateSquadTable()
			
		end
		
	end)
	
end)