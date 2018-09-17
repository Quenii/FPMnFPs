;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Module/Module
;Desc:AT91SAM9260 kernel module,50pins, 50mm x 50mm board
;Vendor:Richard L.
;Count:1
;CVG64:bitmap field, not implemented yet.
;Datasheet:

Courtyard=1.0 Pitch=2.0 MP=46.2

sprintf(pName,"K9-CON50PEG")
_PrepareNewSym(pName)
MPx=50-4-5
PadNg=_PadTH_Default(1.5 0.7)
;_PadTH_NP(0 pHole pPadTop pPadInner pPadBot pThermal pSolderMask pAssembly pAnti pKeepout)
PadNnp=_PadTH_NP('(0 1.1 0.5 0.5 0.5 1.1 1.1 1.1 1.5 1.5))
PadN1=_PadSMFillet(2.75 1.0) 

;....................PadShapeFlyer (x y)
	for(cl 0 2
		y=(50-MP)/2.0-0.5
		case(cl (0 x=6.0) (1 x=5.0) (2 x=6.0+0.1 y=y+0.5))
		sprintf(PadN "K9-PEGX%.fY%.f" x*100 y*100) PadN=_StrNoDot(PadN)
		sprintf(sfN "K9-PEGx%.fy%.f" x*100 y*100) _FlushShape()
		_Layer(lEtchT)
		po1=_PolyCreate(_ShapeRectangle(x 10 0:5+y))
		if(cl<2 po2=_PolyCreate(_ShapeRectangle(2 y 0:y/2)))
		pi1=_PolyCreate(_ShapeCircle(x/2 nil 0:0))
		pi2=_PolyCreate(_ShapeRectangle(x y 0:y/2))
		po=_PolyOp(list(pi1 pi2) 'OR)
		polys=_PolyOp(list(po1 po) 'ANDNOT)
		if(cl<2 polys=_PolyOp(list(po2 polys) 'ANDNOT))
		axlDBCreateShape(car(polys) t)
		_SaveDesignShape(sfN) 
		case(cl (0 sTB=sfN) (1 sIn=sfN) (2 sM=sfN))
	)

	drill_data = make_axlPadStackDrill(?drillDiameter 3.0,?figure 'CIRCLE,?figureSize 3:3,?plating 'PLATED)
	PadLst = list(
	  	make_axlPadStackPad(?layer lPadT ?type nil,?figure sTB,?figureSize x:y)
	  	make_axlPadStackPad(?layer lPadI ?type nil,?figure sIn ?figureSize x:y)
	  	make_axlPadStackPad(?layer lPadB ?type nil ?figure sTB ?figureSize x:y)
	  	make_axlPadStackPad(?layer lPadST ?type nil,?figure sM,?figureSize x:y)
	  	make_axlPadStackPad(?layer lPadSB ?type nil ?figure sM ?figureSize x:y)
	)
	ps_id = axlDBCreatePadStack(PadN,drill_data,PadLst t)
	axlPadstackToDisk(PadN)
;	PadN
;);func
;....................PadShapeFlyer (x y)
	_CreatePin(PadN MPx:MP/2.0 "C1")
	_CreatePin(PadN MPx:-MP/2.0 "C2" 180)

_CreatePinMechanical(PadNnp 0:23)
_CreatePinMechanical(PadNnp 0:23-46) ;50pin
_CreatePinMechanical(PadNnp 0:23-40)	;44pin
_CreatePinMechanical(PadNnp 0:23-28) ;32pin

for(i 0 3 sprintf(pgName "G%d" i+1) _CreatePin(PadNg 50-4-2:1.5*2-2*i pgName))

;_PinArray(PadN Col Row PitchX/Y (P1=0:0 bRight bUp bRowFirst bPin1 bPinNum P1Offset=0 PAngle=0 TAngle=0)
_PinArray(PadN1 2 25 2.75+1.5 2.0 (2.75+1.5)/2:24*Pitch/2 nil nil)

;silkscreen & assembly
	for(i 1 4 
		case(i (1 _Layer(lPkgGeoSilkT)) (2 _Layer(lPkgGeoAsmT)) (3 _Layer(lPkgGeoSilkB)) (4 _Layer(lPkgGeoAsmB)))
		_CornerRectangle(50 50 50.0/2.0-4.0:0 2 SilkWidth)
		Gx=(2.75+1.5)/2+2.75/2+SilkGap+SilkWidth/2
		if(i<=2 then 
			_Triangle(Gx:24*Pitch/2 1 180 SilkWidth)
			_Line(list(Gx:25 Gx:-25)) 
			for(m 1 4 _Line(list(Gx:25-10*m/2*Pitch Gx-1:25-10*m/2*Pitch)))
			_Line(list(Gx:25-32/2*Pitch Gx-2:25-32/2*Pitch))
			_Line(list(Gx:25-44/2*Pitch Gx-2:25-44/2*Pitch))
			_Rectangle(2 8 50-4-2:0)
		)
		_Line(list(50-4:1.5 50-4:-1.5))
		_Line(list(50-4-2:0 50-4:0))
	)
;bound
	_Layer(lPkgGeoPlaceT) 
	_BoundHeight(_ShapeRectangle(6+Courtyard*2 50))
	_BoundHeight(_ShapeRectangle(2 8 50-4-2:0))

	_Layer(lPkgGeoDfaT) 
	_BoundHeight(_ShapeRectangle(6 50) 6 "K9-CON50")
	_BoundHeight(_ShapeRectangle(2 8 50-4-2:0) 6 "K9-CON50")

;ref & val
	_CreateRefValue(pName)
	_CrossCenter() ;pick-place marker(0:0)
	_SaveDesign(pName)
