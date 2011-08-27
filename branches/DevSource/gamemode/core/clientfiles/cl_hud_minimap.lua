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
	
local MPositionX = ScrW() - 200
local MPositionY = 15
local MSizeW = 160
local MSizeH = 160
local IconSize = 8

local function DrawUDMiniMap()

	local LocalPos = LocalPlayer():GetPos()

	local MapBorder = jdraw.NewPanel()
	
	MapBorder:SetDemensions( MPositionX - 5, MPositionY - 5, MSizeW + 10, MSizeH + 10)
	MapBorder:SetStyle(4, clrTan)
	MapBorder:SetBoarder(1, clrDrakGray)
	
	jdraw.DrawPanel(MapBorder)

	local MiniMapData = {}
	
	MiniMapData.angles = Angle(90,0,0)
	MiniMapData.origin = LocalPos + Vector(0,0,900)
	MiniMapData.x = MPositionX
	MiniMapData.y = MPositionY
	MiniMapData.w = MSizeW
	MiniMapData.h = MSizeH
	
	render.RenderView( MiniMapData )
	
	for _,v in pairs(ents.GetAll()) do
	
		if ValidEntity(v) then
		
			if v:IsPlayer() then
			
				strMapIcon = "gui/player"
				
			end
			
			if v:IsNPC() then
			
				local tblNPCTable = NPCTable(v:GetNWInt("npc"))
				
				if !tblNPCTable then return end
				
				if tblNPCTable.Appearance then
				
					strMapIcon = "gui/silkicons/palette"
					
				elseif tblNPCTable.Bank then
				
					strMapIcon = "gui/silkicons/box"
					
				elseif tblNPCTable.Auction then
				
					strMapIcon = "gui/silkicons/world"
					
				elseif tblNPCTable.Quest then
				
					strMapIcon = "gui/silkicons/group"
					
				elseif tblNPCTable.Shop then
				
					strMapIcon = "gui/silkicons/emoticon_smile"
					
				else
				
					strMapIcon = "gui/silkicons/exclamation"
					
				end
				
			end
			
			if v:IsNPC() or v:IsPlayer() then 	
			
				if !strMapIcon then return end
				
				local Distance = LocalPos - v:GetPos()
				
				Distance:Rotate( Angle(0,180,0) )
				
				local MapY = Distance.x * (MSizeW / ((900 * 1.5) + (Distance.z * 1.5)))
				local MapX = Distance.y * (MSizeH / ((900 * 1.5) + (Distance.z * 1.5)))
			
				if MapX < (MSizeH / 2.1) && MapX > (-MSizeH / 2.1) && MapY < (MSizeW / 2.1) && MapY > (-MSizeW / 2.1) then
				
					surface.SetDrawColor(255, 255, 255, 255)
					surface.SetTexture(surface.GetTextureID(strMapIcon))
					surface.DrawTexturedRect((MPositionX + (MSizeW / 2) - (IconSize / 2)) - MapX,(MPositionY + (MSizeH / 2 - (IconSize / 2))) - MapY, IconSize, IconSize)
					
				end
				
			end
			
		end
		
	end
	
end
hook.Add("HUDPaint", "DrawUDMiniMap", DrawUDMiniMap)