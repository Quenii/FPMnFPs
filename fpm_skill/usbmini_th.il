;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Connector/USB Connector
;Desc:MINI USB Through Hole Jack
;Vendor:Stavros@Foretech Studio
;Count:1
;CVG64:
;Datasheet:

Courtyard=.2
;Pitch=5.08
;pL=7.62
pA=7.8 pB=9.2 pH=3.9
;pPad=1.50 pHole=0.90

pName="USBMINI_TH"
_PrepareNewSym(pName)

    ;pin
PadMech = _PadTH_Default( 2.1 1.5 )
PadN = _PadTH_Default(0.9 0.5)
_CreatePin(PadMech -pA/2:pB/2-3.15 "S1")
_CreatePin(PadMech  pA/2:pB/2-3.15 "S2")
_CreatePin(PadMech -pA/2:pB/2-7.8 "S3")
_CreatePin(PadMech  pA/2:pB/2-7.8 "S4")
_CreatePin( PadN  1.6:pB/2-8.7 "1")
_CreatePin( PadN  0.8:pB/2-7.5 "2")
_CreatePin( PadN    0:pB/2-8.7 "3")
_CreatePin( PadN -0.8:pB/2-7.5 "4")
_CreatePin( PadN -1.6:pB/2-8.7 "5")

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
    _Rectangle(pA pB 0:0 0) ;A B Center Fillet
)

    ;ref & val
_CreateRefValue(pName 0:0)
_CrossCenter()

_SaveDesign(pName)
_MakeDevice(pName,2)
