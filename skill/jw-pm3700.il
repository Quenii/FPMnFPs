;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Inductor/choke
;Desc:2mH SMD choke
;Vendor:JW Miller Magnetics
;Count:1
;CVG64:bitmap field, not implemented yet.
;Datasheet:

	pName="JW-PM3700"
	Courtyard=1
	Dia=17.78
	Pad=3.18
	pd=21.6 
	_PrepareNewSym(pName)
;pin
	PadN=_PadSM(Pad Pad t)	
	_CreatePin(PadN -pd/2+Pad/2:0 "4")
	_CreatePin(PadN pd/2-Pad/2:0 "2")
	_CreatePin(PadN 0:-pd/2+Pad/2 "1")
	_CreatePin(PadN 0:pd/2-Pad/2 "3")

;bound
 _BoundHeight(_ShapeCircle(Dia/2+Courtyard lPkgGeoPlaceT) 11.43)

	for(asm 0 1 if(asm==1 _Layer(lPkgGeoAsmT) _Layer(lPkgGeoSilkT))
		_Circle(Dia/2)
		;polarity mark
		_Triangle(0:-pd/2-SilkGap-SilkWidth/2 1 90)
	)

	_CrossCenter()
	_CreateRefValue(pName)

	_SaveDesign(pName)
	_MakeDevice(pName 2)
