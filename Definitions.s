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
SET_FUNC GetCharacterData, 0x8018D39
SET_FUNC GetClassData, 0x8018D21
SET_FUNC UnitLoadStatsFromCharacter, 0x8017931
SET_FUNC UnitInitFromDefinition, 0x8017869
SET_FUNC GetAutoleveledStatIncrease, 0x8029605
SET_FUNC CanBattleUnitGainLevels, 0x8029635
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
SET_FUNC GetItemAttributes, 0x801727D

SET_FUNC LockGame, 0x8015309
SET_FUNC UnlockGame, 0x8015319
SET_FUNC BMapDispSuspend, 0x802D3B5
SET_FUNC BMapDispResume, 0x802D3E9
SET_FUNC StartFastFadeFromBlack, 0x8013FD5
SET_FUNC StartFastFadeToBlack, 0x8013FB1
SET_FUNC WaitForFade, 0x8014299
SET_FUNC BG_Fill, 0x8001811
SET_FUNC BG_EnableSyncByMask, 0x8000FFD 
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
SET_FUNC DisplayUiHand, 0x8049F59
SET_FUNC NewPopup_ItemGot, 0x800EF55
SET_FUNC Roll1RN, 0x8000E61
SET_FUNC SetLCGRNValue, 0x8000EC1
SET_FUNC InitRN, 0x8000CA9
SET_DATA gLCGRNValue, 0x3000008 

SET_FUNC StoreRNState, 0x8000D75
SET_FUNC LoadRNState, 0x8000DD1

SET_FUNC StartShopScreen, 0x80B0455 
SET_FUNC EndPlayerPhaseSideWindows, 0x8085C7D
SET_FUNC UpdateShopItemCounts, 0x80B0521


SET_DATA gBG0TilemapBuffer, 0x2022C60
SET_DATA gBG1TilemapBuffer, 0x2023460
SET_DATA gBG2TilemapBuffer, 0x2023C60
SET_DATA gBG3TilemapBuffer, 0x2024460
SET_DATA sKeyStatusBuffer, 0x2024C78
SET_DATA gStatScreen, 0x200310C @ for text handles 
SET_DATA gUiTmScratchA, 0x200323C @ might be wrong 
SET_DATA gLCDControlBuffer, 0x3002870
SET_DATA ProcScr_GotItem, 0x8B91DC4
SET_DATA StatScreen_Display, 0x808119D
SET_DATA gActiveUnit, 0x3004690
SET_DATA gProcScr_Shop, 0x8CE6FC0

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




