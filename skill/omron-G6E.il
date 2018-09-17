;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Misc/Relays
;Desc:TH relays
;Vendor:Omron
;Count:1
;CVG64:bitmap field, not implemented yet.
;Datasheet:

pA     =16.0 
pB     =9.91
pPad   =1.77
pHole  =1.05
Pitch  =2.54

pName="OMRON-G6E"
_PrepareNewSym(pName)
Courtyard=1
;pin
PadN=_PadTH_Default(pPad pHole))
_CreatePin(PadN 2*Pitch+Pitch/2:Pitch+Pitch/2 "7")
_CreatePin(PadN -(2*Pitch+Pitch/2):Pitch+Pitch/2 "12")
_CreatePin(PadN -(2*Pitch+Pitch/2):-(Pitch+Pitch/2) "1")
_CreatePin(PadN 2*Pitch+Pitch/2:-(Pitch+Pitch/2) "6")
_CreatePin(PadN -Pitch/2:(Pitch+Pitch/2) "10")

;bound
_Layer(lPkgGeoPlaceT) ;ÇÐ»»µ½PlaceTop²ã
_BoundHeight(_ShapeRectangle(pA+Courtyard*2 pB+Courtyard*2 0:0 0.1) 8.38)

for(asm 0 1
	if(asm==1 _Layer(lPkgGeoAsmT) _Layer(lPkgGeoSilkT));;assembly and silkscreen
	_Rectangle(pA pB)   ;¾ØÐÎ
	;polarity mark
	_Triangle(-2*Pitch-Pitch/2:-pB/2 2 90)
)

_CrossCenter()
_CreateRefValue(pName)

_SaveDesign(pName)
