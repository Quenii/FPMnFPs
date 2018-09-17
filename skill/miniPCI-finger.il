;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Connector/PCI
;Desc:miniPCI finger
;Vendor:Richard L.
;Count:2
;CVG64:bitmap field, not implemented yet.
;Datasheet:http://www.pcisig.com

Courtyard=1.0 Pitch=0.8 W1=30 W2=24.2 C1=3.85 BoundOffset=0.2

for(pcs 1 2 pName="MINI-PCI-FINGER"
	if(pcs==1 then H1a=50.95 H1b=48.05 pName=strcat("FULL-" pName)
	else H1a=26.80 H1b=23.90 pName=strcat("HALF-" pName))

_PrepareNewSym(pName)

;_PadTH_NP(0 pHole pPadTop pPadInner pPadBot pThermal pSolderMask pAssembly pAnti pKeepout)
PadNpName=_PadTH_NP('(0 2.6 0.2 0.2 0.2 2.9 2.9 2.9 2.9 2.9))
_PinArray(PadNpName 2 1 W2 0 -12.1:H1b t t t t nil)

;_PinArray(PadN Col Row PitchX/Y (P1=0:0 bRight bUp bRowFirst bPin1 bPinNum P1Offset=0 PAngle=0 TAngle=0 delta=1)
PadNt=_PadSM(0.6 2.3 t nil 0 nil t) ;_PadSM(x y bRect bRound maskoversize bBottom bNoPaste)
	_PinArray(PadNt 8 1 Pitch 0 -4-7*Pitch+1.65-C1:0.25+2.3/2 t t t t t 0 0 0 2)
	_PinArray(PadNt 26-8 1 Pitch 0 -C1+1.65:0.25+2.3/2 t t t t t 16 0 0 2)
PadNb=_PadSM(0.6 2.3 t nil 0 t t) 
	_PinArray(PadNb 8 1 Pitch 0 -4-7*Pitch+2.05-C1:0.25+2.3/2 t t t t t 1 0 0 2)
	_PinArray(PadNb 26-8 1 Pitch 0 -C1+2.05:0.25+2.3/2 t t t t t 17 0 0 2)

_Layer(lPkgGeoPlaceT)
	p0=_PolyCreate(_ShapeRectangle(W1 H1a 0:H1a/2))
	foreach(pc list(-W1/2:0 W1/2:0) 
		p1=_PolyCreate(_ShapeRectangle(W1-25.7 3.2*2 pc 0.8)) 
		p0=axlPolyOperation(p0 p1 'ANDNOT))
	polyNoSlot=p0
	p1=_PolyCreate(_ShapeRectangle(1.5 8 -C1:0 1.5/2))
	p0=axlPolyOperation(p0 p1 'ANDNOT)

	p1=_PolyCreate(_ShapeRectangle(W1 H1a-3.2-BoundOffset 0:(H1a+3.2+BoundOffset)/2))
	polyBoundT=axlPolyOperation(polyNoSlot p1 'ANDNOT)
	polyBoundT=axlPolyExpand(polyBoundT -BoundOffset 'NONE)
	polyBoundT=axlPolyOperation(polyBoundT _PolyCreate(_ShapeCircle(1.5/2+BoundOffset nil -C1:4-1.5/2)) 'OR)

	polyBoundB=axlPolyExpand(polyNoSlot -BoundOffset 'NONE)
	p1=_PolyCreate(_ShapeRectangle(W1 H1a-5.1 0:(H1a+5.1)/2))
	polyBoundB=axlPolyOperation(polyBoundB p1 'ANDNOT)

;bound
	for(i 1 4
	if(i<3 then if(i==1 _Layer(lPkgGeoPlaceT) _Layer(lPkgGeoDfaT))
		foreach(poly polyBoundT _BoundHeight(axlDBCreateShape(poly t) 2.4))
		else if(i==3 _Layer(lPkgGeoPlaceB) _Layer(lPkgGeoDfaB))
		foreach(poly polyBoundB _BoundHeight(axlDBCreateShape(poly t) 1.35))
	)
 	_ShapeRectangle(5.8 5.8 -W2/2:H1b)      
 	_ShapeRectangle(5.8 5.8 W2/2:H1b)
 	)

;for cut-mark (router)
	_Layer(lBrdGeoOutline)
	foreach(poly p0 axlDBCreateShape(poly nil))

;route keepout
	_Layer(lRouteKoA)
 	_ShapeRectangle(5.8 5.8 -W2/2:H1b)      
 	_ShapeRectangle(5.8 5.8 W2/2:H1b)

;soldermask
	for(i 1 2 if(i==1 _Layer(lPkgGeoSmT) _Layer(lPkgGeoSmB))
 	_ShapeRectangle(W1 2.55+solder_mask_offset 0:(2.55+solder_mask_offset)/2))

;silkscreen & assembly
	_Layer(lPkgGeoAsmT)
	_Line(list(-C1:0 -C1:4-1.5/2) 0)
	foreach(poly p0 _CreateObjPath(axlDBCreateShape(poly t)))
	_Layer(lPkgGeoSilkT)
	_CornerRectangle(W1 H1a 0:H1a/2 1 SilkWidth)

;ref & val
	_CreateRefValue(pName 0:H1a+SilkWidth+tSilkHeight/2 0:H1a+SilkWidth+tSymHeight/2)
	_CrossCenter(-C1:0 1.0)
	_SaveDesign(pName)
)