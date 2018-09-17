;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Jumper/TestPoint
;Desc:test point with 2 pad closed.
;Vendor:Richard L.
;Count:1
;CVG64:bitmap field, not implemented yet.
;Datasheet:

	pName  ="FLYER-S"
	_PrepareNewSym(pName)
;....................PadShapeFlyer (x y)
	x=1.2 y=1.0 z=0.2
	solder_masksize=((x+solder_mask_offset):(y+solder_mask_offset))
	sprintf(PadN "FLYERX%.fY%.f" x*100 y*100)
	PadN=_StrNoDot(PadN)

;	sN=ShapeFileMELF(x y cX cY)
	sprintf(sfN "flyerx%.fy%.f" x*100 y*100)
	_FlushShape()

	_Layer(lEtchT)
	so=_ShapeRectangle(x y 0:0 y/2.0) 
	po=_PolyCreate(so)
	pi1=_PolyCreate(_ShapeRectangle(z (y-z)/2.0 0:y/2.0-z))
	pi2=_PolyCreate(_ShapeRectangle(z (y-z)/2.0 0:-(y/2.0-z)))
;	poly=axlPolyOperation(po pi1 'ANDNOT)
;	poly=axlPolyOperation(poly pi2 'ANDNOT)
	po=_PolyOp(list(pi1 po) 'ANDNOT)
	polys=_PolyOp(list(pi2 po) 'ANDNOT)
	axlDBCreateShape(car(polys) t)

	_SaveDesignShape(sfN) 
	sN=sfN

	shapeNameM=_ShapeFileRectangle(x y y/2.0)

	PadLst = list(
  	make_axlPadStackPad(?layer lPadT ?type 'REGULAR,?figure sN,?figureSize x:y)
  	make_axlPadStackPad(?layer lPadST ?type 'REGULAR,?figure shapeNameM,?figureSize solder_masksize)
		make_axlPadStackPad(?layer lPadPT ?type 'REGULAR,?figure sN,?figureSize x:y)
	)
	ps_id = axlDBCreatePadStack(PadN,nil,PadLst t)
	axlPadstackToDisk(PadN)
;	PadN
;);func
;....................PadShapeFlyer (x y)
	_CreatePin(PadN 0:0 "1")

;bound
	_Layer(lPkgGeoPlaceT) _BoundHeight(_ShapeRectangle(x y 0:0 y/2.0))
	_Layer(lPkgGeoDfaT) _BoundHeight(_ShapeRectangle(x y 0:0 y/2.0) 1.0 "FLYER")

;silkscreen
;	for(asm 0 1 if(asm==1 _Layer(lPkgGeoAsmT) _Layer(lPkgGeoSilkT));silkscreen ;assembly
;		_Rectangle(pAvg pB)
;		_Dot(-pAvg/2+SilkWidth+0.25:pB/2-0.25-SilkWidth 0.5)))

	_CreateRefValue(pName)

	_SaveDesign(pName)

