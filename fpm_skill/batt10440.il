;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Socket/Battery Holder
;Desc:Single cell AAA/7#/10440 battery holder
;Vendor:stavrosatic@gmail.com
;Count:1

Courtyard=0.3 pitch=46.0 pA=50.0 pB=13.0 pH=12.00
pName="batt10440"
_PrepareNewSym(pName)

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


PadN = _Pad_Slot(2.6 5.0 0.8 3.2)

_CreatePin(PadN -pitch/2:0 "1")
_CreatePin(PadN pitch/2:0 "2")

_Layer(lPkgGeoPlaceT)
_BoundHeight(_ShapeRectangle(pA+Courtyard*2 pB+Courtyard*2 0:0) pH)


_Layer(lPkgGeoDfaT) 
_BoundHeight(_ShapeRectangle(pA pB) pH pName)

for(i 0 1
	if(i==1 
		_Layer(lPkgGeoAsmT) 
	_Layer(lPkgGeoSilkT))
	_Rectangle(pA pB 0:0)
)

_CreateRefValue(pName 0:0 0:0)
_CrossCenter()

_SaveDesign(pName)
_MakeDevice(pName,2)
