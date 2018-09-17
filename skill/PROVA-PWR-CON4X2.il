;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Connector/Header
;Desc:
;Vendor:Prova Inc.
;Count:1
;CVG64:bitmap field, not implemented yet.
;Datasheet:

	pH=12.3
	sprintf(pName,"PROVA-PWR-CON4X2")
	_PrepareNewSym(pName)
	w=5.5 L=10.52

;pin
	tPadN=_PadTH_Default(1.2 0.838)

	x0=0 y0=0
	_CreatePin(tPadN x0:y0 "1")
	_CreatePin(tPadN x0+2.5:y0 "2")
	_CreatePin(tPadN x0:y0-2 "3")
	_CreatePin(tPadN x0+1.5:y0-2 "4")
	y0=y0-4
	_CreatePin(tPadN x0:y0 "5")
	_CreatePin(tPadN x0+2.5:y0 "6")
	_CreatePin(tPadN x0:y0-2 "7")
	_CreatePin(tPadN x0+1.5:y0-2 "8")
		
;bound
	_Layer(lPkgGeoPlaceT)
	_BoundHeight(_ShapeRectangle(w L x0-1.14+w/2:y0+1) pH)
	_Layer(lPkgGeoDfaT)   
	_BoundHeight(_ShapeRectangle(w L x0-1.14+w/2:y0+1) pH 0 "PROVA-PWR-CON4X2")

;silkscreen & assembly
	for(i 1 2
		if(i==1	_Layer(lPkgGeoSilkT) _Layer(lPkgGeoAsmT))
		_Rectangle(w L x0-1.14+w/2:y0+1 0)
		_Triangle(x0-1.14:y0+4 1 0)
		_Line(list(x0-1.14:y0-2-2.59 x0-1.14+5.5:y0-2-2.59))
		for(m 0 5 _Line(list(x0-1.14+m*1+0.2:y0-2-2.59 x0-1.14+m*1+0.2:y0-2-2.59-1)))

		_Line(list(x0-1.14:y0+4+2.59 x0-1.14+5.5:y0+4+2.59))
		for(m 0 5 _Line(list(x0-1.14+m*1+0.2:y0+4+2.59 x0-1.14+m*1+0.2:y0+4+2.59+1)))
	)

;ref & val
_CreateRefValue(pName x0-4:2 x0-4:2)

_SaveDesign(pName)
