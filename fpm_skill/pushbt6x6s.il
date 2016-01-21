;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Switch/Button
;Desc:Pushbutton 6x6
;Vendor:Stavros@Foretech Studio
;Count:1
;CVG64:
;Datasheet:

Courtyard=0.2 Pitch=4.5 pL=8.1 pA=6.0 pB=6.0 pH=5.0

pName="PUSHBT6X6S"
_PrepareNewSym(pName)

;pin
PadN = _PadSMFillet(1.2 1.6)

_CreatePin(PadN -Pitch/2:-pL/2 "1")
_CreatePin(PadN Pitch/2:-pL/2 "2")
_CreatePinMechanical(PadN -Pitch/2:pL/2)
_CreatePinMechanical(PadN Pitch/2:pL/2)

;bound
_Layer(lPkgGeoPlaceT) ;PlaceTop
_BoundHeight(_ShapeRectangle(pA+Courtyard*2 10.0+Courtyard*2 0:0) pH)


;A B Center Height
_Layer(lPkgGeoDfaT) 
_BoundHeight(_ShapeRectangle(pA pB) pH pName)

;silkscreen & assembly
for(i 0 1
if(i==1 _Layer(lPkgGeoAsmT) _Layer(lPkgGeoSilkT))
;_Dot(-Pitch/2:-pL/2+pPad .5)
_Rectangle(pA pB 0:0 0.2) ;A B Center Fillet
)

;ref & val
_CreateRefValue(pName 0:0)
_CrossCenter()

_SaveDesign(pName)
_MakeDevice(pName,2)
