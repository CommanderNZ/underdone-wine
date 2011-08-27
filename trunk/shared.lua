for _,v in pairs( table.Add( file.Find( "entities/*.lua" ), file.Find( "sewps/*.lua" ) ) ) do
include( v )
end
