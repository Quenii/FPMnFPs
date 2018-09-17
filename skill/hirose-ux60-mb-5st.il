;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Connector/USB
;Desc:mini-USB
;Vendor:Hirose
;Count:2
;CVG64:bitmap field, not implemented yet.
;Datasheet:

Courtyard=1.0 Pitch=0.8

for(pos 0 1 if(pos==0 sprintf(pName,"HIROSE-US60A-MB-5ST") sprintf(pName,"HIROSE-US60-MB-5ST"))
_PrepareNewSym(pName)

;_PadTH_NP(0 pHole pPadTop pPadInner pPadBot pThermal pSolderMask pAssembly pAnti pKeepout)
if(pos==1 then PadNnp=_PadTH_NP('(0 0.9 0.2 0.2 0.2 1.5 0.9 0.9 1.5 1.5))
_CreatePinMechanical(PadNnp 3.5/2:6.4)
_CreatePinMechanical(PadNnp -3.5/2:6.4))

;_PinArray(PadN Col Row PitchX/Y (P1=0:0 bRight bUp bRowFirst bPin1 bPinNum P1Offset=0 PAngle=0 TAngle=0)
PadN=_PadSMFillet(0.5 2.0) _PinArray(PadN 5 1 Pitch Pitch -1.6:6.4+3.25-1.0)
PadNtab=_PadSMFillet(2.5 2.2) _PinArray(PadNtab 2 2 8.4 8.4-3.1 -8.4/2:3.1 t t t t t 5)

;route keepout
	_Layer(lRouteKoT)
	p1=_PolyCreate(_ShapeRectangle(7.7 6.0 0:6.0/2)) 
	p2=_PolyCreate(_ShapeRectangle(3.5 1.65 0:6.0+1.65/2)) 
	polys=axlPolyOperation(p1 p2 'OR)
	foreach(poly polys axlDBCreateShape(poly t))

;silkscreen & assembly
	for(i 1 2 if(i==1	_Layer(lPkgGeoSilkT) _Layer(lPkgGeoAsmT))
		for(j 0 4 _Line(list(Pitch*j-Pitch*2:9 Pitch*j-Pitch*2:9-1.2) 0.3))
		_Line(list(0:0 0:1))

		s1=_ShapeRectangle(7.7 9.0 0:9.0/2) 		s2=_ShapeRectangle(9.9 1.2 0:8.4)
		s3=_ShapeRectangle(9.9 1.2 0:6.4-3.3) 	s4=_ShapeRectangle(6*Pitch 1.2*2 0:9 0.4)
		p1=_PolyCreate(s1) p2=_PolyCreate(s2) p3=_PolyCreate(s3) p4=_PolyCreate(s4)

		polys=_PolyOp(list(p1 p2 p3) 'OR)
		polyBound=axlPolyExpand(polys Courtyard 'NONE)
		polysF=axlPolyOperation(polys p4 'ANDNOT)

		cur=list(-9.9/2:8.4 9.9/2:8.4 -9.9/2:6.4-3.3 9.9/2:6.4-3.3)
		foreach(pc cur p5=_PolyCreate(_ShapeCircle(0.2 nil pc)) 
			polysF=axlPolyOperation(polysF p5 'ANDNOT))
		foreach(poly polysF _CreateObjPath(axlDBCreateShape(poly t)))
	)
;bound
	_Layer(lPkgGeoPlaceT) p5=_PolyCreate(_ShapeRectangle(20 Courtyard 0:-Courtyard/2))
	foreach(poly axlPolyOperation(polyBound p5 'ANDNOT) _BoundHeight(axlDBCreateShape(poly t) 3.95))
	_Layer(lPkgGeoDfaT) _BoundHeight(axlDBCreateShape(car(polys) t) 3.95 "MINI-USB")

;ref & val
	_CreateRefValue(pName 0:6.4+3.25+SilkGap+SilkWidth/2+tSilkHeight/2 0:4.5);default(0:0)
	_CrossCenter() ;pick-place marker(0:0)
	_SaveDesign(pName)
)
