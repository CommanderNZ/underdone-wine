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
	
include("core/sharedfiles/json.lua")

require("Json")
require("glon")

include('shared.lua')
include('core/sharedfiles/database/items/sh_items_base.lua')
include('core/sh_resource.lua')

local Player = FindMetaTable("Player")

GM.TranslateColor = {}
GM.TranslateColor["green"] = clrGreen
GM.TranslateColor["orange"] = clrOrange
GM.TranslateColor["purple"] = clrPurple
GM.TranslateColor["blue"] = clrBlue
GM.TranslateColor["red"] = clrRed
GM.TranslateColor["tan"] = clrTan
GM.TranslateColor["white"] = clrWhite

function GM:GetColor(strColorName)

	local clrTranslated = GAMEMODE.TranslateColor[strColorName]
	
	if clrTranslated then return clrTranslated end
	
	return clrWhite
	
end

function GM:HUDDrawScoreboard()

	return false
	
end

function GM:Tick()

	if LocalPlayer() && !LocalPlayer().Data then LocalPlayer().Data = {} end
	
end
	
function Player:PlaySound(args)

	if !ValidEntity(self) then return end
	
	if args[1] && file.Exists("../sound/"..args[1]) then
	
		surface.PlaySound( args[1] )
		
	end
	
	if args[2] && !file.Exists("../sound/"..args[1]) then
	
		surface.PlaySound( args[2] )
		
	end
end
concommand.Add("UD_PlaySound", function(ply, command, args)

	ply:PlaySound(args)
	
end)