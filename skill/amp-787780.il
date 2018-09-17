;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Connector/USB
;Desc:USB type B
;Vendor:AMP
;Count:1
;CVG64:bitmap field, not implemented yet.
;Datasheet:

Yard=1.0 W=12.04 L=15.7 cc=0:-10.28+L/2 H=11.5
pName="AMP-787780" _PrepareNewSym(pName)

PadNs=_PadTH_Default(2.3+0.8 2.3)

PadN=_PadTH_Default(1.6 0.92)
;_PinArray(PadN Col Row PitchX PitchY Pos1 bRight bUp bRowFirst bPin1 bPinNum Pin1Offset PinAngle PinTAngle Prefix)
_PinArray(PadNs 2 1 W 0 -W/2:0 t t t t t 0 0 0 1 "S")
_PinArray(PadN 2 1 2.5 0 2.5/2:4.71 nil)
_PinArray(PadN 2 1 2.5 0 -2.5/2:2.71 t t t t t 2)

;silkscreen & assembly
for(i 1 2 if(i==1 _Layer(lPkgGeoSilkT) _Layer(lPkgGeoAsmT))
	_Rectangle(W L 0:-10.28+L/2)
	_Line(list(0:-10.28+5 0:-10.28))
)

;bound
_Layer(lPkgGeoPlaceT) _BoundHeight(_ShapeRectangle(W+Yard*2 L+Yard 0:cadr(cc)+Yard/2) H)
_Layer(lPkgGeoDfaT)   _BoundHeight(_ShapeRectangle(W L cc) H "USB-B")

;ref & val
_CreateRefValue(pName 0:L-10.28+SilkWidth+tSilkHeight/2 0:1)
_CrossCenter();pick-place marker(0:0)
_SaveDesign(pName)
