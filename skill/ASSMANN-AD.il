;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Connector/DB-9/15/25/37
;Desc:ASSMANN AD series DB9,DB15,DB25,DB37,male/female
;Vendor:ASSMANN
;Count:8
;CVG64:bitmap field, not implemented yet.
;Datasheet:

	Tabs='(
	( 9 16.33 25.0 30.81)
	(15 24.66 33.3 39.14)
	(25 38.38 47.1 53.04)
	(37 54.84 63.5 69.32))

	Px=2.77 Py=2.84 pH=12.55
	PadNs=_PadTH_Default(1.85 1.1)
	mtgPadN=_PadTH_Default(5.05 3.05)

 foreach(aTb Tabs
	Pin      =nth(0 aTb) 
	A        =nth(1 aTb) 
	B        =nth(2 aTb) 
	C        =nth(3 aTb) 

	for(female 1 2
	sprintf(pName,"ASSMANN-AD-X-%d",Pin)
	if(female==1 pName=strcat(pName "-F") pName=strcat(pName "-S"))
	_PrepareNewSym(pName)

	;pin
	x0=(((Pin-1)/2-1)*Px)/2.0 y0=8.1
	if(female==1 then 
	_PinArray(PadNs (Pin-1)/2 1 Px 0 x0:y0 nil t t t t (Pin-1)/2+1)
	_PinArray(PadNs (Pin-1)/2+1 1 Px 0 x0+Px/2.0:y0+Py nil)
	else
	_PinArray(PadNs (Pin-1)/2 1 Px 0 -x0:y0 t t t t t (Pin-1)/2+1)
	_PinArray(PadNs (Pin-1)/2+1 1 Px 0 -x0-Px/2.0:y0+Py))

	_PinArray(mtgPadN 2 1 B 0 -B/2:y0+Py/2 t t t t t 0 0 0 1 "S")
	
	Y1=5.97 Y2=18.33-Y1 X1=C-B-0.5 Yth1=2.4 Yth2=4.2
	;bound
	_Layer(lPkgGeoPlaceT) _BoundHeight(_ShapeRectangle(C+1 Y2-Yth1+1 0:(Y2+Yth1)/2+0.5) pH)
	_Layer(lPkgGeoDfaT) _BoundHeight(_ShapeRectangle(C Y2 0:Y2/2) pH)

	;silkscreen & assembly
	for(i 1 2 if(i==1 _Layer(lPkgGeoSilkT) _Layer(lPkgGeoAsmT))
		_Rectangle(C Y2 0:Y2/2)
		_Rectangle(A Y1 0:-Y1/2.0 0.5)
		_Line(list(-C/2:Yth1 C/2:Yth1)) _Cross(0:0 2)

		for(j 1 2 if(j==1 k=-1 k=1)
			_Rectangle((C-A)/2 Y2-Yth2 k*(C/2-(C-A)/4):(Y2+Yth2)/2)
			_Rectangle(2.5 3 k*B/2:Yth2+3/2)
			_Rectangle(X1 4.5 k*B/2:-4.5/2) _Rectangle(3.0 4.5 k*B/2:-4.5/2)
			_Cross(k*B/2:0 2))
	)

	;ref & val
	_CreateRefValue(pName 0:Y2+tSilkHeight/2+SilkWidth 0:-Y1/2)

	_SaveDesign(pName)
	);for female
	);foreach
