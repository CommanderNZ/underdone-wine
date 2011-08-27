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
	
concommand.Add("UD_PlayerUseMenu", function(ply, command, args)

	if !args then return end
	if !args[1] then return end
	
	gui.EnableScreenClicker(true)
	
	local OtherPlayer = ents.GetByIndex(args[1])
	
	if ValidEntity(OtherPlayer) then
	
		local MenuOptions = DermaMenu()
		
		if LocalPlayer().IsFollowingPlayer then
		
			 MenuOptions:AddOption("Stop Following", function()
			 
				gui.EnableScreenClicker(false)
				ply:ConCommand("UD_StopFollowingPlayer")
				
			end )
			
		else
		
			 MenuOptions:AddOption("Follow", function()
			 
				gui.EnableScreenClicker(false)
				
				ply:ConCommand("UD_FollowPlayer " .. OtherPlayer:EntIndex())
				
			end )
			
		end
		
		MenuOptions:Open()
		
	end
	
end)
