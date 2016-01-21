;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Connector/USB
;Desc:USB type A
;Vendor:EDAC Inc.
;Count:1
;CVG64:bitmap field, not implemented yet.

xL=13.14 pH=6.99
Courtyard=1.0
sprintf(pName "USB_AF_TH")
_PrepareNewSym(pName)

;pin
PN1=_PadTH_Default(1.5 0.92)
;PN2=_PadTH_Default(3.1 2.30) 
PN2 = _Pad_Slot(1.2 3.1 0.8 2.3)
px=xL/2.0
Ps='(-3.5 -1 1.0 3.5) Pnum=0
foreach(Po Ps Pnum++ sprintf(pin_name,"%d",Pnum) _CreatePin(PN1 Po:13.0 pin_name))
_CreatePin(PN2 -px:10.28, "S1")
_CreatePin(PN2 px:10.28, "S2")

;bound
_Layer(lPkgGeoPlaceT) _BoundHeight(_ShapeRectangle(xL+Courtyard 14+Courtyard 0:(14+Courtyard)/2.0) pH)
_Layer(lPkgGeoDfaT) _BoundHeight(_ShapeRectangle(xL 14 0:14/2.0) pH "USB_AF_TH")

;silkscreen & assembly
for(i 1 2 if(i==1 _Layer(lPkgGeoSilkT) _Layer(lPkgGeoAsmT))
    ;		_Line(list(0:0 0:2))
    _Rectangle(xL 14 0:14/2)
)

;ref & val
_CreateRefValue(pName 0:-1 0:-1)
_SaveDesign(pName)
