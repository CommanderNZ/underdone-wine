## Player.HasSkill ##

| **Syntax** | Player:HasSkill( strSkill:String ) |
|:-----------|:-----------------------------------|
| **Return** | Boolean |
| **Description** | Return if player have a skill  |
| **Part of Library** | Player |
| **Type** | Shared |
| **File** | core/sharedfiles/sh\_skills.lua |

## Examples ##

## Additional Notes ##

I think this function doesn't really work, if the first skill sort is not the same took in argument, and if it level is more than 0, it return false

```Lua

function Player:HasSkill(strSkill)

if !self.Data.Skills then return end

for skill,skilllevel in pairs(self.Data.Skills) do

if skilllevel > 0 then

// HERE
if SkillTable(skill).Name == strSkill then

return true

else

return false

end
end
end
end
```

The best will be that :

```Lua

function Player:HasSkill(strSkill)

if !self.Data.Skills then return end

for skill,skilllevel in pairs(self.Data.Skills) do

if SkillTable(skill).Name == strSkill and skilllevel > 0 then

return true

else

return false

end
end
end
```

## See Also ##