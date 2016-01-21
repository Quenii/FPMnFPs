;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Transistor/SMT Transistor
;Desc:SOT-23 Transistor, extended pad
;Vendor:Stavros@Foretech Studio
;Count:1
;CVG64:
;Datasheet:

Courtyard=0.2
pA=3.0 pB=4.0 pH=2.0
pName="SOT23X"
_PrepareNewSym(pName)
PadN1 = _PadSMFillet( 0.8 1.0 )
PadN2 = _PadSMFillet( 1.4 1.8 )
    ;pin
_CreatePin( PadN1 -0.95:-1.4 "1")
_CreatePin( PadN1 0.95:-1.4 "2")
_CreatePin( PadN2 0:1.2 "3")
;bound
_Layer(lPkgGeoPlaceT) ;PlaceTop
_BoundHeight(_ShapeRectangle(pA+Courtyard*2 pB+Courtyard*2 0:0) pH)
    ;A B Center Height
_Layer(lPkgGeoDfaT) 
_BoundHeight(_ShapeRectangle(pA pB 0:0) pH pName)
;_BoundHeight(_ShapeRectangle(pL pW 0.4:0) pH pName)
    ;silkscreen & assembly
for(i 0 1
    if(i==1 _Layer(lPkgGeoAsmT) _Layer(lPkgGeoSilkT))
;    _Rectangle(pL pW 0.4:0 0) ;A B Center Fillet
    _Rectangle(3.0 1.8 0:0)
)
    ;ref & val
_CreateRefValue(pName 0:0)
_CrossCenter()
_SaveDesign(pName)
_MakeDevice(pName,2)
