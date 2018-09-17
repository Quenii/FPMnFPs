;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Antenna/PCB
;Desc:
;Vendor:
;Count:1
;CVG64:bitmap field, not implemented yet.
;Datasheet:

	pName="PCB-ANTENNA-1"
	pCR=2.0*2 ;		("0603" pCR=2.*2)		("0402" pCR=1.4*2)
	pA1=35.0
	pA2=20.0
	pThickness=1.0
	pD=22.5
	pR=2.0
	pFeedGap=1.0
	pS=3.0

	_PrepareNewSym(pName)
 _Layer(lEtchT)
	
;big
	shapeid=_ShapeRectangle(pA1+pThickness pA2+pThickness 0:pA2/2 pR)

	o_poly = _PolyCreate(shapeid)
	i_poly=axlPolyExpand(o_poly -pThickness 'NONE)
		
	shapeid=_ShapeRectangle(pCR pThickness*2 0:pA2)
	i_poly = append(i_poly _PolyCreate(shapeid))
	poly = axlPolyOperation(o_poly i_poly 'ANDNOT)

;small
	shapeid=_ShapeRectangle( pD+pThickness pS+pThickness 0:-pS/2 0.3)
	so_poly = _PolyCreate(shapeid)
	si_poly=axlPolyExpand(so_poly -pThickness 'NONE)
	shapeid=_ShapeRectangle(pFeedGap pS*2+pThickness*2)
	si_poly = append(si_poly _PolyCreate(shapeid))
	s_poly = axlPolyOperation(so_poly si_poly 'ANDNOT)

	poly = axlPolyOperation(poly s_poly 'OR)
	poly=axlPolyOffset(poly 0:pS)
	foreach(onepoly poly axlDBCreateShape(onepoly t))

;pin
	PadN=_PadSM(pThickness pThickness t)	
	_CreatePin(PadN -(pFeedGap+pThickness)/2:0 "1")
	_CreatePin(PadN (pFeedGap+pThickness)/2:0 "2")
	_CreatePin(PadN -pCR/2-pThickness/2:pA2+pS "3")
	_CreatePin(PadN pCR/2+pThickness/2:pA2+pS "4")
;ref & val
	_CreateRefValue(pName)

	_SaveDesign(pName)
	_MakeDevice(pName 2)
