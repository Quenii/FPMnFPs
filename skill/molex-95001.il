;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Connector/Header
;Desc:
;Vendor:
;Count:12
;CVG64:bitmap field, not implemented yet.
;Datasheet:

	Tabs='(
	(11.18 7.62  4 4)
	(13.21 10.16 6 4)
	(13.21 10.16 6 6)
	(15.24 11.43 8 4)
	(15.24 11.43 8 6)
	(15.24 11.43 8 8))

	Courtyard=1.0 pH=11.5 pD=18.1 Pitch=1.27 pFront=7.88 pBack=8.89

 foreach(aTb Tabs
	A        =nth(0 aTb) 
	C        =nth(1 aTb) 
	POS      =nth(2 aTb) 
	CKTS     =nth(3 aTb) 

	for(sm 0 1
		if(sm==1 pre="6" pre="2")
		sprintf(pName,"MOLEX-95001-%s%d%d1",pre,POS,CKTS)
		_PrepareNewSym(pName)

	;pin
		if(sm==1 PadN=_PadSMFillet(6.35 0.76) PadN=_PadTH_Default(1.5 0.7))
		turnRight=nil
		y0=(CKTS-1)*Pitch/2
		x0=pFront+pBack if(CKTS!=6 then x0=x0-Pitch*2 turnRight=t)
		if(sm==1 x0=pFront+13.4-6.35/2)
		for(row 1 CKTS
			sprintf(pNum,"%d",row)
			_CreatePin(PadN x0:y0 pNum)
			if(sm==0 then if(turnRight x0=x0+Pitch*2 x0=x0-Pitch*2))
			turnRight=!turnRight
			y0=y0-Pitch
		)
;_PadTH_NP(0 pHole pPadTop pPadInner pPadBot pThermal pSolderMask pAssembly pAnti pKeepout)
		MtgPadN=_PadTH_NP(list(0 3.2 1.0 1.0 1.0 4.4 4.4 4.4 4.4 4.4))
		_CreatePinMechanical(MtgPadN pFront:-C/2)
		_CreatePinMechanical(MtgPadN pFront:C/2)
		
	;bound
		_Layer(lPkgGeoPlaceT)
		bound=axlDBCreateRectangle(list(pFront-3:-A/2-Courtyard pD+Courtyard:A/2+Courtyard) t)
		_BoundHeight(bound pH)

	;silkscreen & assembly
		for(i 1 2
		if(i==1	_Layer(lPkgGeoSilkT) _Layer(lPkgGeoAsmT))
			_Rectangle(pD A pD/2:0 0.2)
			_Line(list(0:0 2:0))
			if(i==2 then 
				_Rectangle((pD-1-pFront-pBack+Pitch)*2 A-2 pFront+pBack-Pitch:0 0.2)
				y0=(CKTS-1)*Pitch/2
				for(row 1 CKTS
					_Line(list(pFront+pBack-Pitch:y0 pFront-2:y0) 0.7 )
					y0=y0-Pitch
				)
			)
		)

	;ref & val
		_CreateRefValue(pName pFront/2:0)
	;	_CrossCenter()

		_SaveDesign(pName)
	) ;sm
	);foreach
