.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

@.global __aeabi_idivmod
@.type __aeabi_idivmod, %function 
.global Mod
.type Mod, %function 
__aeabi_idivmod:
Mod: 
cmp r1, #0 
bne ContinueMod 
mov r0, #0 
bx lr 
ContinueMod: 
swi 6
mov r0, r1
bx lr
.ltorg 

@.global __aeabi_idiv
@.type __aeabi_idiv, %function 
.global Div1
.type Div1, %function 
__aeabi_idiv: 
Div1: 
cmp r1, #0 
bne ContinueDiv 
mov r0, #0 
bx lr 
ContinueDiv: 
swi 6
bx lr 
.ltorg 

.global CallBreak
.type CallBreak, %function 
CallBreak:
mov r11, r11 
bx lr 
.ltorg 

.global MaybeChargeAtPlayer
.type MaybeChargeAtPlayer, %function 
MaybeChargeAtPlayer: 
push {lr} 
ldrb r1, [r0] 
add r1, #1 
strb r1, [r0] 
bl MaybeChangeAi2
pop {r0} 
bx r0 
.ltorg 

.equ StatScreenStruct, 0x02003BFC
.global PressSelectFE8Something
.type PressSelectFE8Something, %function 
PressSelectFE8Something:
ldr		r1,=StatScreenStruct
ldrb	r0,[r1]
cmp		r0,#0x0				@stat screen
bne		NotStatScreen
ldr		r2,[r1,#0xC]
ldrb	r2,[r2,#0xB]
mov		r3,#0xC0
tst		r2,r3
bne		NotStatScreen
sub		r1,#0x2
mov		r3,#0x1
strb	r3,[r1]
ldrb	r2,[r1,#0x1]
mov		r3,#0x1
eor		r2,r3
strb	r2,[r1,#0x1]
mov r0, #1 
bx lr 
NotStatScreen: 
mov r0, #0 
bx lr 

.global GetStatScreenPage 
.type GetStatScreenPage, %function 
GetStatScreenPage: 
ldr r3, =0x2003BFC 
ldrb r0, [r3] 
mov r1, #3
and r0, r1 
bx lr 


.global PreventPhantomTrading
.type PreventPhantomTrading, %function 
PreventPhantomTrading: 
push {lr} 
@ r4 unitA r5 g_unitB* 
ldr r0, [r4] 
ldrb r0, [r0, #4] 
cmp r0, #0x3b 
beq CannotTrade 
cmp r0, #0x3e 
beq CannotTrade 
cmp r0, #0x3f 
beq CannotTrade 
ldr r0, [r5] 
ldr r0, [r0] @ we have pointer to unit struct in r5 
ldrb r0, [r0, #4] 
cmp r0, #0x3b 
beq CannotTrade 
cmp r0, #0x3e 
beq CannotTrade 
cmp r0, #0x3f 
beq CannotTrade 

CanTrade: 
mov r0, #1 
b EndTradeCheck 

CannotTrade: 
mov r0, #0 

EndTradeCheck: 
cmp r0, #0 
ldr r2, [r5] 
ldr r3, [r4] 
pop {r1} 
bx r1 
.ltorg 

.global ShouldKarlaAppear
.type ShouldKarlaAppear, %function 
ShouldKarlaAppear:
push {r4, lr} 
@mov r0, #0x28 @ Bartre portrait 
@bl GetReorderedCharacterPortraitByPortrait 
@mov r4, r0 
@ldrb r0, [r0, #4] @ real unit ID
mov r0, #9  
blh 0x8017D34 @ /GetUnitByCharId
cmp r0, #0 
beq KarlaWontAppear
mov r4, r0 @ unit struct 
ldr r0, [r4, #0] 
ldr r1, [r4, #4] @ class 
ldr r0, [r0, #0x28] 
ldr r1, [r1, #0x28] 
orr r0, r1 @ attributes 
mov r1, #1 
lsl r1, #8 @ promoted bitflag 
tst r0, r1 
beq KarlaWontAppear 
ldrb r0, [r4, #8] @ level 
cmp r0, #4 
ble KarlaWontAppear 
mov r0, #1 
b ExitKarla 

KarlaWontAppear: 
mov r0, #0 
ExitKarla:
pop {r4} 
pop {r1} 
bx r1
.ltorg 

.global TitleScreen_FE6
.type TitleScreen_FE6, %function 
TitleScreen_FE6:
push {r4, lr} 
mov r4, r0 
mov r0, #0
bl DrawVersionNumber
mov r2, r4 
mov r3, #0x64 
add r3, r2 
pop {r4} 
@ no pop lr 
ldr r0, =0x809B555 
bx r0 
.ltorg 

.global SaveScreen_FE6
.type SaveScreen_FE6, %function 
SaveScreen_FE6:
push {lr} 
mov r0, #1
bl DrawVersionNumber
mov r1, r4 
add r1, #0x2d 
mov r0, #1 
strb r0, [r1] 
pop {r3}
ldr r3, =0x80881D5
bx r3
.ltorg 


.global TitleScreen_FE7
.type TitleScreen_FE7, %function 
TitleScreen_FE7:
push {lr} 
mov r5, r0 
mov r0, #0
bl DrawVersionNumber
mov r4, r5 
add r4, #0x66 
ldrh r1, [r4] 
lsl r0, r1, #0x10 
asr r0, #0x11 
pop {r3} 
bx r3 
.ltorg 

.global SaveScreen_FE7
.type SaveScreen_FE7, %function 
SaveScreen_FE7:
push {lr} 
mov r0, #1
bl DrawVersionNumber
mov r1, r5 
add r1, #0x2e
mov r0, #2
strb r0, [r1] 
pop {r3}
ldr r3, =0x80a3a05
bx r3
.ltorg 

.global TitleScreen_FE8
.type TitleScreen_FE8, %function 
TitleScreen_FE8:
push {lr} 
mov r5, r0 
mov r0, #0
bl DrawVersionNumber
ldr r4, =0x8AA6774 
mov r0, #0x80 
lsl r0, #6 
pop {r3} 
ldr r3, =0x80C544D 
bx r3 
.ltorg 

.global SaveScreen_FE8
.type SaveScreen_FE8, %function 
SaveScreen_FE8:
push {lr} 
mov r0, #1
bl DrawVersionNumber
mov r1, r5 
add r1, #0x2e
mov r0, #2
strb r0, [r1] 
pop {r3}
ldr r3, =0x80a9031
bx r3
.ltorg 



.global UniqueAnimationHook_FE7
.type UniqueAnimationHook_FE7, %function 
UniqueAnimationHook_FE7: 
push {lr} 
orr r0, r1 
lsr r0, #8 
mov r1, #1 
and r0, r1 
add r2, #0x25 
add r2, r0 
ldrb r0, [r2] 
push {r0} 
mov r0, r5 
bl IsClassOrRecruitmentRandomized
mov r1, r0 
pop {r0} 
cmp r1, #0 
beq DoUniqueAnim_FE7 
mov r0, #0 
DoUniqueAnim_FE7: 
cmp r0, #0 
pop {r3} 
bx r3 
.ltorg 


.global BarLengthHook_A_FE8
.type BarLengthHook_A_FE8, %function 
BarLengthHook_A_FE8:
mov r6, r9 
mov r5, r8 
mov r4, r11 
push {r4-r7} 
mov r10, r0 
mov r8, r1 
mov r7, r3 
sub sp, #0x10 
str r2, [sp, #0xC] 
ldr r5, [sp, #0x34] 
push {r2} 
push {lr} 
bl GetGlobalStatCap
mov r11, r0 
pop {r0} 
pop {r2} 

bx r0 
.ltorg 

.global BarLengthHook_B_FE8
.type BarLengthHook_B_FE8, %function 
BarLengthHook_B_FE8:
add sp, #0x10 
pop {r3-r6} 
mov r11, r3 
mov r8, r4 
mov r9, r5 
mov r10, r6 
ldr r0, =0x8087171
bx r0 
.ltorg 

.global RoyPromoHook
.type RoyPromoHook, %function 
RoyPromoHook: 
push {r4-r6, lr} 
mov r6, r0 @ event engine 
mov r0, #1 @ Roy 
blh 0x8017ABC @ GetUnitByCharId 
mov r4, r0 

mov r5, #0xF @ binding blade default 
ldr r0, [r4, #4] @ class 
ldrb r1, [r0, #4] @ class id 
cmp r1, #1 
bne ExitRoyPromoHook 
@ldr r1, [r0, #0x24] @ attributes 
@mov r2, #1 
@lsl r2, #8 @ 0x100 promoted 
@tst r1, r2 
@bne ExitRoyPromoHook @ already promoted 
ldrb r0, [r0, #5] @ promotion class 
cmp r0, #0 
beq ExitRoyPromoHook 
mov r1, #0x26 
ldrb r0, [r4, r1] @ sword exp 
cmp r0, #0 
bne StartPromoNow 
mov r5, #0 @ no item equipped 
StartPromoNow: 
blh 0x8073324 @ prepare graphics 
mov r0, r4 @ unit 
mov r1, r5 @ equipped item 
blh 0x8027Db4 @ promotion 

@mov r1, #0x48 
@mov r0, #5 
@lsl r0, #8 @ 0x500 / 1280 frames 
@strh r0, [r6, r1] @ stal for this many frames 
@b SpecialExitRoy

ExitRoyPromoHook: 
pop {r4-r6} 
pop {r0} 
bx r0 
.ltorg 
SpecialExitRoy:
pop {r4-r6} 
pop {r0} 
pop {r0} 
pop {r7} 
pop {r1} 
mov r0, #2 
bx r1 
.ltorg 

@ ORG $2cc88 
.global FE7PromoHook
.type FE7PromoHook, %function 
FE7PromoHook: 
push {r4-r7, lr} 
mov r6, r9 
mov r5, r8 
push {r5-r6} 
MOV r6 ,r0 @ unit 
mov r7, r1 @ item (might be 0) 
LDR r4, =0x203A3F0 @ pointer:0802CD14 -> 0203A3F0 (BattleUnit@gBattleActor.CopyUnit )
LDR r5, =0x203A470 @ pointer:0802CD18 -> 0203A470 (BattleUnit@gBattleTarget.CopyUnit )

ldr r0, [r6, #0] 
ldr r1, [r6, #4] 
ldr r0, [r0, #0x28] 
ldr r1, [r1, #0x28] 
orr r0, r1 
mov r1, #1 
lsl r1, #8 @ 0x100 
tst r0, r1 
bne ExitFE7ForcedPromo @ already promoted 
ldr r1, [r6, #4] 
ldrb r0, [r1, #5] @ default promotion 
cmp r0, #0 
beq ExitFE7ForcedPromo


MOV r0 ,r5
ADD r0, #0x4A
MOV r2, #0x0
MOV r9, r2
MOV r2, #0x0
MOV r8, r2
STRH r7, [r0, #0x0]   @BattleUnit@gBattleTarget.weaponBefore
LDR r2, =0xFFFF @ pointer:0802CD1C -> 0000FFFF
MOV r0 ,r2
MOV r2 ,r7
AND r2 ,r0
MOV r0 ,r4
ADD r0, #0x4A
STRH r2, [r0, #0x0]   @BattleUnit@gBattleActor.weaponBefore
MOV r0 ,r5
ADD r0, #0x48
STRH r7, [r0, #0x0]   @BattleUnit@gBattleTarget.weapon
MOV r0 ,r4
ADD r0, #0x48
STRH r2, [r0, #0x0]   @BattleUnit@gBattleActor.weapon
MOV r0 ,r5
MOV r1 ,r6
blh 0x080285D4   @CopyUnitToBattleStruct
MOV r0 ,r6
blh 0x08029818   @ApplyUnitDefaultPromotion
MOV r0 ,r4
MOV r1 ,r6
blh 0x080285D4   @CopyUnitToBattleStruct
MOV r0 ,r4
MOV r1 ,r5
blh 0x08029904
MOV r0 ,r4
blh 0x08028728   @BattleSetupTerrainData
MOV r0 ,r5
blh 0x08028728   @BattleSetupTerrainData
LDR r0, =0x203A4F0 @ pointer:0802CD20 -> 0203A4F0 (ITEMSTOCK@Storage[64].Item ID )
MOV r1, r8
STRH r1, [r0, #0x0]   @ITEMSTOCK@Storage[64].Item ID
MOV r1, #0x80
STRB r1, [r0, #0x2]   @ITEMSTOCK@Storage[65].Item ID
MOV r2, r9
STRB r2, [r0, #0x3]   @ITEMSTOCK@Storage[65].Number of items
LDR r1, =0x203A3D8 @ pointer:0802CD24 -> 0203A3D8 (BattleStats@BattleStats.bitfield (0x2='battle hasn't started yet', 0x20=arena, 0x80=Promotion, 0x200=Ring))
MOV r0, #0x10
STRH r0, [r1, #0x0]   @BattleStats@BattleStats.bitfield (0x2='battle hasn't started yet', 0x20=arena, 0x80=Promotion, 0x200=Ring)
blh 0x0802A3B0   @BeginBattleAnimations
LDR r0, [r6, #0xC]
MOV r1, #0x1
ORR r0 ,r1
STR r0, [r6, #0xC]
ExitFE7ForcedPromo: 
POP {r3,r4}
MOV r8, r3
MOV r9, r4
POP {r4-r7}
POP {r0}
BX r0
.ltorg 

.global FE8_ForcedPromotionHook @ 10b80 hook 
.type FE8_ForcedPromotionHook, %function 
FE8_ForcedPromotionHook:
push {lr} 
mov r6, r0 
ldr r0, [r6, #0x38] 
ldrh r0, [r0, #2] 
blh 0x800BC50 @ get unit struct 
cmp r0, #0 
beq FE8_NoPromo 
mov r3, r0 
ldr r0, [r3, #0] 
ldr r1, [r3, #4] 
ldr r0, [r0, #0x28] 
ldr r1, [r1, #0x28] 
orr r0, r1 
mov r1, #1 
lsl r1, #8 @ 0x100 
tst r0, r1 
bne FE8_NoPromo @ already promoted 
ldr r1, [r3, #4] 
ldrb r0, [r1, #5] @ default promotion 
cmp r0, #0 
beq FE8_NoPromo

FE8_Promo: 
ldr r0, [r6, #0x38] 
ldrh r5, [r0, #2] 
ldrh r1, [r0, #4] 
pop {r3} 
ldr r3, =0x8010b89 
bx r3 
.ltorg 
FE8_NoPromo: 
mov r0, #0  
pop {r3} 
ldr r3, =0x8010BDD 
bx r3 
.ltorg 

.global Arm_DecompText
.type Arm_DecompText, %function 
Arm_DecompText:
push {lr} 
push {r1} 
ldr r2, [r2] 
bl CallViaR2 
mov r0, r1 @ huffman decoding happens to have the text buffer offset in r1 afterwards 
pop {r1} 
sub r0, r1 @ bytes used 
pop {r1} 
bx r1 
CallViaR2:
bx r2 
.ltorg 

.global CallEndEvent_FE6
.type CallEndEvent_FE6, %function 
CallEndEvent_FE6:
push {lr} 
mov r0, #0xE 
ldr r3, =0x0202AA48 
ldsb r0, [r3, r0] 
blh 0x802BBA0 
ldr r0, [r0, #0x18] 
blh 0x800D978
pop {r3} 
bx r3 
.ltorg 

.global HookLoadFace_FE6
.type HookLoadFace_FE6, %function 
HookLoadFace_FE6:
push {r4, lr} 
lsl r4, r1, #8 
ldr r0, [r7, #8] 
mov r1, #0 
bl GetRandomizedPortrait
add r4, r0 
str r4, [r7, #8] 
mov r0, r4 
pop {r4} 
pop {r3} 
bx r3 
.ltorg 

.global HookLoadFace_FE8
.type HookLoadFace_FE8, %function 
HookLoadFace_FE8:
push {lr} 
ldr r0, [r4] 
ldr r0, [r0] 
ldrb r4, [r0, #1] 
lsl r4, #8 
ldrb r0, [r0] 
mov r1, #0 
bl GetRandomizedPortrait
add r4, r0 
pop {r3} 
bx r3 
.ltorg 

.global HookWMStartFace_FE6
.type HookWMStartFace_FE6, %function 
HookWMStartFace_FE6:
push {r4, lr} 
mov r4, r0 @ proc 
mov r0, r1 
mov r1, #0 
bl GetRandomizedPortrait
mov r2, r0 
mov r0, r4 
pop {r4} 
pop {r3} 
bx r3 
.ltorg 

.global HookWMStartFace_FE7
.type HookWMStartFace_FE7, %function 
HookWMStartFace_FE7:
str r1, [sp] @ probably unnecessary, but vanilla code does this before bl to 7bcc as 5th param 
push {r4, lr} 
sub sp, #4 
str r1, [sp] 
mov r0, r9 @ portrait id 
mov r4, r2 
mov r1, #0 
bl GetRandomizedPortrait
mov r1, r0
mov r2, r4 
mov r0, r7 
mov r3, #0x28 @ idk 
blh 0x8007bcc, r4
add sp, #4 
pop {r4} 
pop {r3} 
bx r3 
.ltorg 

.global HookWMStartFace_FE8
.type HookWMStartFace_FE8, %function 
HookWMStartFace_FE8:
push {lr} 
lsl r2, #0x10 
lsr r4, r2, #0x10 
mov r0, r1 @ face ID 
mov r1, #0 
bl GetRandomizedPortrait
mov r6, r0 
ldr r0, =0x8A3D700 
blh 0x8002e9c
pop {r3} 
bx r3 
.ltorg 

.global HookGetUnitPortraitId_FE8
.type HookGetUnitPortraitId_FE8, %function 
HookGetUnitPortraitId_FE8:
push {r4, lr} 
mov r4, r0 
ldr r0, [r1] 
ldrh r0, [r0, #6] 
cmp r0, #0 
beq ExitGeneric_Fe8 
mov r1, #0 
bl GetRandomizedPortrait
mov r2, r0 
mov r1, r4 
pop {r4} 
pop {r3} 
ldr r3, =0x80192C5 
bx r3 

ExitGeneric_Fe8:
mov r1, r4 
ldr r1, [r1, #4] 
pop {r4} 
pop {r3} 
ldr r3, =0x80192E5
bx r3 
.ltorg 

.global GetUnitPortraitId_FE7
.type GetUnitPortraitId_FE7, %function 
GetUnitPortraitId_FE7:
push {r4, lr} 
mov r4, r0 
ldr r1, [r4] 
ldrh r0, [r1, #6] 
cmp r0, #0 
beq GetClassPortraitId_FE7 
mov r1, #0 
bl GetRandomizedPortrait 
b ExitPortrait_FE7

GetClassPortraitId_FE7: 
ldr r1, [r4, #4] 
ldrh r0, [r1, #8] 
ExitPortrait_FE7:
pop {r4} 
pop {r3} 
bx r3 
.ltorg 





.global GetUnitMiniPortraitId_FE7
.type GetUnitMiniPortraitId_FE7, %function 
GetUnitMiniPortraitId_FE7:
push {r4, lr} 
mov r4, r0 
ldr r1, [r4] 
ldrb r0, [r1, #8] 
cmp r0, #0 
bne UseGenericMiniPortrait_FE7 
mov r0, r4 
bl GetUnitPortraitId_FE7 
b ExitMiniPortrait_FE7 

UseGenericMiniPortrait_FE7: 
mov r0, #0xFE 
lsl r0, #7 
ldrb r1, [r1, #8] 
orr r0, r1 
ExitMiniPortrait_FE7:
pop {r4} 
pop {r3} 
bx r3 
.ltorg 



.global HookGetUnitMiniPortraitId_FE8
.type HookGetUnitMiniPortraitId_FE8, %function 
HookGetUnitMiniPortraitId_FE8:
push {r4, lr} 
mov r4, r2  @ unit 
ldrh r1, [r1, #6] 
cmp r1, #0 
beq ExitGenericMini_Fe8 
mov r0, r1  
mov r1, #0 
bl GetRandomizedPortrait
mov r1, r0 
ldr r0, =0x202BCF0 @ gChData 
mov r2, r4 @ unit 
pop {r4} 
pop {r3} 
ldr r3, =0x8019311 
bx r3 

ExitGenericMini_Fe8:
mov r2, r4 
ldr r2, [r2, #4] 
pop {r4} 
pop {r3} 
ldr r3, =0x8019331
bx r3 
.ltorg 

.global GetMapLevelUpPortraitId_FE6
.type GetMapLevelUpPortraitId_FE6, %function 
GetMapLevelUpPortraitId_FE6:
push {lr} 
lsl r1, r2, #2 
add r0, r1 
ldr r0, [r0] 
ldr r0, [r0] 
ldrh r0, [r0, #6] @ portrait ID 
mov r1, #0 
bl GetRandomizedPortrait
mov r1, r0 
mov r0, #0x42
pop {r3} 
bx r3 
.ltorg 

.global GetBattleLevelUpPortraitId_FE6
.type GetBattleLevelUpPortraitId_FE6, %function 
GetBattleLevelUpPortraitId_FE6:
push {lr} 
ldr r0, [r1]
ldrh r0, [r0, #6] @ portrait 
mov r1, #0 
bl GetRandomizedPortrait
mov r4, r0 
ldr r0, =0x860618c
blh 0x8008030
mov r0, #0x42
pop {r3} 
bx r3 
.ltorg 

.global GetBattleLevelUpPortraitId_FE7
.type GetBattleLevelUpPortraitId_FE7, %function 
GetBattleLevelUpPortraitId_FE7:
push {lr} 
ldrh r0, [r0, #6] @ portrait 
mov r1, #0 
bl GetRandomizedPortrait
mov r4, r0 
ldr r0, =0x8BDb59C 
blh 0x8006b50 
pop {r3} 
ldr r3, =0x8069381 
bx r3 
.ltorg 

.global GetMapLevelUpPortraitId_FE7
.type GetMapLevelUpPortraitId_FE7, %function 
GetMapLevelUpPortraitId_FE7:
push {lr} 
ldr r1, [r0] 
ldr r0, [r1] 
ldrh r0, [r0, #6] @ portrait ID 
mov r1, #0 
bl GetRandomizedPortrait
mov r1, r0 
ldr r0, [r7] 
mov r3, #0x32 
ldsh r2, [r0, r3] 
pop {r3} 
bx r3 
.ltorg 


.global GetTraineePromoPortraitId_FE8
.type GetTraineePromoPortraitId_FE8, %function 
GetTraineePromoPortraitId_FE8:
push {lr} 
ldr r0, [r0] 
ldrh r0, [r0, #6] @ portrait ID 
mov r1, #0 
bl GetRandomizedPortrait
mov r1, #0x2e 
add r1, r4 
strb r0, [r1] 
pop {r3} 
ldr r3, =0x80Cd6dd
bx r3 
.ltorg 

.global GetBattleLevelUpPortraitId_FE8
.type GetBattleLevelUpPortraitId_FE8, %function 
GetBattleLevelUpPortraitId_FE8:
push {lr} 
ldrh r0, [r0, #6] @ portrait 
mov r1, #0 
bl GetRandomizedPortrait
mov r4, r0 
ldr r0, =0x87592cc
blh 0x8005544
pop {r3} 
ldr r3, =0x8073dc5
bx r3 
.ltorg 

.global GetMapLevelUpPortraitId_FE8
.type GetMapLevelUpPortraitId_FE8, %function 
GetMapLevelUpPortraitId_FE8:
push {lr} 
lsl r0, #2 
add r0, r2 
ldr r0, [r0] 
ldr r0, [r0] 
ldrh r0, [r0, #6] @ portrait ID 
mov r1, #0 
bl GetRandomizedPortrait
mov r1, r0 
mov r2, #0x32 
pop {r3} 
bx r3 
.ltorg 


.global DisplayStealOrDropIcon_FE6
.type DisplayStealOrDropIcon_FE6, %function 
DisplayStealOrDropIcon_FE6: 
push {lr} @ 2257C
mov r0, r4 @ unit 
bl MaybeDisplayStealOrDropIcon 
cmp r0, #0 
beq ExitIconFE6 
mov r0, #0x10 
ldrh r7, [r4, #0xC] @ state 
and r0, r7 
ExitIconFE6:
cmp r0, #0 
pop {r3} 
ldr r3, =0x8022585 
bx r3 
.ltorg 

.global DisplayStealOrDropIcon_FE7
.type DisplayStealOrDropIcon_FE7, %function 
DisplayStealOrDropIcon_FE7: 
push {lr} @ 25E04
mov r0, r4 @ unit 
bl MaybeDisplayStealOrDropIcon 
cmp r0, #0 
beq ExitIconFE7
mov r1, #0x10 
ldr r0, [r4, #0xC] @ state 
and r0, r1 
ExitIconFE7:
cmp r0, #0
pop {r3} 
ldr r3, =0x8025e0d
bx r3 
.ltorg 

.global DisplayStealOrDropIcon_FE8
.type DisplayStealOrDropIcon_FE8, %function 
DisplayStealOrDropIcon_FE8: 
push {lr} @ 278AC
mov r0, r4 @ unit 
bl MaybeDisplayStealOrDropIcon 
cmp r0, #0 
beq ExitIconFE8
mov r1, #0x10 
ldr r0, [r4, #0xC] @ state 
and r0, r1 
ExitIconFE8:
cmp r0, #0
pop {r3} 
ldr r3, =0x80278B5
bx r3 
.ltorg 


.global MakeStolenItemDroppable_FE6
.type MakeStolenItemDroppable_FE6, %function 
MakeStolenItemDroppable_FE6:
push {lr} 
blh 0x8018658 @ remove item 
mov r0, r5 
mov r1, r8 
blh 0x8012178 
ldr r3, =gActiveUnit 
ldr r3, [r3] 
ldrh r2, [r3, #0xC] @ state 
mov r1, #0x10 
lsl r1, #8 
orr r2, r1 
strh r2, [r3, #0xC] 
pop {r3} 
bx r3 
.ltorg 

.global MakeStolenItemDroppable_FE7
.type MakeStolenItemDroppable_FE7, %function 
MakeStolenItemDroppable_FE7:
push {lr} 
blh 0x8018D50 @ remove item 
mov r0, r5 
mov r1, r8 
blh 0x800EEF4 
ldr r3, =gActiveUnit 
ldr r3, [r3] 
ldr r2, [r3, #0xC] @ state 
mov r1, #0x10 
lsl r1, #8 
orr r2, r1 
str r2, [r3, #0xC] 
pop {r3} 
bx r3 
.ltorg 

.global MakeStolenItemDroppable_FE8
.type MakeStolenItemDroppable_FE8, %function 
MakeStolenItemDroppable_FE8:
push {lr} 
mov r0, r6 
blh 0x8019484 @ remove item 
mov r0, r5 
mov r1, r8 
blh 0x8011694 
ldr r3, =gActiveUnit 
ldr r3, [r3] 
ldr r2, [r3, #0xC] @ state 
mov r1, #0x10 
lsl r1, #8 
orr r2, r1 
str r2, [r3, #0xC] 
pop {r3} 
bx r3 
.ltorg 


.global DroppableItemHook_FE7
.type DroppableItemHook_FE7, %function 
DroppableItemHook_FE7: 
lsr r1, #0x10 
ldr r2, [sp] 
mov r0, r2 
mov r2, r7 
push {lr} 
bl NewPopup_ItemGot_NoRand
pop {r0} 
bx r0 
.ltorg 


.global DroppableItemHook_FE8
.type DroppableItemHook_FE8, %function 
DroppableItemHook_FE8: 
mov r0, r4 
mov r1, r5 
push {lr} 
bl NewPopup_ItemGot_NoRand
pop {r0} 
ldr r3, =0x80115d5 
bx r3
.ltorg 

.global FE6_RandBattleMusicHook
.type FE6_RandBattleMusicHook, %function 
FE6_RandBattleMusicHook: 
push {lr} 
mov r0, r5
bl RandomizeBattleMusic
mov r5, r0 
blh 0x804C500
cmp r0, #1 
beq ExitFE6RandBattleMusic_A
pop {r3} 
ldr r3, =0x805C55D
bx r3 
.ltorg 
ExitFE6RandBattleMusic_A: 
pop {r3} 
ldr r3, =0x805C565
bx r3 
.ltorg 

.global FE7_RandBattleMusicHook
.type FE7_RandBattleMusicHook, %function 
FE7_RandBattleMusicHook: 
push {lr} 
mov r0, r8
bl RandomizeBattleMusic
mov r8, r0 
blh 0x80554F0
cmp r0, #1 
bne ExitFE7RandBattleMusic_A
blh 0x8003F6C
pop {r3} 
ldr r3, =0x8067EB5
bx r3 
.ltorg 
ExitFE7RandBattleMusic_A: 
pop {r3} 
ldr r3, =0x8067EAD
bx r3 
.ltorg 


.global FE8_RandBattleMusicHook
.type FE8_RandBattleMusicHook, %function 
FE8_RandBattleMusicHook: 
push {lr} 
mov r0, r6 
bl RandomizeBattleMusic
mov r6, r0 
blh 0x805b028 
cmp r0, #1 
bne ExitFE8RandBattleMusic_A
blh 0x80028D0 
pop {r3} 
ldr r3, =0x8072711 
bx r3 
.ltorg 
ExitFE8RandBattleMusic_A: 
pop {r3} 
ldr r3, =0x8072709 
bx r3 
.ltorg 


.global MaybeUseGenericPalette_FE6
.type MaybeUseGenericPalette_FE6, %function 
MaybeUseGenericPalette_FE6: 
push {r4-r5, lr} 
mov r4, r0 @ unit 
ldr r0, [r2, #0x28] 
ldr r1, [r1, #0x24] 
orr r0, r1 
lsr r0, #8 
add r2, #0x23 
add r2, r0 
ldrb r5, [r2] 

mov r0, r4 @ unit 
bl IsClassOrRecruitmentRandomized
cmp r0, #0 
beq VanillaClassPaletteMethod_FE6 
bl ShouldDoJankyPalettes
cmp r0, #0 
bne VanillaClassPaletteMethod_FE6
mov r5, #0 @ always 0 if classes are randomized 
VanillaClassPaletteMethod_FE6: 
mov r0, r5 
sub r0, #1 
pop {r4-r5} 
pop {r3} 
bx r3 
.ltorg 

.global MaybeUseGenericPalette_FE7
.type MaybeUseGenericPalette_FE7, %function 
MaybeUseGenericPalette_FE7: 
push {r4-r5, lr} 
mov r4, r0
ldr r1, [r0, #4]  
ldr r0, [r2, #0x28] 
ldr r1, [r1, #0x28] 
orr r0, r1 
lsr r0, #8 

mov r1, #1 
and r0, r1 
add r2, #0x23 
add r2, r0 
ldrb r5, [r2] 

mov r0, r4 @ unit 
bl IsClassOrRecruitmentRandomized
cmp r0, #0 
beq VanillaClassPaletteMethod_FE7 
bl ShouldDoJankyPalettes
cmp r0, #0 
bne VanillaClassPaletteMethod_FE7
mov r5, #0 @ always 0 if classes are randomized 
VanillaClassPaletteMethod_FE7: 
strh r5, [r3] 
mov r0, r5 
sub r0, #1 
pop {r4-r5} 
pop {r3} 
bx r3 
.ltorg 

.global MaybeUseGenericPalette_FE8
.type MaybeUseGenericPalette_FE8, %function 
MaybeUseGenericPalette_FE8: 
push {r4-r5, lr} 

ldr r5, =0x203E110 @ added 
ldr r1, =0x8057A14
ldr r4, [r1] @ 203E1DC
cmp r0, #1 
beq GenericPaletteFalse
ldr r0, =0x8057A10
ldr r0, [r0] @ 202BCF0
add r0, #0x40 
ldrb r0, [r0] 
lsl r0, #0x1f 
cmp r0, #0 
beq GenericPaletteFalse
GenericPaletteTrue: 
mov r0, #1 
strh r0, [r4] 
strh r0, [r4, #2] 
b ExitGenericPalette_FE8 

GenericPaletteFalse: 
mov r0, r9 @ dfdr 
bl IsClassOrRecruitmentRandomized 
strh r0, [r4] 
cmp r0, #0 
beq DontOverwriteDfdr 
bl ShouldDoJankyPalettes
cmp r0, #0 
bne DontOverwriteDfdr 
mov r1, #0 
sub r1, #1 
strh r1, [r5] 
DontOverwriteDfdr: 


mov r0, r10 @ atkr 
bl IsClassOrRecruitmentRandomized 
strh r0, [r4, #2] 
cmp r0, #0 
beq DontOverwriteAtkr 
push {r0} 
bl ShouldDoJankyPalettes
mov r2, r0 @ just in case r0 matters 
pop {r0}
cmp r2, #0 
bne DontOverwriteAtkr
mov r1, #0 
sub r1, #1 
strh r1, [r5, #2] 
DontOverwriteAtkr: 

ExitGenericPalette_FE8: 
pop {r4-r5} 
pop {r3} 
bx r3 
.ltorg 


.global FE6_SeizeCantoFix
.type FE6_SeizeCantoFix, %function 
FE6_SeizeCantoFix: @ 1F524
ldr r1, =0x203956C 
mov r0, #0xF 
strb r0, [r1, #0x11] @ seize 
ldr r3, =gActiveUnit 
ldr r3, [r3] 
ldrh r0, [r3, #0xC] 
mov r1, #0x40 
orr r0, r1 
strh r0, [r3, #0xC] @ set canto'd bit 

mov r0, #0x17 
bx lr 

.global FE6_StartDifficultySelection
.type FE6_StartDifficultySelection, %function 
FE6_StartDifficultySelection: 
push {r4, lr} 
mov r4, r0 

mov r0, r4 

blh 0x80890D0 @0x80930D5 

@ copied some stuff from 80890d0 
@ proc+0x2e != 1 && proc+0x2e != 0x40: resume chapter I guess 
	@ 29128 is called if resuming in label 6 of gamectrl 5C4A34
@ 890d0 -> 13954 sets the proc+0x29 field as the label to goto [2023cc4+0x29]!!
mov r0, r4 
add r0, #0x2e 
ldrb r0, [r0]
cmp r0, #1 
beq ExitFe6 
cmp r0, #0x40 
beq ExitFe6  
@mov r11, r11 


ldr r3, =0x202AA48 
mov r0, #0xE 
ldsb r0, [r3, r0] 
cmp r0, #1 
bne ExitFe6


@blh 0x8089254 @ replaced function 
mov r0, r4 
bl StartConfigMenu
ExitFe6: 
mov r0, #0 
pop {r4} 
pop {r1} 
bx r1 
.ltorg 


.global FE7_StartDifficultySelection
.type FE7_StartDifficultySelection, %function 
FE7_StartDifficultySelection: 
push {r4, lr} 
mov r4, r0 


blh 0x80A4A25 @ replaced function 

ldr r0, [r4, #0x14] @ parent proc 
mov r1, #0x29 
add r1, r0 
ldrb r1, [r1] 
cmp r1, #5 
beq ExitFe7
@ldr r3, =gCh
@ldrb r0, [r3] 
@cmp r0, #0 
@beq ContinueFe7 
@
@
@ContinueFe7: 
bl GetSeed 
@mov r11, r11 
cmp r0, #0 
bne ExitFe7 

mov r0, r4 
bl StartConfigMenu
ExitFe7: 
mov r0, #0 
pop {r4} 
pop {r1} 
bx r1 
.ltorg 


.global FE8_StartDifficultySelection
.type FE8_StartDifficultySelection, %function 
FE8_StartDifficultySelection: 
push {r4, lr} 
mov r4, r0 
blh 0x80AA031

ldr r0, [r4, #0x14] @ parent proc 
mov r1, #0x29 
add r1, r0 
ldrb r1, [r1] 
cmp r1, #5 
beq ExitFe8 

bl GetSeed 
cmp r0, #0 
bne ExitFe8 

mov r0, r4 
bl StartConfigMenu
ExitFe8: 
mov r0, #0 
pop {r4}  
pop {r1} 
bx r1 
.ltorg 




.global CallSkill_Getter 
.type CallSkill_Getter, %function 
CallSkill_Getter: 
push {lr} 
ldr r1, =Skill_Getter 
ldr r1, [r1] 
cmp r1, #0 
beq DoNothing 
blh Skill_Getter 
b Exit_Skill_Getter 
DoNothing:
ldr r0, =0x30004B8 @ memory slot 0 always has 0 in it 
Exit_Skill_Getter:
pop {r3} 
bx r3 
.ltorg 

.global CallprConGetter 
.type CallprConGetter, %function 
CallprConGetter: 
push {lr} 
ldr r3, =UseAutoGetters
ldr r3, [r3] 
cmp r3, #1 
bne Replace_prConGetter 
ldr r3, =prConGetter 
ldr r3, [r3] 
cmp r3, #0 
beq Replace_prConGetter 
blh prConGetter 
b Exit_prConGetter 
Replace_prConGetter:
bl GetUnitCon
Exit_prConGetter:
pop {r3} 
bx r3 
.ltorg 

.global CallprAidGetter 
.type CallprAidGetter, %function 
CallprAidGetter: 
push {lr} 
ldr r3, =UseAutoGetters
ldr r3, [r3] 
cmp r3, #1 
bne Replace_prAidGetter 
ldr r3, =prAidGetter 
ldr r3, [r3] 
cmp r3, #0 
beq Replace_prAidGetter 
blh prAidGetter 
b Exit_prAidGetter 
Replace_prAidGetter:
blh GetUnitAid
Exit_prAidGetter:
pop {r3} 
bx r3 
.ltorg 


.global CallprMovGetter 
.type CallprMovGetter, %function 
CallprMovGetter: 
push {lr} 
ldr r3, =UseAutoGetters
ldr r3, [r3] 
cmp r3, #1 
bne Replace_prMovGetter 
ldr r3, =prMovGetter 
ldr r3, [r3] 
cmp r3, #0 
beq Replace_prMovGetter 
blh prMovGetter 
b Exit_prMovGetter 
Replace_prMovGetter:
bl GetUnitMov
Exit_prMovGetter:
pop {r3} 
bx r3 
.ltorg 

.global CallprMagGetter 
.type CallprMagGetter, %function 
CallprMagGetter: 
push {lr} 
ldr r3, =UseAutoGetters
ldr r3, [r3] 
cmp r3, #1 
bne Replace_prMagGetter 
ldr r3, =prMagGetter 
ldr r3, [r3] 
cmp r3, #0 
beq Replace_prMagGetter 
blh prMagGetter 
b Exit_prMagGetter 
Replace_prMagGetter:
bl GetUnitMag
Exit_prMagGetter:
pop {r3} 
bx r3 
.ltorg 

.global CallGet_Hp_Growth 
.type CallGet_Hp_Growth, %function 
CallGet_Hp_Growth: 
push {lr} 
ldr r3, =UseAutoGetters
ldr r3, [r3] 
cmp r3, #1 
bne Replace_Get_Hp_Growth 
ldr r3, =Get_Hp_Growth 
ldr r3, [r3] 
cmp r3, #0 
beq Replace_Get_Hp_Growth 
blh Get_Hp_Growth 
b Exit_Get_Hp_Growth 
Replace_Get_Hp_Growth:
mov r0, #0
sub r0, #1 
Exit_Get_Hp_Growth:
pop {r3} 
bx r3 
.ltorg 

.global CallGet_Str_Growth 
.type CallGet_Str_Growth, %function 
CallGet_Str_Growth: 
push {lr} 
ldr r3, =UseAutoGetters
ldr r3, [r3] 
cmp r3, #1 
bne Replace_Get_Str_Growth 
ldr r3, =Get_Str_Growth 
ldr r3, [r3] 
cmp r3, #0 
beq Replace_Get_Str_Growth 
blh Get_Str_Growth 
b Exit_Get_Str_Growth 
Replace_Get_Str_Growth:
mov r0, #0
sub r0, #1 
Exit_Get_Str_Growth:
pop {r3} 
bx r3 
.ltorg 

.global CallGet_Mag_Growth 
.type CallGet_Mag_Growth, %function 
CallGet_Mag_Growth: 
push {lr} 
ldr r3, =UseAutoGetters
ldr r3, [r3] 
cmp r3, #1 
bne Replace_Get_Mag_Growth 
ldr r3, =Get_Mag_Growth 
ldr r3, [r3] 
cmp r3, #0 
beq Replace_Get_Mag_Growth 
blh Get_Mag_Growth 
b Exit_Get_Mag_Growth 
Replace_Get_Mag_Growth:
mov r0, #0
sub r0, #1 
Exit_Get_Mag_Growth:
pop {r3} 
bx r3 
.ltorg 

.global CallGet_Skl_Growth 
.type CallGet_Skl_Growth, %function 
CallGet_Skl_Growth: 
push {lr} 
ldr r3, =UseAutoGetters
ldr r3, [r3] 
cmp r3, #1 
bne Replace_Get_Skl_Growth 
ldr r3, =Get_Skl_Growth 
ldr r3, [r3] 
cmp r3, #0 
beq Replace_Get_Skl_Growth 
blh Get_Skl_Growth 
b Exit_Get_Skl_Growth 
Replace_Get_Skl_Growth:
mov r0, #0
sub r0, #1 
Exit_Get_Skl_Growth:
pop {r3} 
bx r3 
.ltorg 

.global CallGet_Spd_Growth 
.type CallGet_Spd_Growth, %function 
CallGet_Spd_Growth: 
push {lr} 
ldr r3, =UseAutoGetters
ldr r3, [r3] 
cmp r3, #1 
bne Replace_Get_Spd_Growth 
ldr r3, =Get_Spd_Growth 
ldr r3, [r3] 
cmp r3, #0 
beq Replace_Get_Spd_Growth 
blh Get_Spd_Growth 
b Exit_Get_Spd_Growth 
Replace_Get_Spd_Growth:
mov r0, #0
sub r0, #1 
Exit_Get_Spd_Growth:
pop {r3} 
bx r3 
.ltorg 

.global CallGet_Luk_Growth 
.type CallGet_Luk_Growth, %function 
CallGet_Luk_Growth: 
push {lr} 
ldr r3, =UseAutoGetters
ldr r3, [r3] 
cmp r3, #1 
bne Replace_Get_Luk_Growth 
ldr r3, =Get_Luk_Growth 
ldr r3, [r3] 
cmp r3, #0 
beq Replace_Get_Luk_Growth 
blh Get_Luk_Growth 
b Exit_Get_Luk_Growth 
Replace_Get_Luk_Growth:
mov r0, #0
sub r0, #1 
Exit_Get_Luk_Growth:
pop {r3} 
bx r3 
.ltorg 

.global CallGet_Def_Growth 
.type CallGet_Def_Growth, %function 
CallGet_Def_Growth: 
push {lr} 
ldr r3, =UseAutoGetters
ldr r3, [r3] 
cmp r3, #1 
bne Replace_Get_Def_Growth 
ldr r3, =Get_Def_Growth 
ldr r3, [r3] 
cmp r3, #0 
beq Replace_Get_Def_Growth 
blh Get_Def_Growth 
b Exit_Get_Def_Growth 
Replace_Get_Def_Growth:
mov r0, #0
sub r0, #1 
Exit_Get_Def_Growth:
pop {r3} 
bx r3 
.ltorg 

.global CallGet_Res_Growth 
.type CallGet_Res_Growth, %function 
CallGet_Res_Growth: 
push {lr} 
ldr r3, =UseAutoGetters
ldr r3, [r3] 
cmp r3, #1 
bne Replace_Get_Res_Growth 
ldr r3, =Get_Res_Growth 
ldr r3, [r3] 
cmp r3, #0 
beq Replace_Get_Res_Growth 
blh Get_Res_Growth 
b Exit_Get_Res_Growth 
Replace_Get_Res_Growth:
mov r0, #0
sub r0, #1 
Exit_Get_Res_Growth:
pop {r3} 
bx r3 
.ltorg 

.global CallGetMaxHP
.type CallGetMaxHP, %function 
CallGetMaxHP: 
push {lr} 
@ prMaxHPGetter is for unit's current max hp, not hp cap 
Replace_GetMaxHP:
bl GetUnitHPCap
Exit_GetMaxHP:
pop {r3} 
bx r3 
.ltorg 


.global ConditionallyRemoveGlowy @ 88588 
.type ConditionallyRemoveGlowy, %function 
ConditionallyRemoveGlowy: 
push {lr} 
ldr r0, =AlwaysRemoveGlowy 
ldr r0, [r0] 
cmp r0, #0 
bne SkipGlowy 
bl IsAnythingRandomized
cmp r0, #0 
bne SkipGlowy 
ldr r0, =0x8088634
ldr r0, [r0]
mov r2, #0x91 
lsl r2, #5 
mov r1, r4 
blh 0x80D74A0 
SkipGlowy: 
pop {r0} 
bx r0 
.ltorg 

@ Hooked at 0x11CC in 800114C FlushBackgrounds
.global RandColoursHook
.type RandColoursHook, %function
RandColoursHook: 
push {lr} 
ldr   r0, =gPaletteBuffer
mov   r1, #0xA0
lsl   r1, #0x13 @ 0x5000000
mov   r2, #0x80
lsl   r2, #0x1
swi   #0xC        @ CPUFastSet.
bl MaybeRandomizeColours 
pop {r0} 
bx r0

@ Increments hue counter.
@ Applies hue shift to palette.
@   +0x29b  hue counter [0, 255].
.thumb
.global RandColours
.type RandColours, %function
RandColours: 
push  {r4-r7, r14}
mov   r4, r8
mov   r5, r9
mov   r6, r10
mov   r7, r11
push  {r4-r7}
sub   sp, #0x4
lsl r4, r0, #5 @ * 32 for palette bank address offset 
lsl r1, #1 @ specific index col to start at 
add r4, r1 
ldr r5, =gPaletteBuffer 
add r5, r4 
mov r8, r5 

ldr   r0, =0x5000000 @RandomColoursBuffer
add r0, r4 
mov   r9, r0
lsl r2, #1 @ number of colours 
add r0, r2 
mov r10, r0 

@ r3 as portrait id randomized into a number between 40 and 210 
mov r2, r3 

@ Enable palette update.
ldr   r0, =gPaletteSyncFlag
mov   r1, #0x1
strb  r1, [r0]

@ Boogie-woogie.
mov   r0, #18
mul   r2, r0
ldr   r0, =DIS_matrixTable
add   r4, r0, r2
mov   r6, #0x0
mov   r7, #0x1
lsl   r7, #0xC

Loop:


  Loop2:
    mov   r0, r8
    ldrh  r0, [r0]
    lsl   r1, r0, #0x1B
    lsr   r1, #0x1B           @ Red.
    lsl   r2, r0, #0x16
    lsr   r2, #0x1B           @ Green.
    lsl   r3, r0, #0x11
    lsr   r3, #0x1B           @ Blue.
    
    @ Multiply with matrix.
    mov   r5, #0x0
    ldsh  r5, [r4, r5]
    mul   r5, r1
    mov   r0, r5              @ R.
    mov   r5, #0x2
    ldsh  r5, [r4, r5]
    mul   r5, r2
    add   r0, r5              @ G.
    mov   r5, #0x4
    ldsh  r5, [r4, r5]
    mul   r5, r3
    add   r0, r5              @ B.
    asr   r0, #0xC
    
    @ Ensure value in [0, 31].
    cmp   r0, #0x0
    bge   L1
      mov   r0, #0x0          @ At least 0.
      b     L2
    L1:
    cmp   r0, #0x1F
    ble   L2
      mov   r0, #0x1F         @ At most 31.
    L2:
    
    mov   r1, sp
    strb  r0, [r1, r6]
    add   r4, #0x6
    add   r6, #0x1
    cmp   r6, #0x3
    blt   Loop2
  
  mov   r2, sp
  ldrb  r0, [r2]
  ldrb  r1, [r2, #0x1]
  lsl   r1, #0x5
  add   r0, r1
  ldrb  r1, [r2, #0x2]
  lsl   r1, #0xA
  add   r0, r1
  mov   r1, r9
  strh  r0, [r1]
  mov   r0, #0x2
  add   r8, r0
  add   r9, r0
  sub   r4, #0x12
  mov   r6, #0x0
  cmp   r9, r10
  blt   Loop


return:
add   sp, #0x4
pop   {r4-r7}
mov   r8, r4
mov   r9, r5
mov   r10, r6
mov   r11, r7
pop   {r4-r7}
pop   {r0}
bx    r0

.ltorg 
.global NewClearBWLFunction_FE7 
.type NewClearBWLFunction_FE7, %function 
NewClearBWLFunction_FE7:
push {r4-r7, lr} 

@ added - save BWL+some person as randomizer data 
ldr r7, =RandValues
ldr r7, [r7] @ probably 0x203eb30 
ldr r4, [r7] @ values 
ldr r5, [r7, #4] 
ldr r6, [r7, #8] 
ldr r7, [r7, #12] 
@ added 

sub sp, #4 
mov r0, sp 
mov r3, #0 
strh r3, [r0] 
ldr r1, =0x203E7A0
ldr r2, =0x1000230 
blh 0x80BFA10 @ CpuSet 

@ added - restore randomizer values 
ldr r3, =RandValues 
ldr r3, [r3] 
str r4, [r3, #0] 
str r5, [r3, #4] 
str r6, [r3, #8] 
str r7, [r3, #12] 
@ added 

ldr r4, =0x202BBF8
ldr r0, [r4, #0x38] 
ldr r1, =0xF00000FF
and r0, r1 
str r0, [r4, #0x38] 
mov r0, #0xF 
ldrh r1, [r4, #0x36] 
and r0, r1 
strh r0, [r4, #0x36] 
mov r0, r4 
add r0, #0x38 
mov r1, #0 
strb r1, [r0] 
ldr r0, [r4, #0x34] 
ldr r1, =0xFFF00000
and r0, r1 
str r0, [r4, #0x34] 
blh 0x8017120 
str r0, [r4, #0x30] 
add sp, #4 
pop {r4-r7} 
pop {r0} 
bx r0 
.ltorg 
