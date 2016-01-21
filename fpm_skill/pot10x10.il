;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Potentiometer/Through hole potentiometer 
;Desc:POT10x10
;Vendor:Stavros@foretechstudio
;Count:1

Courtyard=0.3 pL=5.08 pA=10 pB=12 pH=12.00 pPad=1.5 pHole=0.9

pName="POT10X10"
_PrepareNewSym(pName)

;pin
PadN=_PadTH_Default(pPad pHole)
PadM=_Pad_Slot(1.4 3.0 0.6 2.2)

_CreatePin(PadN -pL/2:-7.2 "1")
_CreatePin(PadN 0:-7.2 "2")
_CreatePin(PadN pL/2:-7.2 "3")
_CreatePinMechanical(PadM -5:0)
_CreatePinMechanical(PadM 5:0)

;bound
_Layer(lPkgGeoPlaceT) ;PlaceTop
_BoundHeight(_ShapeRectangle(pA+Courtyard*2 pB+Courtyard*2 0:0) pH)
;A B Center Height
_Layer(lPkgGeoDfaT) 
_BoundHeight(_ShapeRectangle(pA pB) pH pName)

;silkscreen & assembly
for(i 0 1
	if(i==1 
		_Layer(lPkgGeoAsmT) 
	_Layer(lPkgGeoSilkT))
;_Dot(-Pitch/2:-pL/2+pPad .5)
	_Rectangle(pA pB 0:0) ;A B Center Fillet
)

;ref & val
_CreateRefValue(pName 0:0)
_CrossCenter()

_SaveDesign(pName)
_MakeDevice(pName,2)
