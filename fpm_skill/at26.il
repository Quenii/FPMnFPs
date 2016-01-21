;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Crystal/Through hole crystal
;Desc:Cylinder type crystal 2x6
;Vendor:Stavros@Foretech Studio
;Count:1
;CVG64:
;Datasheet:

Courtyard=0.2
Pitch=4.88
pA=6.0 pB=2.0 pH=2.0
pPad=1.1 pHole=0.4

pName="AT26"
_PrepareNewSym(pName)

;pin
PadN=_PadTH_Default(pPad pHole)
PadN1=_PadTH_Default(1.5 0.9)

_CreatePin(PadN -pA/2-1.5:0.8 "1")
_CreatePin(PadN -pA/2-1.5:-0.8 "2")
_CreatePin(PadN1 1.5:-pB/2 "S1")
_CreatePin(PadN1 1.5:pB/2 "S2")

;bound
_Layer(lPkgGeoPlaceT) ;PlaceTop
_BoundHeight(_ShapeRectangle(pA+Courtyard*2 pB+Courtyard*2 0:0) pH)
;A B Center Height
_Layer(lPkgGeoDfaT)
_BoundHeight(_ShapeRectangle(pA pB) pH pName)

;silkscreen & assembly
for(i 0 1
    if(i==1 _Layer(lPkgGeoAsmT) _Layer(lPkgGeoSilkT))
    _Rectangle(pA pB 0:0 0.1) ;A B Center Fillet
)

;_Circle(1.4 -Pitch/2:0 1.3)
;_Circle(1.4 Pitch/2:0 1.3)
_Rectangle( pA pB 0:0 0.2 )

;ref & val
_CreateRefValue(pName 0:0)
_CrossCenter()

_SaveDesign(pName)
_MakeDevice(pName,2)

