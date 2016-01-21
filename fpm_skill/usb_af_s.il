;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Connector/USB Connector
;Desc:USB type A Female SMD
;Vendor:Stavros@Foretech Studio
;Count:1
;CVG64:bitmap field, not implemented yet.

pA=14 pB=13 pH=7.2
Courtyard=0.2
Ofs=4
sprintf(pName "USB_AF_S")
_PrepareNewSym(pName)

;pin
PadM = _PadSMFillet( 3.8 1.1 )
PadMS = _PadSMFillet( 5.3 2.3 )
PadN = _PadTH_Default( 1.5 1.3 )

_CreatePin(PadMS Ofs:7.4 "S1" )
_CreatePin(PadMS Ofs:-7.4 "S2" )
_CreatePin(PadM Ofs+2.4:3.5 "1" )
_CreatePin(PadM Ofs+2.4:1 "2" )
_CreatePin(PadM Ofs+2.4:-1 "3" )
_CreatePin(PadM Ofs+2.4:-3.5 "4" )
_CreatePinMechanical(PadN Ofs-1.3:2.5 )
_CreatePinMechanical(PadN Ofs-1.3:-2.5)

;bound
_Layer(lPkgGeoPlaceT) _BoundHeight(_ShapeRectangle(pA+Courtyard pB+Courtyard) pH)
_Layer(lPkgGeoDfaT) _BoundHeight(_ShapeRectangle(pA+Courtyard pB+Courtyard) pH pName)

;silkscreen & assembly
for(i 1 2 if(i==1 _Layer(lPkgGeoSilkT) _Layer(lPkgGeoAsmT))
;_Line(list(0:0 0:2))
_Rectangle(pA pB)
)

;ref & val
_CreateRefValue(pName 0:-1 0:-1)
_SaveDesign(pName)
