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
	
function GM:PlayerCanHearPlayersVoice(pListener, pSpeaker)

	if !IsValid(pSpeaker) || !IsValid(pListener) then return false end --InValid
	
	local intChatDistance = 1000
	
	if pSpeaker:GetNWBool("SquadChat") or pListener:GetNWBool("SquadChat") then
	
		if pListener:IsInSquad(pSpeaker) or pSpeaker:IsInSquad(pListener) then
		
			local intChatDistance = 10000
			
		else
		
			local intChatDistance = 1000
			
		end 
	end
	
	if pListener:GetPos():Distance(pSpeaker:GetPos()) >= intChatDistance then return false end --Too Far
	
	return true --All good :)
end

function GM:PlayerCanSeePlayersChat(strText, bTeamOnly, pListener, pSpeaker)

	if !IsValid(pSpeaker) || !IsValid(pListener) then return false end --InValid
	
	local tblText = string.ToTable(strText)
	local intChatDistance = 700
	
	if tblText[#tblText] == "!" && #tblText > 1 then intChatDistance = 7000 end
	
	if tblText[#tblText] == "@" && #tblText > 1 then intChatDistance = 7000  if !pListener:IsInSquad(pSpeaker) or !pSpeaker:IsInSquad(pListener) then return false end end
	
	if pListener:GetPos():Distance(pSpeaker:GetPos()) >= intChatDistance then return false end --Too Far
	
	return true --All good :)
end
