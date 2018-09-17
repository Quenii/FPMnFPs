;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Transformer/Transform
;Desc:TAMURA's PF24 series transformer,Low profile
;Vendor:TAMURA
;Count:1
;CVG64:bitmap field, not implemented yet.
;Datasheet:

	pName="TAMURA-PF24"
	Courtyard=1
	Pad=3.0
;pin
	px=48.3 py1=15.3 py2=13.5
;body
	bX=73.0 bY=58.0

	_PrepareNewSym(pName)

	PadN1=_PadTH_Default(Pad 1.5 t)	
	PadN2=_PadTH_Default(Pad 1.5)
	_CreatePin(PadN1 -px/2:-py2/2-py1 "1")
	_CreatePin(PadN2 px/2:-py2/2-py1 "5") 
	_CreatePin(PadN2 -px/2:-py2/2 "2")	
	_CreatePin(PadN2 px/2:-py2/2 "6")		
	_CreatePin(PadN2 -px/2:py2/2 "4")
	_CreatePin(PadN2 px/2:py2/2 "8")		
	_CreatePin(PadN2 -px/2:py2/2+py1 "3")
	_CreatePin(PadN2 px/2:py2/2+py1 "7")

	for(asm 0 1
		if(asm==1 _Layer(lPkgGeoAsmT) _Layer(lPkgGeoSilkT));assembly/silkscreen

		p1=_PolyCreate(_ShapeRectangle(bX bY-10 0:0 2))
		p2=_PolyCreate(_ShapeRectangle(px+5 bY-2)) 
		p3=_PolyCreate(_ShapeRectangle(5 bY -px/2:0))
		p4=_PolyCreate(_ShapeRectangle(5 bY px/2:0))
		polys=_PolyOp(list(p1 p2 p3 p4) 'OR)
		polyBound=axlPolyExpand(polys Courtyard 'NONE)
		foreach(poly polys _CreateObjPath(axlDBCreateShape(poly t) SilkWidth*4))

		x=px/2 y1=(bY-10)/2 y2=(bY-2)/2
		_Line(list(-x-2.5:y1 -x-2.5:-y1) SilkWidth*4 )
		_Line(list(-x+2.5:y2 -x+2.5:-y2) SilkWidth*4 )
		_Line(list(x+2.5:y1 x+2.5:-y1) SilkWidth*4 )
		_Line(list(x-2.5:y2 x-2.5:-y2) SilkWidth*4 )

		;polarity mark
		p1=-px/2-Pad/2-1-0.5:-bY/2+5-0.5
		_Triangle(p1 1.5 45)

		p4=xCoord(p1)-3:yCoord(p1)-3 r=1.6
		_Line(list(p1 xCoord(p4)+r/1.414:yCoord(p4)+r/1.414))
		_Line(list(xCoord(p4):yCoord(p4)-(r-1.0) xCoord(p4):yCoord(p4)+(r-1.0)) SilkWidth*2 )
		_Circle(r p4)
	)
	
;bound
	_Layer(lPkgGeoPlaceT)
	foreach(poly polyBound _BoundHeight(axlDBCreateShape(poly t) 31.8))

	_CrossCenter()
	_CreateRefValue(pName)

	_SaveDesign(pName)
	_MakeDevice(pName 1)
