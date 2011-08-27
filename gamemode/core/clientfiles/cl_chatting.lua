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
	
concommand.Add("UD_ToChatBox", function(ply, command, args)

	local strNewChat = string.gsub(args[1], "_", " ") .. ":"
	
	args[1] = ""
	
	chat.AddText(clrPurple, strNewChat .. table.concat(args, " "))
	
end)

function GM:OnPlayerChat(plySpeaker, strText, boolTeamOnly, boolPlayerIsDead)

	local tblText = string.ToTable(strText)
	local clrPlayerName = clrWhite
	local clrChat = clrWhite
	local boolDisplayName = true
	
	if plySpeaker == LocalPlayer() then clrPlayerName = clrGray end
	if tblText[1] == "*" and tblText[#tblText] == "*" && #tblText > 2 then clrChat = clrGreen end
	if tblText[#tblText] == "!" && #tblText > 1 then clrChat = clrOrange end
	if tblText[#tblText] == "@" && #tblText > 1 then clrChat = clrCream end
	
	if boolDisplayName then
	
		chat.AddText(clrPlayerName, plySpeaker:Nick(), ": ", clrChat,  strText)
		
	else
	
		chat.AddText(clrChat, strText)
		
	end
	
	return true
	
end
