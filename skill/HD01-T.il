;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Diode/DiodeBridge
;Desc:DiodeBridge
;Vendor:
;Count:1
;CVG64:bitmap field, not implemented yet.
;Datasheet:

	Courtyard=0.2
	pName="HD01-T" pH=3.0
	dx=2.6 dy=6.1
	px=1.1 py=1.8

	_PrepareNewSym(pName)

;pin
	PadNs=_PadSMFillet(px py)
	_PinArray(PadNs 2 2 dx dy)
	
;bound
	_Layer(lPkgGeoPlaceT) _BoundHeight(_ShapeRectangle(5+Courtyard*2 7+Courtyard*2 dx/2:dy/2) pH)
	_Layer(lPkgGeoDfaT)   _BoundHeight(_ShapeRectangle(5 7 dx/2:dy/2) pH "DiodeBridge")

;silkscreen & assembly
	for(i 1 2
		if(i==1	_Layer(lPkgGeoSilkT) _Layer(lPkgGeoAsmT))
		if(i==1 _Rectangle(5.0 dy-py-SilkGap*2-SilkWidth dx/2:dy/2)
		_Rectangle(5.0 4.0 dx/2:dy/2))
		_Line(list(-0.4:1.6 -0.1:1.9 -0.1:1.9 0.2:1.6 0.5:1.9))
		_Line(list(2.2:1.6 2.5:1.9 2.5:1.9 2.8:1.6 3.1:1.9))
		_Line(list(-0.3:4.3 0.3:4.3))
		_Cross(dx:4.3 0.6)
	)

;ref & val
	_CreateRefValue(pName 6.0:dy/2 dx/2:dy/2)

	_SaveDesign(pName)

