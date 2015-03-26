# Commiter #

**Alexandre.sandros**

**Robin.prette**


# Details #

  * File : ```lua
gamemode/serverfile/core/serverfile/sv_ai.lua```
    * Function : ```lua
NpcAdjustDamage() l.103```
> > _This function needs to be adjusted as a new : PlayerAdjustDamage()(to adjust the damage to level)_
    * Function : ```lua
GM:OnNPCKilled() l.44```
> > _This function needs to be adjusted as a new : GM:PlayerDeath()(to adjust the xp to level and squads)_

  * Bug Expected :
    * There is obviously other functions who tell shits like ```
if targetent:IsPlayer() then return false end ```