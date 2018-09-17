;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Connector/SD
;Desc:microSD card slot
;Vendor:3M
;Count:1
;CVG64:bitmap field, not implemented yet.
;Datasheet:http://dkc3.digikey.com/Media/PDF/Data%20Sheets/ITT%20Industries%20Cannon%20PDFs/CCM05%20SD,MMC,miniSD%20oct04.pdf

	Courtyard=1.0 Pitch=1.1

	sprintf(pName,"3M-2908-05WB-MG")
	_PrepareNewSym(pName)

	PadNs=_PadSMFillet(0.8 1.5)
	PadNg=_PadSMFillet(1.4 1.9)
	PadNc=_PadSMFillet(1.8 1.4)

;	_PinArray(PadN Col Row PitchX PitchY Pos1 bRight bUp bRowFirst bPin1 bPinNum Pin1Offset PinAngle PinTAngle Prefix)
	Ps=list(0 -0.4 0 0.2 0 0.2 0 0)
	px=-1.24-7.7 py=12.6-1.15-1.5/2.0
	for(pc 0 7 P=nth(pc Ps) sprintf(Pn "%d" pc+1) _CreatePin(PadNs px+Pitch*pc:py+P Pn))
	_CreatePin(PadNg -12.9-1.4/2.0:13.6+1.9/2.0 "G1")
	_CreatePin(PadNg 0-1.4/2.0+0.25:12.6+1.9/2.0 "G2")
	_CreatePin(PadNc -1.15-1.8/2.0:1.1-0.7 "C1")
	_CreatePin(PadNc -6.85-1.8/2.0:1.1-0.7 "C2")

;route keepout
	_Layer(lRouteKoT)
	_ShapeRectangle(0.6 12.6+0.3 0:12.6/2-0.3/2.0))

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

	w=0.8 cur=list(10.95+w/2 10.95+w/2-20.5-w)
	foreach(pc cur p5=_PolyCreate(_ShapeRectangle(w 1.8 pc:13-2.75)) 
		polys=axlPolyOperation(polys p5 'OR))

	s1=_ShapeRectangle(21.9-3.75-2.65 4 0.55:0 0.8)
	p1=_PolyCreate(s1)

	polys=_PolyOp(list(p1 polys) 'ANDNOT)

;silkscreen & assembly
	for(i 1 2 if(i==1 _Layer(lPkgGeoSilkT) _Layer(lPkgGeoAsmT))
		_Rectangle(14-0.15 15.2 -(14-0.15)/2.0:15.2/2.0 0)
		CH=(5.4-1.6)*2
		cx=-5.74+0.14/2.0
		cy=15.2+1.6
		_Cross(cx:cy 2)
;		_Rectangle(11 15 cx:cy-15/2.0 0.5)

		cx=cx+11.0/2-9.7+0.5 cy=cy-15
		
		cx1=cx+1-0.5 cy1=cy+1.05 _Line(list(cx1:cy1 cx1:cy1+3.6) 0.9)
		cx1=cx1+1.1 _Line(list(cx1:cy1 cx1:cy1+3.6) 0.9)
		cx1=cx1+1.1 _Line(list(cx1:cy1 cx1:cy1+3.6) 0.9)
		cx1=cx1+1.1 _Line(list(cx1:cy1-0.3 cx1:cy1+3.6) 0.9)
		cx1=cx1+1.1 _Line(list(cx1:cy1 cx1:cy1+3.6) 0.9)
		cx1=cx1+1.1 _Line(list(cx1:cy1-0.3 cx1:cy1+3.6) 0.9)
		cx1=cx1+1.1 _Line(list(cx1:cy1 cx1:cy1+3.6) 0.9)
		cx1=cx1+1.1 _Line(list(cx1:cy1 cx1:cy1+3.6) 0.9)

		path=axlPathStart(list(cx:cy)) 
		cx=cx+9.7-1 path=axlPathLine(path SilkWidth cx:cy)
		cx=cx+0.5 cy=cy+0.5 path=axlPathLine(path SilkWidth cx:cy)
		cy=cy+14 path=axlPathLine(path SilkWidth cx:cy)
		cy=cy+0.5 cx=cx-0.5	path=axlPathLine(path SilkWidth cx:cy)
		cx=cx-10			path=axlPathLine(path SilkWidth cx:cy)
		cx=cx-0.5 cy=cy-0.5 path=axlPathLine(path SilkWidth cx:cy)
		cy=cy-(15-5.1-1.3-1.5-1.2-0.6-0.5) path=axlPathLine(path SilkWidth cx:cy)
		cx=cx+0.6 cy=cy-0.6 path=axlPathLine(path SilkWidth cx:cy)
		cy=cy-1.2 path=axlPathLine(path SilkWidth cx:cy)
		cx=cx-0.6 path=axlPathLine(path SilkWidth cx:cy)
		cy=cy-1.5 path=axlPathLine(path SilkWidth cx:cy)
		cx=cx+1.3 cy=cy-1.3 path=axlPathLine(path SilkWidth cx:cy)
		cy=cy-5.1+0.5 path=axlPathLine(path SilkWidth cx:cy)
		cx=cx+0.5 cy=cy-0.5 path=axlPathLine(path SilkWidth cx:cy)
		path=axlDBCreatePath(path)

;		foreach(poly polys _CreateObjPath(axlDBCreateShape(poly t)))
	)

;bound
	_Layer(lPkgGeoDfaT)	_BoundHeight(_ShapeRectangle(14-0.15 15.2 -(14-0.15)/2.0:15.2/2.0) 1.8 "MicroSD")
	_Layer(lPkgGeoPlaceT) _BoundHeight(_ShapeRectangle(14-0.15 15.2 -(14-0.15)/2.0:15.2/2.0)) 1.8)

;ref & val
	_CreateRefValue(pName -5:5 -5:5)
	_SaveDesign(pName)
