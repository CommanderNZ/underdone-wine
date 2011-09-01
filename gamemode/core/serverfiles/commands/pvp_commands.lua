    ///////////////////////////////////////////////////////////////////////////////////////
    //  _    _           _              _                   __          ___              //
    // | |  | |         | |            | |                  \ \        / (_)             //
    // | |  | |_ __   __| | ___ _ __ __| | ___  _ __   ___   \ \  /\  / / _ _ __   ___   //
    // | |  | | '_ \ / _` |/ _ \ '__/ _` |/ _ \| '_ \ / _ \   \ \/  \/ / | | '_ \ / _ \  //
    // | |__| | | | | (_| |  __/ | | (_| | (_) | | | |  __/    \  /\  /  | | | | |  __/  //
    //  \____/|_| |_|\__,_|\___|_|  \__,_|\___/|_| |_|\___|     \/  \/   |_|_| |_|\___|  //
    //                                                                                   //
    //       Last edit : Sandros 		                                                 //
    //                                                                                   //
    ///////////////////////////////////////////////////////////////////////////////////////
	
	
concommand.Add("UD_InviteChallenge", function(ply, command, args)

	local plyPlayer = player.GetByID(tonumber(args[1]))
	
	if !ValidEntity(ply) || !ValidEntity(plyPlayer) then return false end
	
	ply.Data = ply.Data or {}
	ply.Data.Challenge = ply.Data.Challenge or {}
	
	plyPlayer.Data = plyPlayer.Data or {}
	plyPlayer.Data.Challenge = plyPlayer.Data.Challenge or {}
	
	if  os.time-tonumber(ply.Data.Challenge.Time) >= 600 and ply.Data.Challenge.Finish == false then ply:CreateNotification("You are in challenge.") return end 
	
	if  os.time-tonumber(plyPlayer.Data.Challenge.Time) >= 600 and plyPlayer.Data.Challenge.Finish == false then ply:CreateNotification("He is in challenge.") return end 
	
	
	plyPlayer:InviteToChallenge(ply)
	
end)

concommand.Add("UD_AcceptChallenge", function(plyPlayer, command, args)

	local ply = player.GetByID(tonumber(args[1]))
	
	if !ValidEntity(ply) || !ValidEntity(plyPlayer) then return false end
	
	if  os.time-tonumber(ply.Data.Challenge.Time) >= 600 and ply.Data.Challenge.Finish == false then return  end 
	
	if  os.time-tonumber(plyPlayer.Data.Challenge.Time) >= 600 and plyPlayer.Data.Challenge.Finish == false then return end 
	
	
	ply:AcceptChallenge(plyPlayer)
	
end)

concommand.Add("UD_DenyChallenge", function(plyPlayer, command, args)

	local ply = player.GetByID(tonumber(args[1]))
	
	if !ValidEntity(ply) || !ValidEntity(plyPlayer) then return false end
	
	ply:DenyChallenge(plyPlayer)
	
end)