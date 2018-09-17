;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Connector/Header
;Desc:
;Vendor:
;Count:1
;CVG64:bitmap field, not implemented yet.
;Datasheet:

Courtyard=1.0 Pitch=0.8

sprintf(pName,"MOLEX-54819")
_PrepareNewSym(pName)

;_PinArray(PadN Col Row PitchX/Y (P1=0:0 bRight bUp bRowFirst bPin1 bPinNum P1Offset=0 PAngle=0 TAngle=0)
PadNs=_PadSMFillet(0.5 2.25) 		
PadNtab1=_PadSMFillet(2.05 3.5) 
PadNtab2=_PadSMFillet(2.05 4.0) 
_PinArray(PadNs 5 1 Pitch 0 -1.6:2+4.25)
_PinArray(PadNtab1 2 1 7.8+2.05 0 -(7.8+2.05)/2:2+4.25 t t t t t 5)
_PinArray(PadNtab2 2 1 7.8+2.05 0 -(7.8+2.05)/2:2.0 t t t t t 7)

;route keepout
	_Layer(lRouteKoT) _ShapeRectangle(6.2 1.2 0:0.6)

;silkscreen & assembly
	for(i 1 2 if(i==1	_Layer(lPkgGeoSilkT) _Layer(lPkgGeoAsmT))
		for(j 0 4 _Line(list(Pitch*j-Pitch*2:9-2 Pitch*j-Pitch*2:9-2-1.2) 0.3))
		_Line(list(0:0 0:-2))

		s1=_ShapeRectangle(7.7 9.0 0:9.0/2-2) 		
		s2=_ShapeRectangle(9.9 1.5 0:6.25)
		s3=_ShapeRectangle(9.9 2.0 0:2.0) 	s4=_ShapeRectangle(6*Pitch 1.2*2 0:9-2 0.4)
		p1=_PolyCreate(s1) p2=_PolyCreate(s2) p3=_PolyCreate(s3) p4=_PolyCreate(s4)

		polys=_PolyOp(list(p1 p2 p3) 'OR)
		polyBound=axlPolyExpand(polys Courtyard 'NONE)
		polysF=axlPolyOperation(polys p4 'ANDNOT)

		cur=list(-9.9/2:6.25 9.9/2:6.25 -9.9/2:2 9.9/2:2)
		foreach(pc cur p5=_PolyCreate(_ShapeCircle(0.2 nil pc)) 
			polysF=axlPolyOperation(polysF p5 'ANDNOT))
		foreach(poly polysF _CreateObjPath(axlDBCreateShape(poly t)))
	)
;bound
	_Layer(lPkgGeoPlaceT) p5=_PolyCreate(_ShapeRectangle(20 Courtyard+2 0:-Courtyard/2-1))
	foreach(poly axlPolyOperation(polyBound p5 'ANDNOT) _BoundHeight(axlDBCreateShape(poly t) 3.95))
	_Layer(lPkgGeoDfaT) _BoundHeight(axlDBCreateShape(car(polys) t) 3.95 "MINI-USB")

;ref & val
	_CreateRefValue(pName 0:7-1.5/2+2.25/2+SilkGap+SilkWidth/2+tSilkHeight/2 0:4.5);default(0:0)
	_CrossCenter() ;pick-place marker(0:0)
	_SaveDesign(pName)
