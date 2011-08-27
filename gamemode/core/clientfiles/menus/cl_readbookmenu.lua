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
	
GM.ReadMenu = nil
PANEL = {}

function PANEL:Init()

	self.Frame = CreateGenericFrame("Book", true, true)
	self.Frame.btnClose.DoClick = function(pnlPanel)
	
		GAMEMODE.ReadMenu.Frame:Close()
		GAMEMODE.ReadMenu = nil
		
	end
	
	self.Frame:MakePopup()
	self.TextList = CreateGenericList(self.Frame, 5, false, true)
	self.StoryText = CreateGenericLabel(nil, nil, LocalPlayer().CurrentStory or "", clrDrakGray)
	self.TextList:AddItem(self.StoryText)
	self:PerformLayout()
	
end

function PANEL:PerformLayout()

	self.Frame:SetPos(self:GetPos())
	self.Frame:SetSize(self:GetSize())
	self.TextList:SetPos(5, 25)
	self.TextList:SetSize(self.Frame:GetWide() - 10, self.Frame:GetTall() - 30)
	
end

function PANEL:UpdateStory()

	self.StoryText:SetText(LocalPlayer().CurrentStory or "")
	
end
vgui.Register("readmenu", PANEL, "Panel")

concommand.Add("UD_OpenReadMenu", function(ply, command, args)

	GAMEMODE.ReadMenu = GAMEMODE.ReadMenu or vgui.Create("readmenu")
	GAMEMODE.ReadMenu:SetSize(250, 250)
	GAMEMODE.ReadMenu:Center()
	GAMEMODE.ReadMenu:UpdateStory()
	
end)