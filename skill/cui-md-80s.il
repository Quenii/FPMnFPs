;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Connector/mini-DIN
;Desc:mini-DIN, 8 pin, no shield
;Vendor:CUI Inc.
;Count:1
;CVG64:bitmap field, not implemented yet.
;Datasheet:

	pH=12.8
	PadNs=_PadTH_Default(1.5 0.9)
	mtgPadN=_PadTH_Default(3.65 2.2)

	sprintf(pName,"CUI-MD-80S")
	_PrepareNewSym(pName)

	Ps=list(-1.3:-8.5 1.3:-8.5 -3.4:-8.5 -1.3:-11.0 3.4:-8.5 -3.4:-11.0 0.9:-11.0 3.4:-11.0)

	for(pc 1 8 P=nth(pc-1 Ps) sprintf(Pn "%d" pc) _CreatePin(PadNs P Pn))
	_CreatePin(mtgPadN 0:-4.7 "S1")
	
	;bound
	_Layer(lPkgGeoPlaceT) _BoundHeight(_ShapeRectangle(14+0.5 12.4-1.8+0.5 0:-(12.4+1.8+0.5)/2) pH)
	_Layer(lPkgGeoDfaT) _BoundHeight(_ShapeRectangle(14 12.4 0:-12.4/2) pH)

	;silkscreen & assembly
	for(i 1 2 if(i==1 _Layer(lPkgGeoSilkT) _Layer(lPkgGeoAsmT))
		_Rectangle(14 12.4 0:-12.4/2)
		_Line(list(-14/2:-1.8 14/2:-1.8))
		_Line(list(0:0 0:-1.8))
	)

	;ref & val
	_CreateRefValue(pName 0:tSilkHeight/2+SilkWidth 0:tSilkHeight/2+SilkWidth)

	_SaveDesign(pName)
