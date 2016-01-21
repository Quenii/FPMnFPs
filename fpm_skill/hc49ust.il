;在封装下面Top层涂满丝印，这样可以省掉晶振垫的成本了
;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Crystal/Through hole crystal
;Desc:generic HC49US through hole
;Vendor:Kurapica@Foretech Studio
;Count:1
;CVG64:
;Datasheet:

Courtyard=0.5
Pitch=4.88
pA=11.05 pB=4.8 pH=3.5
pPad=1.5 pHole=0.7

pName="HC49UST"
_PrepareNewSym(pName)

;pin
PadN=_PadTH_Default(pPad pHole)
_CreatePin(PadN -Pitch/2:0 "1")
_CreatePin(PadN Pitch/2:0 "2")

;bound
_Layer(lPkgGeoPlaceT) ;PlaceTop
_BoundHeight(_ShapeRectangle(pA+Courtyard*2 pB+Courtyard*2 0:0) pH)
;A B Center Height
_Layer(lPkgGeoDfaT)
_BoundHeight(_ShapeRectangle(pA pB) pH "HC49UST")

;silkscreen & assembly
for(i 0 1
if(i==1 _Layer(lPkgGeoAsmT) _Layer(lPkgGeoSilkT))
_Rectangle(pA pB 0:0 1.5) ;A B Center Fillet
)
;fill bottom with silkscreen
_Layer(lPkgGeoSilkT)
for(i 1 12
_Rectangle(pA-0.2*i pB-0.2*i 0:0 1.5-0.1*i)
)
_Circle(1.4 -Pitch/2:0 1.3)
_Circle(1.4 Pitch/2:0 1.3)
_Rectangle(1.2 1.2 0:0 0 1.2)

;ref & val
_CreateRefValue(pName 0:0)
_CrossCenter()

_SaveDesign(pName)
_MakeDevice(pName,2)

