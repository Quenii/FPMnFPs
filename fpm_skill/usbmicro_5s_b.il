;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Connector/USB Connector
;Desc:Micro USB Standard Type B, Surface Mount
;Vendor:Stavros@Foretech Studio
;Count:1
;CVG64:
;Datasheet:

Courtyard=0
pA=4.7 pB=9.8 pH=2.6 pL=5.7 pW=8.1 pitch=0.65 pName="USBMICRO_5S_B"

_PrepareNewSym(pName)

PadN  = _PadSMFillet( 2.0 0.4 )
PadN15  = _PadSMFillet( 2.0 0.6 )
PadM1  = _PadTH_Default(1.5 1.0)
PadM2  = _PadTH_Default(1.0 0.7)
;pin
_CreatePin( PadM1 0.0:3.63 "S1")
_CreatePin( PadM1 0.0:-3.63 "S2")
_CreatePin( PadM2 2.7:2.43 "S3")
_CreatePin( PadM2 2.7:-2.43 "S4")

_CreatePin( PadN15 3.1:pitch*2+0.1 1 )
_CreatePin( PadN   3.1:pitch*1 2 )
_CreatePin( PadN   3.1:pitch*0 3 )
_CreatePin( PadN   3.1:pitch*-1 4 )
_CreatePin( PadN15 3.1:pitch*-2-0.1 5 )

;bound
_Layer(lPkgGeoPlaceT) ;PlaceTop
_BoundHeight(_ShapeRectangle(pA+Courtyard*2 pB+Courtyard*2 0.9:0) pH)

;A B Center Height
_Layer(lPkgGeoDfaT) 
_BoundHeight(_ShapeRectangle(pL pW 0.4:0) pH pName)

;silkscreen & assembly
for(i 0 1
    if(i==1 _Layer(lPkgGeoAsmT) _Layer(lPkgGeoSilkT))
;_Dot(-Pitch/2:-pL/2+pPad .5)
    _Rectangle(pL pW 0.4:0 0) ;A B Center Fillet
)

;ref & val
_CreateRefValue(pName 0:0)
_CrossCenter()

_SaveDesign(pName)
_MakeDevice(pName,2)
