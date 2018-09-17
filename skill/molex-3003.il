;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Connector/Header
;Desc:
;Vendor:
;Count:19
;CVG64:bitmap field, not implemented yet.
;Datasheet:

Tabs='(
(2   9.91)
(3  14.99)
(4  20.07)
(5  25.15)
(6  30.23)
(7  35.31)
(8  40.39)
(9  45.47)
(10 50.55)
(11 55.63)
(12 60.71)
(13 65.79)
(14 70.87)
(15 75.95)
(16 81.03)
(17 86.11)
(18 91.19)
(19 96.27)
(20 101.35))

Courtyard=1.0 pH=11.94+3.17 Pitch=5.08

foreach(aTb Tabs
	CKTS =nth(0 aTb) 
	A    =nth(1 aTb) 

	sprintf(pName,"MOLEX-3003-%d",CKTS)
	_PrepareNewSym(pName)

	PadN=_PadTH_Default(2.55 1.57)
;_PinArray(PadN Col Row PitchX/Y (P1=0:0 bRight bUp bRowFirst bPin1 bPinNum P1Offset=0 PAngle=0 TAngle=0)
	_PinArray(PadN CKTS 1 Pitch 0 -(CKTS-1)*Pitch/2:0)
;bound
	_Layer(lPkgGeoPlaceT)
	_BoundHeight(_ShapeRectangle(A+Courtyard*2 6.35+Courtyard*2) pH)

;silkscreen & assembly
	for(i 1 2
		case(i
		(1 _Layer(lPkgGeoSilkT))
		(2 _Layer(lPkgGeoAsmT)))
			_Triangle(-(CKTS-1)*Pitch/2:-6.35/2 2 90)
			_Rectangle(A 6.35)
		)

;ref & val
	_CreateRefValue(pName 0:-6.35/2-tSilkHeight/2)
;	_CrossCenter()

	_SaveDesign(pName)
	_MakeDevice(pName 2) ;0-IC 1-IO 2-DISCRETE
);foreach
