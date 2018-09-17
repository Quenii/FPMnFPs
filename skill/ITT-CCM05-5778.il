;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Connector/SD
;Desc:MMC/SD card connector
;Vendor:ITT
;Count:1
;CVG64:bitmap field, not implemented yet.
;Datasheet:http://dkc3.digikey.com/Media/PDF/Data%20Sheets/ITT%20Industries%20Cannon%20PDFs/CCM05%20SD,MMC,miniSD%20oct04.pdf

	Courtyard=1.0

	sprintf(pName,"ITT-CCM05-5778")
	_PrepareNewSym(pName)

	PadNs=_PadSMFillet(1.0 2.5)
	PadNg=_PadSMFillet(2.05 2.5)

;	_PinArray(PadN Col Row PitchX PitchY Pos1 bRight bUp bRowFirst bPin1 bPinNum Pin1Offset PinAngle PinTAngle Prefix)
	py=19.5-6.4+6.8+2.5/2.0
	_PinArray(PadNs 6 1 2.5 0 4.925-5*2.5:py)
	px=4.925-6*2.5	_CreatePin(PadNs px:py "9")
	px=px-1.7 _CreatePin(PadNs px:py "12")
	px=px-1.5 _CreatePin(PadNs px:py "13")
	px=4.925+2.425	_CreatePin(PadNs px:py "7")
	px=px+1.7 _CreatePin(PadNs px:py "8")
	px=px+1.8 _CreatePin(PadNs px:py "10")
	px=px+1.5 _CreatePin(PadNs px:py "11")

	px=(32.5-2.05)/2 py=13.1-8.35
	_CreatePin(PadNg px:py "S1") _CreatePin(PadNg -px:py "S2")

;_PadTH_NP(0 pHole pPadTop pPadInner pPadBot pThermal pSolderMask pAssembly pAnti pKeepout)
	mtgPadN=_PadTH_NP('(0 1.65 0.5 0.5 0.5 2.0 1.65 1.65 2.0 2.0))
	_CreatePinMechanical(mtgPadN -25.3/2:13.1)
	_CreatePinMechanical(mtgPadN  25.3/2:13.1)
	
;route keepout
	_Layer(lRouteKoT)
	px=1.75 py=13.5-7.5
	_ShapeRectangle(px py -27.8/2-px/2:19.6-7.5-py/2 0.1)

	s1=_ShapeRectangle(28.3 19.5 0:19.5/2) 	
	s11=_ShapeRectangle(28.3 19.5+2.2 0:(19.5+2.2)/2) 	
	lw=(30.9-28.3)/2 py=19.5-14.75
	s2=_ShapeRectangle(lw 1.5 28.3/2+lw/2:py)
	s3=_ShapeRectangle(lw 1.5 -(28.3/2+lw/2):py)
	s4=_ShapeRectangle(24 16+14 -0.7:(14-16)/2 0.5)
	p11=_PolyCreate(s11) 
	p1=_PolyCreate(s1) p2=_PolyCreate(s2) p3=_PolyCreate(s3) p4=_PolyCreate(s4)
	p5=_PolyCreate(_ShapeCircle(28/2 nil -0.7:-8)) 

	polys=_PolyOp(list(p1 p2 p3) 'OR)
	polyBound=_PolyOp(list(polys p11 p4) 'OR)
	polysF=axlPolyOperation(polys p5 'ANDNOT))

	cur=list(-30.9/2:py 30.9/2:py)
	foreach(pc cur p5=_PolyCreate(_ShapeCircle(0.2 nil pc)) 
		polysF=axlPolyOperation(polysF p5 'ANDNOT))

;silkscreen & assembly
	for(i 1 2 if(i==1	_Layer(lPkgGeoSilkT) _Layer(lPkgGeoAsmT))
		_Cross(-0.7:0 2.0)
		_Line(list(0:19.5 0:17.5)) _Line(list(0:0 0:2))
		_Rectangle(24 16+14 -0.7:(14-16)/2 0.5)
		foreach(poly polysF _CreateObjPath(axlDBCreateShape(poly t)))
	)

;bound
	_Layer(lPkgGeoDfaT)
	foreach(poly polyBound _BoundHeight(axlDBCreateShape(poly t) 3.1))
	_Layer(lPkgGeoPlaceT) 
	polyBound=axlPolyExpand(polyBound Courtyard 'NONE)
	foreach(poly polyBound _BoundHeight(axlDBCreateShape(poly t) 3.1))

;ref & val
	_CreateRefValue(pName 0:10 0:10)
	_SaveDesign(pName)
