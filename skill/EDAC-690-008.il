;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Connector/USB
;Desc:USB type A
;Vendor:EDAC Inc.
;Count:1
;CVG64:bitmap field, not implemented yet.
;Datasheet:

Yard=1.0 W=13.1 L=16.96 cc=0:-10.28+L/2 H=15.62
pName="EDAC-690-008" _PrepareNewSym(pName)

PadNs=_PadTH_Default(2.3+0.8 2.3)
PadN=_PadTH_Default(1.6 0.92)

_PinArray(PadNs 2 2 13.14 5.68 -13.14/2:0 t t t t t 0 0 0 1 "S")
for(row 1 2 for(col 1 4
	if(row==1 then sprintf(pnab "A%d" col) y=5.33 else sprintf(pnab "B%d" col) y=2.71)
	case(col (1 x=-3.5)(2 x=-1)(3 x=1)(4 x=3.5))
	_CreatePin(PadN x:y pnab)))

;silkscreen & assembly
for(i 1 2 if(i==1 _Layer(lPkgGeoSilkT) _Layer(lPkgGeoAsmT))
	_Rectangle(W L 0:-10.28+L/2)
	_Line(list(0:-10.28+5 0:-10.28))
)

;bound
_Layer(lPkgGeoPlaceT) _BoundHeight(_ShapeRectangle(W+Yard*2 L+Yard 0:cadr(cc)+Yard/2) H)
_Layer(lPkgGeoDfaT)   _BoundHeight(_ShapeRectangle(W L cc) H "USB-A")

;ref & val
_CreateRefValue(pName 0:L-10.28+SilkWidth+tSilkHeight/2 0:1)
_CrossCenter();pick-place marker(0:0)
_SaveDesign(pName)
