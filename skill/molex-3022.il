;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Connector/Header
;Desc:
;Vendor:
;Count:11
;CVG64:bitmap field, not implemented yet.
;Datasheet:

	pRow      =1
	Pitch     =2.5
	pDIA      =2.05
	pHole     =1.25
	Courtyard =0.0 ;1.0

;pad
	for(col 3 15 ;col from 2 to 10
	sprintf(pName,"molex-3022-%d",col)
	_PrepareNewSym(pName)
	PN1=_PadTH_Default(pDIA pHole t) 
	PN=_PadTH_Default(pDIA pHole)	 
	_CreatePin(PN1 0:0 "1")
;_PinArray(PadN Col Row PitchX/Y (P1=0:0 bRight bUp bRowFirst bPin1 bPinNum P1Offset=0 PAngle=0 TAngle=0)
	_PinArray(PN col pRow Pitch Pitch 0:0 t t t nil)

;bound
	_Layer(lPkgGeoPlaceT)
	_BoundHeight(_ShapeRectangle(col*Pitch+Courtyard*2 pRow*Pitch+Courtyard*2) Pitch*2)

;assembly
 _Layer(lPkgGeoAsmT)
	x1=-Pitch/2 y1=-Pitch/2
	x2=(col-1)*Pitch+Pitch/2
	y2=(pRow-1)*Pitch+Pitch/2
	_Line(list(x1:y1 x2:y1 x2:y2 x1:y2 x1:y1))
	if(pRow==1 then _Line(list(x1+Pitch:y1 x1+Pitch:y2))
		else 
		_Line(list(x1+Pitch:y1 x1+Pitch:Pitch/2 x1:Pitch/2))
	)

;silkscreen
	_Layer(lPkgGeoSilkT)
	if(x1>-pDIA/2-SilkGap-SilkWidth/2 x1=-pDIA/2-SilkGap-SilkWidth/2)
	if(y1>-pDIA/2-SilkGap-SilkWidth/2 y1=-pDIA/2-SilkGap-SilkWidth/2)
	if(x2<Pitch*(col-1)+pDIA/2+SilkGap+SilkWidth/2 x2=Pitch*(col-1)+pDIA/2+SilkGap+SilkWidth/2)
	if(y2<Pitch*(pRow-1)+pDIA/2+SilkGap+SilkWidth/2 y2=Pitch*(pRow-1)+pDIA/2+SilkGap+SilkWidth/2)

	_Line(list(x1:y1 x2:y1 x2:y2 x1:y2 x1:y1))
	if((pDIA/2+SilkGap+SilkWidth/2)<(Pitch/2) then 
		if(pRow==1 then _Line(list(x1+Pitch:y1 x1+Pitch:y2))
		else 
		_Line(list(x1+Pitch:y1 x1+Pitch:Pitch/2 x1:Pitch/2))
	))
	;polarity mark
	_Triangle(0:y1 1 90)

;ref & val
	_CreateRefValue(pName)

	_SaveDesign(pName)
	_MakeDevice(pName 1)
	);for col
