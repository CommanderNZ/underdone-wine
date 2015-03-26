# List of gamemode functions #

## Servside functions ##

### Player ###

Player.[NewGame](Player_NewGame.md)

Player.[LoadGame](Player_LoadGame.md)

Player.[SaveGame](Player_SaveGame.md)

Player.[SkillReset](Player_SkillReset.md)

Player.[SearchQuestProp](Player_SearchQuestProp.md)

Player.[SearchWorldProp](Player_SearchWorldProp.md)

Player.[GiveExp](Player_GiveExp.md)

Player.[RemoveItem](Player_RemoveItem.md)

Player.[CraftRecipe](Player_CraftRecipe.md)

### Entity ###

Entity.[SetServerScale](Entity_SetServerScale.md)

#### Progress Bar ####

Player.[CreateProgressBar](Player_CreateProgressBar.md)

#### Create Notification ####

Player.[CreateNotification](Player_CreateNotification.md)

Player:BuyMasterLevel

#### Master ####

Player.[BuyMasterLevel](Player_BuyMasterLevel.md)

#### Book ####

Player.[RequestBookStory](Player_RequestBookStory.md)

#### Damage indicator ####

Player.[CreateIndacator](Player_CreateIndacator.md)

## Clientside functions ##

## Player ##

Player.[FollowPlayer](Player_FollowPlayer.md)

Player.[StopFollowing](Player_StopFollowing.md)

Player.[PapperDollBuildSlot](Player_PapperDollBuildSlot.md)

#### Firends ####

Player.[AddFriend](Player_AddFriend.md)

## Shared functions ##

### Player ###

Player.[IsMelee](Player_IsMelee.md)

Player.[IsDonator](Player_IsDonator.md)

Player.[GetMaximumHealth](Player_GetMaximumHealth.md)

Player.[GetMaxWeight](Player_GetMaxWeight.md)

Player.[GetArmorRating](Player_GetArmorRating.md)

Player.[CreateNotification](Player_CreateNotification.md)

Player.[ApplyBuffTable](Player_ApplyBuffTable.md)

#### Trade ####

Player.[GetTrade](Player_GetTrade.md)

Player.[GetTradeItem](Player_GetTradeItem.md)

Player.[AddItemTrade](Player_AddItemTrade.md)

#### Stat ####

Player.[AddStat](Player_AddStat.md)

Player.[SetStat](Player_SetStat.md)

Player.[GetStat](Player_GetStat.md)

#### Squad ####

Player.[UpdateInvites](Player_UpdateInvites.md)

Player.[UpdateSquadTable](Player_UpdateSquadTable.md)

Player.[IsInSquad](Player_IsInSquad.md)

Player.[GetAverageSquadLevel](Player_GetAverageSquadLevel.md)

#### Skill ####

Player.[SetSkill](Player_SetSkill.md)

Player.[GetSkill](Player_GetSkill.md)

Player.[CanHaveSkill](Player_CanHaveSkill.md)

Player.[HasSkill](Player_HasSkill.md) (**Need Change**)

Player.[GetDeservedSkillPoints](Player_GetDeservedSkillPoints.md)

Player.[CallSkillHook](Player_CallSkillHook.md)

#### Shops ####

Player.[GetItemBuyPrice](Player_GetItemBuyPrice.md)

#### Recipe ####

Player.[AddRecipe](Player_AddRecipe.md)

Player.[HasRecipe](Player_HasRecipe.md)

Player.[CanMake](Player_CanMake.md)

#### Quests ####

Player.[AddQuest](Player_AddQuest.md)

Player.[QuestItem](Player_QuestItem.md)

Player.[HasCompletedQuest](Player_HasCompletedQuest.md)

Player.[GetQuest](Player_GetQuest.md)

Player.[UpdateQuest](Player_UpdateQuest.md)

Player.[AddQuestKill](Player_AddQuestKill.md)

Player.[CanAcceptQuest](Player_CanAcceptQuest.md)

Player.[CanTurnInQuest](Player_CanTurnInQuest.md)


---


Player.[HasSet](Player_HasSet.md)

Player.[SetPaperDoll](Player_SetPaperDoll.md)

Player.[GetSlot](Player_GetSlot.md)

#### Master ####

Player.[SetMaster](Player_SetMaster.md)

Player.[GetMasterExp](Player_GetMasterExp.md)

Player.[GetMasterExpNextLevel](Player_GetMasterExpNextLevel.md)

Player.[AddMaster](Player_AddMaster.md)

Player.[RemoveMaster](Player_RemoveMaster.md)

Player.[GetTotalMasters](Player_GetTotalMasters.md)

#### Book ####

Player.[AddBookToLibrary](Player_AddBookToLibrary.md)

Player.[HasReadBook](Player_HasReadBook.md)

#### Friends ####

Player.[GetFriends](Player_GetFriends.md)

Player.[GetFriendsFriend](Player_GetFriendsFriend.md)

Player.[HasBlocked](Player_HasBlocked.md)

Player.[AddFriend](Player_AddFriend.md)

Player.[DeleteFriend](Player_DeleteFriend.md)

Player.[BlockFriend](Player_BlockFriend.md)

#### Bank ####

Player.[GetBankSize](Player_GetBankSize.md)

Player.[GetBankTotalSize](Player_GetBankTotalSize.md)

Player.[AddItemToBank](Player_AddItemToBank.md)

Player.[RemoveItemFromBank](Player_RemoveItemFromBank.md)

Player.[GetBank](Player_GetBank.md)

Player.[GetBankItem](Player_GetBankItem.md)

Player.[HasBankItem](Player_HasBankItem.md)

Player.[HasBankRoomFor](Player_HasBankRoomFor.md)

### Entity ###

Entity.[GetLevel](Entity_GetLevel.md)

Entity.[CreateGrip](Entity_CreateGrip.md)

#### Malus ####

Entity.[Stun](Entity_Stun.md)

Entity.[IgniteFor](Entity_IgniteFor.md)

#### Items, inventory ####

Entity.[AddItem](Entity_AddItem.md)

Entity.[RemoveItem](Entity_RemoveItem.md)

Entity.[GetItem](Entity_GetItem.md)

Entity.[TransferItem](Entity_TransferItem.md)

Entity.[HasItem](Entity_HasItem.md)

Entity.[HasRoomFor](Entity_HasRoomFor.md)

Entity.[TotalWeightOf](Entity_TotalWeightOf.md)

Entity.[GiveItems](Entity_GiveItems.md)

Entity.[TakeItems](Entity_TakeItems.md)

#### Other ####

Entity.[IsBuilding](Entity_IsBuilding.md)

Entity.[IsPet](Entity_IsPet.md)

Entity.[Idle](Entity_Idle.md)

Entity.[IsIdle](Entity_IsIdle.md)

Entity.[Follow](Entity_Follow.md)

Entity.[IsFollowing](Entity_IsFollowing.md)

Entity.[ReturnSpawn](Entity_ReturnSpawn.md)

Entity.[AttackPos](Entity_AttackPos.md)

Entity.[AttackEnemy](Entity_AttackEnemy.md)

Entity.[IsBlocked](Entity_IsBlocked.md)