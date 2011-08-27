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

local function DrawPlayerInfo()

	for _, ply in pairs(player.GetAll()) do
	
		if ValidEntity(ply) && LocalPlayer() != ply then
		
			if ply:GetPos():Distance(LocalPlayer():GetPos()) < 200 then
			
				if !ply:IsPlayer() then return end
				
				local posPlayerPos = (ply:GetPos() + Vector(0, 0, 80)):ToScreen()
				local strDisplayText = ply:Nick() .. " lv." ..  ply:GetLevel()
				
				surface.SetFont("UiBold")
				
				local wide, high = surface.GetTextSize(strDisplayText)
				
				draw.SimpleTextOutlined(strDisplayText, "UiBold", posPlayerPos.x, posPlayerPos.y, clrWhite, 1, 1, 1, clrDrakGray)
				
				local strIcon = "gui/player"
				
				if ply:IsAdmin() then strIcon = "gui/admin" end
				
				surface.SetDrawColor(255, 255, 255, 255)
				surface.SetTexture(surface.GetTextureID(strIcon))
				surface.DrawTexturedRect(posPlayerPos.x + (wide / 2) + 5, posPlayerPos.y - 8, 16, 16)
				
			end
			
		end
		
	end

end
hook.Add("HUDPaint", "DrawPlayerInfo", DrawPlayerInfo)