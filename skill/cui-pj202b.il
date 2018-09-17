;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Connector/Power Jack
;Desc:2.5mm Power Jack
;Vendor:CUI Inc.
;Count:1
;CVG64:bitmap field, not implemented yet.
;Datasheet:

	Px=2.77 Py=2.84 pH=12.55
	PadNs=_PadTH_Default(5.0 3.3)

	sprintf(pName,"CUI-PJ202B")
	_PrepareNewSym(pName)

	_CreatePin(PadNs -10.7:4.7 "3")
	_CreatePin(PadNs -10.7+3:0 "2")
	_CreatePin(PadNs -10.7-3:0 "1")
	
	X=14.4 Y=9.0
	;bound
	_Layer(lPkgGeoPlaceT) _BoundHeight(_ShapeRectangle(X-3.2+1 Y+0.5 -(X+3.2+1)/2:0) pH)
	_Layer(lPkgGeoDfaT) _BoundHeight(_ShapeRectangle(X Y -X/2:0) pH)

	;silkscreen & assembly
	for(i 1 2 if(i==1 _Layer(lPkgGeoSilkT) _Layer(lPkgGeoAsmT))
		_Rectangle(X Y -X/2:0)
		_Line(list(-3.2:Y/2 -3.2:-Y/2))
		_Line(list(0:0 -3.2:0))
		_Line(list(-10.7+1.6:4.7 -10.7-1.6:4.7))
	)

	;ref & val
	_CreateRefValue(pName 0:-Y/2-tSilkHeight/2-SilkWidth 0:-Y/2-tSilkHeight/2-SilkWidth)

	_SaveDesign(pName)
