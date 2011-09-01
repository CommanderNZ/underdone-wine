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

function Player:InviteToChallenge(plyInviteur)

	if !ValidEntity(self) then return false end
	if !ValidEntity(plyInviteur) then return false end
	
	if !self:IsPlayer() or !plyInviteur:IsPlayer() then return false end 
	
	if SERVER then
	
		//SendUsrMsg("UD_UpdateInvites", self, {plyInviter, intAddRemove})
	end
	
	if CLIENT  then
	
		//GAMEMODE:OpenInvitePromt(plyInviter)
		
	end
end


function Player:AcceptChallenge(plyInviter)

	if !ValidEntity(self) then return false end
	if !ValidEntity(plyInviter) then return false end
	
	if !self:IsPlayer() or !plyInviter:IsPlayer() then return false end 
	
	self:CreateNotification("Player have accept")
	
	 
	if SERVER then
	
	self.Data = self.Data or {}
	self.Data.Challenge = self.Data.Challenge or {}
	
	self.Data.Challenge.Propose = nil
	self.Data.Challenge.Time = os.time()
	self.Data.Challenge.Enemy = plyInviter
	self.Data.Challenge.Finish = false
	
	plyInviter.Data = plyInviter.Data or {}
	plyInviter.Data.Challenge = plyInviter.Data.Challenge or {}
	plyInviter.Data.Challenge.Propose = nil
	plyInviter.Data.Challenge.Time = os.time()
	plyInviter.Data.Challenge.Enemy = plyInviter
	plyInviter.Data.Challenge.Finish = false
		//SendUsrMsg("UD_UpdateInvites", self, {plyInviter, intAddRemove})
	end
	
	if CLIENT  then
	
		//GAMEMODE:OpenInvitePromt(plyInviter)
		
	end
end