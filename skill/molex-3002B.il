;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Connector/Header
;Desc:
;Vendor:
;Count:19
;CVG64:bitmap field, not implemented yet.
;Datasheet:

Tabs='(
( 2  10.16)
( 3  15.24)
( 4  20.32)
( 5  25.40)
( 6  30.48)
( 7  35.56)
( 8  40.64)
( 9  45.72)
(10  50.80)
(11  55.88)
(12  60.96)
(13  66.04)
(14  71.12)
(15  76.20)
(16  81.28)
(17  86.36)
(18  91.44)
(19  96.52)
(20  101.60))

Courtyard=1.0 pH=11.5 pBot=6.0 pTop=pBot+4 Pitch=5.08

foreach(aTb Tabs
	CKTS =nth(0 aTb) 
	A    =nth(1 aTb) 

	sprintf(pName,"MOLEX-3002B-%d",CKTS)
	_PrepareNewSym(pName)

;_PadTH_NP(0 pHole pPadTop pPadInner pPadBot pThermal pSolderMask pAssembly pAnti pKeepout)
	MtgPadN=_PadTH_NP(list(0 2.54 1.0 1.0 1.0 3.0 3.0 3.0 3.0 3.0))
	PadN=_PadTH_Default(1.75 1.05)
	for(col 1 CKTS
		sprintf(pNum,"%d",col)
		x0=(CKTS-1)*Pitch/2-Pitch*(col-1)
		_CreatePin(PadN x0:-3.3/2 pNum)
		_CreatePinMechanical(MtgPadN x0:3.3/2)
	)
	
;bound
	_Layer(lPkgGeoPlaceT)
	bound=axlDBCreateRectangle(list(-A/2-Courtyard:-pBot/2-4.0 A/2+Courtyard:pBot/2+Courtyard) t)
	_BoundHeight(bound pH)

	_Layer(lPkgGeoPlaceB)
	_BoundHeight(_ShapeRectangle(A+Courtyard*2 pBot+Courtyard 0:-Courtyard/2))

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
			_Triangle(A/2+SilkGap:-3.3/2 2.0 180)
			_Rectangle(0.94 4.0 -A/2+0.94/2:-pBot/2-4.0/2)
			_Rectangle(0.94 4.0 A/2-0.94/2:-pBot/2-4.0/2)
		)
	)

;ref & val
	_CreateRefValue(pName 0:-pBot/2-4.0/2)
;	_CrossCenter()

	_SaveDesign(pName)
	_MakeDevice(pName 2) ;0-IC 1-IO 2-DISCRETE
);foreach
