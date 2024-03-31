@.include "fe8.s" 

.macro SET_FUNC name, value
	.global \name
	.type   \name, function
	.set    \name, \value
.endm

.macro SET_DATA name, value
	.global \name
	.type   \name, object
	.set    \name, \value
.endm

.if FE6 == true 
SET_DATA DifficultySelectionProc, 0x868A09C @ fe6
SET_FUNC SaveMenuStartBlockingProc, 0x8089551 @ fe6 
.endif 
.if FE7 == true 
SET_DATA DifficultySelectionProc, 0x8CE4930 @ fe7 
SET_FUNC SaveMenuStartBlockingProc, 0x80A8665 @ fe7 
.endif 
.if FE8 == true 
SET_DATA DifficultySelectionProc, 0x8A20A10 @ fe8 
SET_FUNC SaveMenuStartBlockingProc, 0x80AC3E1 @ fe8  
.endif 

.if FE6 == true
SET_FUNC __aeabi_idiv, 0x809DCE1 
SET_FUNC Div, 0x809DCE1
SET_FUNC Mod, 0x809DCE5
SET_FUNC SetFlag, 0x806BA49
 
SET_FUNC GetItemMight, 0x80171e9
SET_FUNC GetItemHit, 0x80171fd
SET_FUNC GetItemWeight, 0x8017211
SET_FUNC GetItemCrit, 0x8017225
SET_FUNC GetItemData, 0x8017359
SET_FUNC GetItemAttributes, 0x8017191
SET_FUNC GetItemIndex, 0x8017129
SET_FUNC GetItemUseEffect, 0x801730d

SET_FUNC GetCharacterData, 0x801863d
SET_FUNC GetClassData, 0x8018621
SET_FUNC UnitLoadStatsFromCharacter, 0x80176E5
SET_FUNC UnitInitFromDefinition, 0x8017655
SET_FUNC GetAutoleveledStatIncrease, 0x80250D5
@SET_FUNC CanBattleUnitGainLevels, @ inline ? 
SET_FUNC CheckBattleUnitStatCaps, 0x80253Cd
SET_FUNC UnitCheckStatCaps, 0x80179Ed
SET_FUNC GetUnit, 0x801860d
SET_FUNC CheckBattleUnitLevelUp, 0x8025105
@SET_FUNC UnitLevelUp, @ unused 
SET_FUNC UnitAutolevelCore, 0x8017855
SET_FUNC GetUnitMaxHp, 0x80183C9
SET_FUNC GetUnitPower, 0x80183E9
SET_FUNC GetUnitSkill, 0x8018409
SET_FUNC GetUnitSpeed, 0x8018449
SET_FUNC GetUnitDefense, 0x8018489
SET_FUNC GetUnitResistance, 0x80184A9
SET_FUNC GetUnitLuck, 0x80184D1
SET_FUNC DrawStatWithBar, 0x806EC6d
SET_FUNC PutNumberOrBlank, 0x8006f51
SET_FUNC PutNumberBonus, 0x8007001
SET_FUNC PutSpecialChar, 0x8006E75
SET_FUNC PutNumberSmall, 0x8006FE1
SET_FUNC StartStatScreenHelp, 0x807030d



@SET_FUNC UnitLoadItemsFromDefinition, @ unused 
SET_FUNC UnitAddItem, 0x80174Ad 
SET_FUNC MakeNewItem, 0x801650d
@SET_FUNC UnitClearInventory, 

SET_FUNC LockGame, 0x801597d
SET_FUNC UnlockGame, 0x801598d
SET_FUNC BMapDispSuspend, 0x8028395
SET_FUNC BMapDispResume, 0x80283c9
SET_FUNC StartFastFadeFromBlack, 0x80146Ed
SET_FUNC StartFastFadeToBlack, 0x80146C9
SET_FUNC WaitForFade, 0x80149B1
SET_FUNC BG_Fill, 0x8001551
SET_FUNC BG_EnableSyncByMask, 0x8000ff1 
SET_FUNC BG_SetPosition, 0x80019Dd






SET_FUNC LoadUiFrameGraphics, 0x80417D5
SET_FUNC LoadObjUIGfx, 0x8015B45

SET_FUNC Proc_Start, 0x8003ca9
SET_FUNC Proc_StartBlocking, 0x8003cf5
SET_FUNC Proc_Break, 0x8003e61
SET_FUNC Proc_Goto, 0x8003f6d

SET_FUNC m4aSongNumStart, 0x809C861
SET_FUNC PutDrawText, 0x8006409
SET_FUNC ClearText, 0x80058ed
SET_FUNC InitText, 0x800579d
SET_FUNC ResetText, 0x800563d
SET_FUNC SetTextFontGlyphs, 0x8005705 
SET_FUNC ResetTextFont, 0x800573d
SET_FUNC InitSystemTextFont, 0x8006345 
SET_FUNC TileMap_FillRect, 0x809FAA1

SET_FUNC DisplayUiHand, 0x80415Cd
SET_FUNC NewPopup_ItemGot, 0x800d6e5 @ maybe 
SET_FUNC Roll1RN, 0x8000E39
SET_FUNC SetLCGRNValue, 0x8000E99
SET_FUNC InitRN, 0x8000C89
SET_FUNC PutNumber, 0x8006F31
SET_FUNC GetGameClock, 0x8000EEd
SET_FUNC PutSprite, 0x8007d3d
SET_FUNC SetFontGlyphSet, 0x8005705
SET_FUNC SetTextFont, 0x8005769
SET_FUNC PrintDebugStringToBG, 0x8004f19
SET_FUNC SetupDebugFontForBG, 0x8004e59 @ hook this 

SET_FUNC StartShopScreen, 0x8095E91 
SET_FUNC EndPlayerPhaseSideWindows, 0x8073325 @ maybe EndMapUi 
SET_FUNC UpdateShopItemCounts, 0x8095F5d
	@SET_FUNC GetUnitMovementCost, @ dunno @ fe7 0x80187d5
SET_FUNC GetUnitItemCount, 0x8017521
SET_FUNC GetUnitItemSlot, 0x8016D09 
SET_FUNC CanUnitUseChestKeyItem, 0x80236C5
SET_FUNC CanUnitUseDoorKeyItem, 0x8023701
SET_FUNC CanUnitOpenBridge, 0x8023715
SET_FUNC AiGetChestUnlockItemSlot, 0x80303F9
SET_FUNC GetUnitKeyItemSlotForTerrain, 0x80181d5
SET_FUNC CanUnitUseLockpickItem, 0x8023729
SET_FUNC IsItemDisplayUsable, 0x8016BD9
SET_FUNC CanUnitUseStaff, 0x8016645
SET_FUNC CanUnitUseWeapon, 0x8016539
SET_FUNC StatScreen_Display, 0x806ffdd

SET_DATA gBG0TilemapBuffer, 0x2021B08
SET_DATA gBG1TilemapBuffer, 0x2022308
SET_DATA gBG2TilemapBuffer, 0x2022B08
SET_DATA gBG3TilemapBuffer, 0x2023308
SET_DATA sKeyStatusBuffer, 0x2023B20
SET_DATA gStatScreen, 0x2003108 @ for text handles 
SET_DATA gUiTmScratchA, 0x2003238 @ might be wrong 
SET_DATA gActiveUnit, 0x30044B0
SET_DATA RandBitflags, 0x202AA66 @ GameOptions + 0x1E (unk, 2 bytes) 
SET_DATA RandValues, 0x202AA8C @ GameOptions + 0x44 (unk, 4 bytes) 
SET_DATA weatherId, 0x202AA5D
SET_DATA gPlaySt, 0x202AA48
SET_DATA gCh, 0x202AA56
SET_DATA gBmMapTerrain, 0x202D208
SET_DATA gProcScr_Shop, 0x8690F00
SET_DATA sPrevHandClockFrame, 0x203C9D8
SET_DATA sPrevHandScreenPosition, 0x203C9D4
@SET_DATA gLCGRNValue, 0x3000008 
SET_DATA gLCDControlBuffer, 0x30026B0
SET_DATA ProcScr_GotItem, 0x85C4934 @ maybe 

@SET_FUNC StartBlockingPrepShop, @ fe7 0x8098F71 

@SET_DATA TacticianName, 
.endif


.if FE7 == true 
SET_DATA TacticianName, 0x202BC18
SET_FUNC __aeabi_idiv, 0x80BFA15 
SET_FUNC Div, 0x80BFA15
SET_FUNC Mod, 0x80BFA19
SET_FUNC SetFlag, 0x80798E5 
SET_FUNC GetItemMight, 0x80172E1
SET_FUNC GetItemHit, 0x80172F9
SET_FUNC GetItemWeight, 0x8017311
SET_FUNC GetItemCrit, 0x8017329
SET_FUNC GetItemData, 0x80174AD 
SET_FUNC GetItemAttributes, 0x801727D
SET_FUNC GetItemIndex, 0x80171B5
SET_FUNC GetItemUseEffect, 0x801743D

SET_FUNC GetCharacterData, 0x8018D39
SET_FUNC GetClassData, 0x8018D21
SET_FUNC UnitLoadStatsFromCharacter, 0x8017931
SET_FUNC UnitInitFromDefinition, 0x8017869
SET_FUNC GetAutoleveledStatIncrease, 0x8029605
SET_FUNC CanBattleUnitGainLevels, 0x8029635
SET_FUNC CheckBattleUnitStatCaps, 0x8029971
SET_FUNC UnitCheckStatCaps, 0x8017C65
SET_FUNC GetUnit, 0x8018D0D
SET_FUNC CheckBattleUnitLevelUp, 0x8029661
SET_FUNC UnitLevelUp, 0x802A995
SET_FUNC UnitAutolevelCore, 0x8017AC1
SET_FUNC GetUnitMaxHp, 0x8018AB1
SET_FUNC GetUnitPower, 0x8018AD1
SET_FUNC GetUnitSkill, 0x8018AF1
SET_FUNC GetUnitSpeed, 0x8018B31
SET_FUNC GetUnitDefense, 0x8018B71
SET_FUNC GetUnitResistance, 0x8018B91
SET_FUNC GetUnitLuck, 0x8018BB9
SET_FUNC DrawStatWithBar, 0x807FD29
SET_FUNC PutNumberOrBlank, 0x80061E5
SET_FUNC PutNumberBonus, 0x8006241
SET_FUNC PutSpecialChar, 0x800615D
SET_FUNC PutNumberSmall, 0x8006235
SET_FUNC StartStatScreenHelp, 0x80814F5
 
SET_FUNC UnitLoadItemsFromDefinition, 0x80178F5
SET_FUNC UnitAddItem, 0x8017655 
SET_FUNC MakeNewItem, 0x8016175
SET_FUNC UnitClearInventory, 0x8017675
SET_FUNC LockGame, 0x8015309
SET_FUNC UnlockGame, 0x8015319
SET_FUNC BMapDispSuspend, 0x802D3B5
SET_FUNC BMapDispResume, 0x802D3E9
SET_FUNC StartFastFadeFromBlack, 0x8013FD5
SET_FUNC StartFastFadeToBlack, 0x8013FB1
SET_FUNC WaitForFade, 0x8014299
SET_FUNC BG_Fill, 0x8001811
SET_FUNC BG_EnableSyncByMask, 0x8000ffd
SET_FUNC BG_SetPosition, 0x8001D8D
SET_FUNC LoadUiFrameGraphics, 0x804A211
SET_FUNC LoadObjUIGfx, 0x8015591

SET_FUNC Proc_Start, 0x8004495 
SET_FUNC Proc_StartBlocking, 0x80044F9
SET_FUNC Proc_Break, 0x80046A1
SET_FUNC Proc_Goto, 0x8004721
SET_FUNC m4aSongNumStart, 0x80BE595
SET_FUNC PutDrawText, 0x8005AD5
SET_FUNC ClearText, 0x80054E1
SET_FUNC InitText, 0x8005475
SET_FUNC ResetText, 0x80053B1
SET_FUNC SetTextFontGlyphs, 0x8005411 
SET_FUNC ResetTextFont, 0x8005439
SET_FUNC ChapterStatus_SetupFont, 0x8086E61
SET_FUNC InitSystemTextFont, 0x8005A41
SET_FUNC TileMap_FillRect, 0x80C57BD
SET_FUNC StartBlockingPrepShop, 0x8098F71

SET_FUNC DisplayUiHand, 0x8049F59
SET_FUNC NewPopup_ItemGot, 0x800EF55
SET_FUNC Roll1RN, 0x8000E61
SET_FUNC SetLCGRNValue, 0x8000EC1
SET_FUNC InitRN, 0x8000CA9
SET_FUNC PutNumber, 0x80061D9
SET_FUNC GetGameClock, 0x8000F15
SET_FUNC PutSprite, 0x80069F5
SET_FUNC SetFontGlyphSet, 0x8005411
SET_FUNC SetTextFont, 0x8005451
SET_FUNC PrintDebugStringToBG, 0x8004F71
SET_FUNC SetupDebugFontForBG, 0x8004EF9


SET_FUNC StoreRNState, 0x8000D75
SET_FUNC LoadRNState, 0x8000DD1

SET_FUNC StartShopScreen, 0x80B0455 
SET_FUNC EndPlayerPhaseSideWindows, 0x8085C7D
SET_FUNC UpdateShopItemCounts, 0x80B0521
SET_FUNC GetUnitMovementCost, 0x80187d5

SET_FUNC GetUnitItemCount, 0x80176DD
SET_FUNC GetUnitItemSlot, 0x8016D0D 
SET_FUNC CanUnitUseChestKeyItem, 0x8027355
SET_FUNC CanUnitUseDoorKeyItem, 0x8027391
SET_FUNC CanUnitOpenBridge, 0x80273A5
SET_FUNC AiGetChestUnlockItemSlot, 0x8036A8D
SET_FUNC GetUnitKeyItemSlotForTerrain, 0x8018525
SET_FUNC CanUnitUseLockpickItem, 0x80273B9
SET_FUNC IsItemDisplayUsable, 0x8016AB1
SET_FUNC CanUnitUseStaff, 0x80163D5
SET_FUNC CanUnitUseWeapon, 0x80161A5
SET_FUNC StatScreen_Display, 0x808119D

SET_DATA gBG0TilemapBuffer, 0x2022C60
SET_DATA gBG1TilemapBuffer, 0x2023460
SET_DATA gBG2TilemapBuffer, 0x2023C60
SET_DATA gBG3TilemapBuffer, 0x2024460
SET_DATA sKeyStatusBuffer, 0x2024C78
SET_DATA gStatScreen, 0x200310C @ for text handles 
SET_DATA gUiTmScratchA, 0x200323C @ might be wrong 
SET_DATA gLCDControlBuffer, 0x3002870
SET_DATA ProcScr_GotItem, 0x8B91DC4
SET_DATA gActiveUnit, 0x3004690
SET_DATA gProcScr_Shop, 0x8CE6FC0
SET_DATA gLCGRNValue, 0x3000008 
SET_DATA sPrevHandClockFrame, 0x203DCF0
SET_DATA sPrevHandScreenPosition, 0x203DCEC
SET_DATA Unk_TerrainTable_08BEC398, 0x8BEC398
SET_DATA gBmMapTerrain, 0x202E3E0
SET_DATA weatherId, 0x202BC0D

SET_DATA RandBitflags, 0x202BC16 @ GameOptions + 0x1E (unk, 2 bytes) 
SET_DATA RandValues, 0x202BC3C @ GameOptions + 0x44 (unk, 4 bytes) 

SET_DATA gPlaySt, 0x202BBF8
SET_DATA gCh, 0x202BC06


@SET_FUNC DivArm, 0x80D1681
@
@@ division & other libgcc functions
@SET_FUNC __aeabi_idiv,    __divsi3
@SET_FUNC __aeabi_idivmod, __modsi3
@

@SET_DATA classTablePoin, 0x8017AB8 
.endif



