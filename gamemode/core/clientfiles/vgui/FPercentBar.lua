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
	
PANEL = {}
PANEL.Min = 0
PANEL.Max = 1
PANEL.Value = 1
PANEL.Text = ""

function PANEL:Init()

end

function PANEL:Paint()

	self.PercentBar = jdraw.NewProgressBar()
	self.PercentBar:SetDemensions(0, 0, self:GetWide(), self:GetTall())
	self.PercentBar:SetStyle(4, clrBlue)
	self.PercentBar:SetBoarder(1, clrDrakGray)
	self.PercentBar:SetValue(self.Value, self.Max)
	self.PercentBar:SetText("UiBold", self.Text, clrDrakGray)
	
	jdraw.DrawProgressBar(self.PercentBar)
	
end

function PANEL:SetMax(intMax)

	self.Max = intMax
	
end

function PANEL:SetValue(intValue)

	self.Value = intValue
	
end

function PANEL:GetValue()

	return self.Value
	
end

function PANEL:SetText(strText)

	self.Text = strText
	
end

vgui.Register("FPercentBar", PANEL, "Panel")