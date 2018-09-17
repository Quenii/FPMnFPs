;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Switch/Button
;Desc:Pushbutton 6x6
;Vendor:Tariel@Foretech Studio
;Count:1
;CVG64:
;Datasheet:

Courtyard=.3
Pitch=5.08
pL=7.62
pA=6.00 pB=6.00 pH=5.00
pPad=1.50 pHole=0.90

pName="PUSHBT6X6PERF"
_PrepareNewSym(pName)

;pin
PadN1=_PadTH_Default(pPad pHole t)
PadN=_PadTH_Default(pPad pHole)
_CreatePin(PadN1 -Pitch/2:-pL/2 "1")
_CreatePin(PadN Pitch/2:-pL/2 "2")
_CreatePinMechanical(PadN -Pitch/2:pL/2)
_CreatePinMechanical(PadN Pitch/2:pL/2)

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
_Rectangle(pA pB 0:0 1) ;A B Center Fillet
)

;ref & val
_CreateRefValue(pName 0:0)
_CrossCenter()

_SaveDesign(pName)
_MakeDevice(pName,2)

