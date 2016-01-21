;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Transistor/SMT Transistor
;Desc:TO-92 Transistor
;Vendor:Stavros@Foretech Studio
;Count:1
;CVG64:
;Datasheet:

Courtyard=0.2
pA=8.0 pB=4.6 pH=2.0
pName="TO92S"
_PrepareNewSym(pName)
PadN = _PadSMFillet( 1.6 1.2 )
    ;pin
_CreatePin( PadN 3.2:1.8 "3")
_CreatePin( PadN 3.2:0 "2")
_CreatePin( PadN 3.2:-1.8 "1")
;bound
_Layer(lPkgGeoPlaceT) ;PlaceTop
_BoundHeight(_ShapeRectangle(pA+Courtyard*2 pB+Courtyard*2 0:0) pH)
    ;A B Center Height
_Layer(lPkgGeoDfaT) 
_BoundHeight(_ShapeRectangle(pA+Courtyard*2 pB+Courtyard*2 0:0) pH pName)
;_BoundHeight(_ShapeRectangle(pL pW 0.4:0) pH pName)
    ;silkscreen & assembly
for(i 0 1
    if(i==1 _Layer(lPkgGeoAsmT) _Layer(lPkgGeoSilkT))
;    _Rectangle(pL pW 0.4:0 0) ;A B Center Fillet
    _Rectangle(4.6 4.6 -1.6:0)
    _Line( list(0.7:1.3 2.3:1.8) )
    _Line( list(0.7:0 2.3:0) )
    _Line( list(0.7:-1.3 2.3:-1.8) )
)
    ;ref & val
_CreateRefValue(pName 0:0)
_CrossCenter()
_SaveDesign(pName)
_MakeDevice(pName,2)
