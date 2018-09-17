;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:QFN/QFN
;Desc:TI's special QFN package QFN14,QFN16,QFN20,
;Vendor:TI
;Count:3
;CVG64:bitmap field, not implemented yet.
;Datasheet:

Tabs='(("TI-QFN14" 5 0.28 0.82 4.04 4.04 2.0 2.0 3.5 3.5 0.9)
("TI-QFN16" 6 0.28 0.82 4.54 4.04 2.5 2.0 4.0 3.5 9.9)
("TI-QFN20" 8 0.28 0.82 5.04 4.04 3.0 2.0 4.5 3.5 9.9))

Pitch =0.5
foreach(aTb Tabs
	pName =strcat(nth(0 aTb) fpmStrLevel)
	pPnum =nth(1 aTb) 
	pPW   =nth(2 aTb) 
	pPL   =nth(3 aTb) 
	pC1   =nth(4 aTb) 
	pC2   =nth(5 aTb)
	pTL   =nth(6 aTb) ;thermal L
	pTW   =nth(7 aTb)
	pA    =nth(8 aTb) 
	pB    =nth(9 aTb)
	pH    =nth(10 aTb) 

	_PrepareNewSym(pName)
	PadN=_PadSM(pPW pPL);pad
	_Layer(lPkgGeoAsmT) ;pin
	for(pcnt 1 2 ;left
		sprintf(PinNum,"%d",pcnt+(pcnt-1)*((pcnt-1)*2*pPnum+2))
		pos=-1.5/2+(pcnt-1)*1.5
		_Line(list(-pA/2+(pPW-SilkWidth)/2:pos -pA/2+pPL/2:pos) pPW)
		_CreatePin(PadN -(pC1-pPL)/2:pos PinNum 90))
	
	for(pcnt 1 2 ;right
		sprintf(PinNum,"%d",pPnum+1+pcnt)
		pos=-1.5/2+(pcnt-1)*1.5
		_Line(list(pA/2-(pPW-SilkWidth)/2:pos pA/2-pPL/2:pos) pPW)
		_CreatePin(PadN (pC1-pPL)/2:pos PinNum 90))

	for(pcnt 1 pPnum ;top
		sprintf(PinNum,"%d",3+pPnum+pcnt)
		pos=((pPnum-1)*Pitch)/2-(pcnt-1)*Pitch
		_Line(list(pos:pB/2-(pPW-SilkWidth)/2 pos:pB/2-pPL/2) pPW)
		_CreatePin(PadN pos:(pC2-pPL)/2 PinNum 0 90))

	for(pcnt 1 pPnum ;bottom
		sprintf(PinNum,"%d",1+pcnt)
		pos=-((pPnum-1)*Pitch)/2+(pcnt-1)*Pitch
		_Line(list(pos:-pB/2+(pPW-SilkWidth)/2 pos:-pB/2+pPL/2) pPW)
		_CreatePin(PadN pos:-(pC2-pPL)/2 PinNum 0 90))
	;thermal pad
	_Layer(lEtchT) _ShapeRectangle(pTL pTW 0:0 0.2)
	;thermal pad solder mask
	_Layer(lPkgGeoSmT) _ShapeRectangle(pTL+solder_mask_offset pTW+solder_mask_offset 0:0 0.2)

	;thermal pad paste mask
	_Layer(lPkgGeoPmT) _ShapeCircleArray(pTL pTW 0:0 1)

	;bound
	_Layer(lPkgGeoPlaceT)
	_BoundHeight(_ShapeRectangle(pA+SilkGap*2+SilkWidth*2 pB+SilkGap*2+SilkWidth*2) pH)

	;silk
	_Layer(lPkgGeoSilkT)
	dx=pA/2+SilkGap	dy=pB/2+SilkGap
	;dx=pA/2 dy=pB/2 
	x0=dx-(Pitch*(pPnum-1)/2+pPW/2+SilkGap+SilkWidth/2)
	if(x0<0 then dx=dx-x0 x0=0)
	y0=dy-(1.5/2+pPW/2+SilkGap+SilkWidth/2)
	if(y0<0 then dy=dy-y0 y0=0)
	_Line(list(-dx:dy-y0 -dx:dy -dx+x0:dy))
	_Line(list(dx:dy-y0 dx:dy dx-x0:dy))
	_Line(list(-dx:-dy+y0 -dx:-dy -dx+x0:-dy))
	_Line(list(dx:-dy+y0 dx:-dy dx-x0:-dy))

	;polarity mark
	_Dot(-dx-0.2:0 0.5)
    
	;assembly
	_Layer(lPkgGeoAsmT)
	_Dot(-pA/2+0.5:0 0.8)
	_Rectangle(pA pB)

	_CrossCenter()
	_CreateRefValue(pName)
	
	_SaveDesign(pName)
	_MakeDevice(pName)
);foreach
