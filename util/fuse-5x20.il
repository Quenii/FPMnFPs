;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Misc/Fuse
;Desc:Standard 5X20 fuse with socket
;Vendor:Tariel@Foretech Studio
;Count:1
;CVG64:
;Datasheet:

Courtyard=1.0 pA=21.0 pB=7.2 pH=10.0 pPad=2.2 pHole=1.3

pName="FUSE-5X20"
_PrepareNewSym(pName)

;pin

PadN=_PadTH_Default(pPad pHole)
_CreatePin(PadN -10.5:0 "1")
_CreatePin(PadN 10.5:0 "2")
_CreatePinMechanical(PadN -5.5:0)
_CreatePinMechanical(PadN 5.5:0)

;bound
_Layer(lPkgGeoPlaceT) ;PlaceTop
_BoundHeight(_ShapeRectangle(pA+Courtyard+0.6 pB+Courtyard 0:0) pH)


;A B Center Height
_Layer(lPkgGeoDfaT) 
_BoundHeight(_ShapeRectangle(pA pB) pH "FUSE-5X20")

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
