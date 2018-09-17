;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Connector/Header
;Desc:
;Vendor:
;Count:19
;CVG64:bitmap field, not implemented yet.
;Datasheet:

Tabs='(
(2  10.16)
(3  15.24)
(4  20.32)
(5  25.40)
(6  30.48)
(7  35.56)
(8  40.64)
(9  45.72)
(10 50.80)
(11 55.88)
(12 60.96)
(13 66.04)
(14 71.12)
(15 76.20)
(16 81.28)
(17 86.36)
(18 91.44)
(19 96.52)
(20 101.60))

Courtyard=1.0 pH=6.0 Pitch=5.08

foreach(aTb Tabs
	CKTS =nth(0 aTb) 
	A    =nth(1 aTb) 

	sprintf(pName,"MOLEX-3002A-%d",CKTS)
	_PrepareNewSym(pName)

	PadN=_PadTH_Default(2.55 1.55)
	for(col 1 CKTS
		sprintf(pNum,"%d",col)
		x0=-(CKTS-1)*Pitch/2+Pitch*(col-1)
		_CreatePin(PadN x0:-7.7 pNum)
	)
	
;bound
	bound=axlDBCreateRectangle(list(-A/2-Courtyard:-11.5-Courtyard A/2+Courtyard:0) t lPkgGeoPlaceT)
	_BoundHeight(bound pH)

;silkscreen & assembly
	for(i 1 2
		case(i
		(1 _Layer(lPkgGeoSilkT))
		(2 _Layer(lPkgGeoAsmT)))
			_Triangle(-A/2-SilkGap:-7.7 2 0)
			_Rectangle(A 11.5 0:-11.5/2)
			_Rectangle(0.94 5.0 -A/2+0.94/2:-5.0/2)
			_Rectangle(0.94 5.0 A/2-0.94/2:-5.0/2)
			if(i==2 then
				for(col 1 CKTS
					x0=-(CKTS-1)*Pitch/2+Pitch*(col-1)
					_Line(list(x0:0 x0:-7.7) 1.25)
				)
			)
		)

;ref & val
	_CreateRefValue(pName 0:-11.5-tSilkHeight/2)
;	_CrossCenter()

	_SaveDesign(pName)
	_MakeDevice(pName 2) ;0-IC 1-IO 2-DISCRETE
);foreach
