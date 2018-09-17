;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Connector/Header
;Desc:
;Vendor:Pultronics Inc.
;Count:1
;CVG64:bitmap field, not implemented yet.
;Datasheet:

	pH=10
	sprintf(pName,"PUL-CON24A")
	_PrepareNewSym(pName)
	PadNs=_PadTH_Default(1.5 0.9)

	_PinArray(PadNs 12 1 2.54 0 0:0)
	_PinArray(PadNs 12 1 2.54 0 0:61 t t t t t 12)
	
	;bound
	_Layer(lPkgGeoPlaceT) 
		_BoundHeight(_ShapeRectangle(2.54*12+1 2.54+1 11*2.54/2:0) pH)
		_BoundHeight(_ShapeRectangle(2.54*12+1 2.54+1 11*2.54/2:61) pH)
	_Layer(lPkgGeoDfaT) 
		_BoundHeight(_ShapeRectangle(2.54*12 2.54 11*2.54/2:0) pH)
		_BoundHeight(_ShapeRectangle(2.54*12 2.54 11*2.54/2:61) pH)

	;silkscreen & assembly
	for(i 1 2 if(i==1 _Layer(lPkgGeoSilkT) _Layer(lPkgGeoAsmT))
		_Rectangle(2.54*12 2.54 11*2.54/2:0)
		_Rectangle(2.54*12 2.54 11*2.54/2:61)
		_Line(list(2.54/2:-2.54/2 2.54/2:2.54/2))
	)

	;ref & val
	_CreateRefValue(pName 11*2.54/2:61/2)

	_SaveDesign(pName)
