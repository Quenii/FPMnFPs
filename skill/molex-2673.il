;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Connector/Header
;Desc:
;Vendor:
;Count:14
;CVG64:bitmap field, not implemented yet.
;Datasheet:

Tabs='(
(2  8.97 )
(3  14.05)
(4  19.13)
(5  24.21)
(6  29.29)
(7  34.37)
(8  39.45)
(9  44.53)
(10 49.61)
(11 54.69)
(12 59.77)
(13 64.85)
(14 69.93)
(15 75.01))

Courtyard=1.0 pH=4.95+3.18 pBot=6.35 Pitch=5.08

foreach(aTb Tabs
	CKTS =nth(0 aTb) 
	A    =nth(1 aTb) 

	sprintf(pName,"MOLEX-2673-%d",CKTS)
	_PrepareNewSym(pName)

	PadN=_PadTH_Default(2.9 1.75)
;_PinArray(PadN Col Row PitchX/Y (P1=0:0 bRight bUp bRowFirst bPin1 bPinNum P1Offset=0 PAngle=0 TAngle=0)
	_PinArray(PadN CKTS 1 Pitch 0 -(CKTS-1)*Pitch/2:0)
	
;bound
	_Layer(lPkgGeoPlaceT)
	_BoundHeight(_ShapeRectangle(A+Courtyard*2 pBot+Courtyard 0:Courtyard/2) pH)

;silkscreen & assembly
	for(i 1 2
		case(i 
		(1 _Layer(lPkgGeoSilkT))	
		(2 _Layer(lPkgGeoAsmT)))
		_Rectangle(A pBot)
		_Triangle(-(CKTS-1)*Pitch/2:pBot/2+SilkGap 2.0 270)
		if(i==2 then
			for(col 1 CKTS
				x0=-(CKTS-1)*Pitch/2+Pitch*(col-1)
				_Line(list(x0:0 x0:-19.35) 1.14)
			)
		)
	)

;ref & val
	_CreateRefValue(pName 0:pBot/2+tSilkHeight/2)
;	_CrossCenter()

	_SaveDesign(pName)
	_MakeDevice(pName 2) ;0-IC 1-IO 2-DISCRETE
);foreach
