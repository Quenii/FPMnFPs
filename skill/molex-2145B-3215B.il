;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Connector/Header
;Desc:
;Vendor:
;Count:14
;CVG64:bitmap field, not implemented yet.
;Datasheet:

Tabs='(
(2  7.82 ) (3  11.79) (4  15.75) (5  19.71)
(6  23.07) (7  27.64) (8  31.60) (9  35.56)
(10 39.52) (11 43.48) (12 47.45) (13 51.41)
(14 55.37) (15 59.33))

Courtyard=1.0 pH=6.35 pBot=6.35 pTop=pBot+3.9+1.5 Pitch=3.96

foreach(aTb Tabs
	CKTS =nth(0 aTb) 
	A    =nth(1 aTb) 

	sprintf(pName,"MOLEX-2145-3215-%d",CKTS)
	_PrepareNewSym(pName)

	PadN=_PadTH_Default(1.85 1.1)
;_PadTH_NP(0 pHole pPadTop pPadInner pPadBot pThermal pSolderMask pAssembly pAnti pKeepout)
	MtgPadN=_PadTH_NP(list(0 2.54 1.0 1.0 1.0 3.0 3.0 3.0 3.0 3.0))
;_PinArray(PadN Col Row PitchX/Y (P1=0:0 bRight bUp bRowFirst bPin1 bPinNum P1Offset=0 PAngle=0 TAngle=0)
	_PinArray(PadN CKTS 1 Pitch 0 (CKTS-1)*Pitch/2:-3.35/2 nil)
	_PinArray(MtgPadN CKTS 1 Pitch 0 (CKTS-1)*Pitch/2:3.35/2 nil t t t nil)
	
;bound
	_Layer(lPkgGeoPlaceT)
	bound=axlDBCreateRectangle(list(-A/2-Courtyard:-pBot/2-3.9 A/2+Courtyard:pBot/2+1.5+Courtyard) t)
	_BoundHeight(bound pH)
	_Layer(lPkgGeoPlaceB)
	bound=_ShapeRectangle(A+Courtyard*2 pBot+Courtyard*2)
	_BoundHeight(bound)

;silkscreen & assembly
	for(i 1 4
		case(i
		(1 _Layer(lPkgGeoSilkT))
		(2 _Layer(lPkgGeoAsmT))
		(3 _Layer(lPkgGeoSilkB))
		(4 _Layer(lPkgGeoAsmB)))
		_Rectangle(A pBot)
		if(i>2 then 
			_Triangle((CKTS-1)*Pitch/2:-pBot/2-SilkGap 2.0 90)
			else
			_Triangle(A/2+SilkGap:-3.35/2 2.0 180)
			_Rectangle(A 1.5 0:pBot/2+1.5/2)
			_Rectangle(0.94 3.9 -A/2+0.94/2:-pBot/2-3.9/2)
			_Rectangle(0.94 3.9 A/2-0.94/2:-pBot/2-3.9/2)
		)
	)

;ref & val
	_CreateRefValue(pName 0:-pBot/2-3.9/2)
;	_CrossCenter()

	_SaveDesign(pName)
;	_MakeDevice(pName 2) ;0-IC 1-IO 2-DISCRETE
);foreach
