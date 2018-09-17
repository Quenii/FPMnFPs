;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Connector/miniSD
;Desc:mini-SD card connector
;Vendor:ITT
;Count:1
;CVG64:bitmap field, not implemented yet.
;Datasheet:http://dkc3.digikey.com/Media/PDF/Data%20Sheets/ITT%20Industries%20Cannon%20PDFs/CCM05%20SD,MMC,miniSD%20oct04.pdf

	Courtyard=1.0

	sprintf(pName,"ITT-CCM05-5773")
	_PrepareNewSym(pName)

	PadNs=_PadSMFillet(0.7 1.25)
	PadNg=_PadSMFillet(1.1 2.1)
	PadNc=_PadSMFillet(1.1 0.8)

;	_PinArray(PadN Col Row PitchX PitchY Pos1 bRight bUp bRowFirst bPin1 bPinNum Pin1Offset PinAngle PinTAngle Prefix)
	px=-6.5+0.55 py=1.5-0.25-1.25/2
	Ps=list(8 7 6 5 4 11 10 3 2 1 9)
	for(pc 0 10 P=nth(pc Ps) sprintf(Pn "%d" P) _CreatePin(PadNs px+1.3*pc:py Pn))
	px=10.95+1.1/2 py=13-2.75
	_CreatePin(PadNg px:py "G1")
	_CreatePin(PadNg px-22.7+1.1:py "G2")
	_CreatePin(PadNc 10.95-0.5+1.1/2:13-6.25 "CD")

;_PadTH_NP(0 pHole pPadTop pPadInner pPadBot pThermal pSolderMask pAssembly pAnti pKeepout)
	mtgPadN=_PadTH_NP('(0 1.2 0.5 0.5 0.5 1.6 1.6 1.6 1.6 1.6))
	_CreatePinMechanical(mtgPadN 21.9/2-1.95:13-2)
	_CreatePinMechanical(mtgPadN 21.9/2-1.95-16.5:13-2)
	
;route keepout
	_Layer(lRouteKoT)
	for(pc 0 10 _ShapeRectangle(0.95 2 -6.05+0.55-0.95/2+pc*1.3:13-4.3))

_Layer(lPkgGeoSilkT)
	x=-21.9/2 y=0
	path=axlPathStart(list(x:y))
	x=x+21.9 path=axlPathLine(path 0 x:y)
	y=13 path=axlPathLine(path 0 x:y)
	x=x-20.5 path=axlPathLine(path 0 x:y)
	y=y-6.6 path=axlPathLine(path 0 x:y)
	x=x-1.4 y=y-2 path=axlPathLine(path 0 x:y)
	path=axlPathLine(path 0 x:0)

	s2=axlDBCreateShape(path t)
	polys=_PolyCreate(s2)

;	s1=_Rectangle(20 21.5 0.55:0 0.5)	
;	s2=_Rectangle(2 8 0.55-10+1:21.5/2-4 0.5) 	
;	p1=_PolyCreate(s1) p2=_PolyCreate(s2)
;	p3=axlPolyOperation(p1 p2 'ANDNOT))

	w=0.8 cur=list(10.95+w/2 10.95+w/2-20.5-w)
	foreach(pc cur p5=_PolyCreate(_ShapeRectangle(w 1.8 pc:13-2.75)) 
		polys=axlPolyOperation(polys p5 'OR))

	s1=_ShapeRectangle(21.9-3.75-2.65 4 0.55:0 0.8)
	p1=_PolyCreate(s1)

	polys=_PolyOp(list(p1 polys) 'ANDNOT)

;silkscreen & assembly
	for(i 1 2 if(i==1 _Layer(lPkgGeoSilkT) _Layer(lPkgGeoAsmT))
		_Cross(0.55:0 2)
		_Rectangle(20 21.5 0.55:0 0.5)

		foreach(poly polys _CreateObjPath(axlDBCreateShape(poly t)))
;		foreach(poly p3 _CreateObjPath(axlDBCreateShape(poly t)))
	)

;bound
	_Layer(lPkgGeoDfaT)
;	foreach(poly polyBound _BoundHeight(axlDBCreateShape(poly t) 3.1))
	_Layer(lPkgGeoPlaceT) 
;	polyBound=axlPolyExpand(polyBound Courtyard 'NONE)
;	foreach(poly polyBound _BoundHeight(axlDBCreateShape(poly t) 3.1))

;ref & val
	_CreateRefValue(pName 0:5 0:5)
	_SaveDesign(pName)
