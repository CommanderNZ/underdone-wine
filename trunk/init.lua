AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

for _,v in pairs( table.Add( file.Find( "entities/*.lua" ), file.Find( "sewps/*.lua" ) ) ) do
AddCSLuaFile( v )
end

PrintTable(file.Find("*"))
