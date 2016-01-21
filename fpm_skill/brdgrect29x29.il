;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Diodes/Bridge rectifier
;Desc:29mmx29mm Rectangle bridge rectifier, KBPC5010
;Vendor:stavrosatic@gmail.com
;Count:1
;CVG64:
;Datasheet:

Courtyard=0.5 PitchHor=14.3 PitchVer=18.1 pA=29.0 pB=29.0 pH=11.0
pName="BRDGRECT29X29"
_PrepareNewSym(pName)
;pin
procedure( 
    _Pad_Slot(PadWidth PadHeight SlotWidth SlotHeight)
        let( (drill_data pad_list PadName Pad)
        drill_data = make_axlPadStackDrill(?figure 'OBLONG_Y, 
            ?figureSize SlotWidth:SlotHeight, ?plating 'PLATED, 
            ?holeType 'OVAL_SLOT, ?slotSize SlotWidth:SlotHeight)
        pad_list = cons(make_axlPadStackPad( ?layer "TOP", ?type 'REGULAR, 
                        ?figure 'OBLONG_Y, ?figureSize PadWidth:PadHeight) nil )
        pad_list = cons(make_axlPadStackPad( ?layer "DEFAULT INTERNAL", ?type 'REGULAR,
                        ?figure 'OBLONG_Y, ?figureSize PadWidth*0.9:PadHeight*0.9) pad_list)
        pad_list = cons(make_axlPadStackPad( ?layer "BOTTOM", ?type 'REGULAR,
                        ?figure 'OBLONG_Y, ?figureSize PadWidth:PadHeight) pad_list ) 
        pad_list = cons(make_axlPadStackPad( ?layer "SOLDERMASK_TOP", ?type nil
                        ?figure 'OBLONG_Y, ?figureSize PadWidth+solder_mask_offset:PadHeight+solder_mask_offset) pad_list ) 
        pad_list = cons(make_axlPadStackPad( ?layer "SOLDERMASK_BOTTOM", ?type nil
                        ?figure 'OBLONG_Y, ?figureSize PadWidth+solder_mask_offset:PadHeight+solder_mask_offset) pad_list ) 

        sprintf(PadName "pad_slot_%d_%d_%d_%d" round(PadWidth*100) 
            round(PadHeight*100) round(SlotWidth*100) round(SlotHeight*100) )
        Pad = axlDBCreatePadStack( PadName drill_data pad_list t)
        axlPadstackToDisk( PadName PadName)
        Pad
    )   ; end let
)       ; end procedure


PadN1 = _Pad_Slot(3.0 8.8 1.0 6.8)
PadN = _Pad_Slot(8.8 3.0 6.8 1.0)

_CreatePin(PadN1 -PitchVer/2:PitchHor/2 "1")
_CreatePin(PadN  -PitchHor/2:-PitchVer/2 "2")
_CreatePin(PadN  PitchHor/2:-PitchVer/2 "3")
_CreatePin(PadN  PitchHor/2:PitchVer/2 "4")

PadM = _PadTH_Default(12.0 6.0) 
_CreatePinMechanical(PadM 0:0)

;bound
_Layer(lPkgGeoPlaceT) ;PlaceTop
_BoundHeight(_ShapeRectangle(pA+Courtyard*2 pB+Courtyard*2 0:0) pH)
;A B Center Height
_Layer(lPkgGeoDfaT)
_BoundHeight(_ShapeRectangle(pA pB) pH pName)
;silkscreen & assembly
for(i 0 1
    if(i==1 _Layer(lPkgGeoAsmT) _Layer(lPkgGeoSilkT))
    ;_Dot(-Pitch/2:-pL/2+pPad .5)
    ;_Rectangle(pA pB 0:0) ;A B Center Fillet

    _Line( list(-pA/2:pB/2-1.5 -pA/2:-pB/2) )
    _Line( list(-pA/2:-pB/2 pA/2:-pB/2) )
    _Line( list(pA/2:-pB/2 pA/2:pB/2) )
    _Line( list(pA/2:pB/2 -pA/2+1.5:pB/2) )
    _Line( list(-pA/2+1.5:pB/2 -pA/2:pB/2-1.5) )
   )
;ref & val
_CreateRefValue(pName 0:0)
_CrossCenter()
_SaveDesign(pName)
_MakeDevice(pName,2)
