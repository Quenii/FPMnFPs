;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Connector/Recept
;Desc:Connector HRS FX2C Series Straight-Recept.
;Vendor:
;Count:18
;CVG64:bitmap field, not implemented yet.
;Datasheet:

	Tabs='(
	(20 22.750 11.430 17.630 19.050)
	(32 30.370 19.050 25.250 26.670)
	(40 35.450 24.130 30.330 31.750)
	(52 43.070 31.750 37.950 39.370)
	(60 48.150 36.830 43.030 44.450)
	(68 53.230 41.910 48.110 49.530)
	(80 60.850 49.530 55.730 57.150)
	(100 73.550 62.230 68.430 69.850)
	(120 86.250 74.930 81.130 82.550))

	Pitch     =1.27
	PitchY    =1.905
	for(lock 0 1
	foreach(aTb Tabs
	pPin      =nth(0 aTb) 
	pA        =nth(1 aTb) 
	pB        =nth(2 aTb) 
	pC        =nth(3 aTb) 
	pD        =nth(4 aTb) 

	sprintf(pName,"HIROSE-FX2C-%dS-127DSA",pPin)
	if(lock==1 pName=strcat(pName "L"))
	_PrepareNewSym(pName)

	if(lock==1 then
		mtgPadN=_PadTH_Default(2.4 2.4)
		_CreatePinMechanical(mtgPadN pC/2:0) 
		_CreatePinMechanical(mtgPadN -pC/2:0) 
	)
	PadN=_PadTH_Default(1.5 0.9)
	cx=(pPin/4-1)*2.54/2
;pin
	for(row 1 4
		for(pnum 1 pPin/4
			case( row
			(1 x=cx-1.27/2 y=-PitchY-PitchY/2 sprintf(pin_name,"A%d",pnum*2))
			(2 x=cx+1.27/2 y=-PitchY/2 sprintf(pin_name,"A%d",pnum*2-1))
			(3 x=cx-1.27/2 y=PitchY/2 sprintf(pin_name,"B%d",pnum*2))
			(4 x=cx+1.27/2 y=PitchY+PitchY/2 sprintf(pin_name,"B%d",pnum*2-1))
			)
			_CreatePin(PadN x-(pnum-1)*Pitch*2:y pin_name)
		);for
	)

;bound
	_Layer(lPkgGeoPlaceT)
	_BoundHeight(_ShapeRectangle(pA+2 9.0) 7)

;silkscreen & assembly
	for(i 1 2
	if(i==1	_Layer(lPkgGeoSilkT) _Layer(lPkgGeoAsmT))
	_Line(list(-pA/2:-3.5 pA/2:-3.5 pA/2:3.5 -pA/2:3.5 -pA/2:-3.5))

	p1=pC/2:-5.1/2 p2=p1 
	p1=xCoord(p1)-.6:yCoord(p1)
	p2=pC/2-0.1:yCoord(p1)+0.6
	p3=pC/2-1.2:5.1/2-0.3
	p4=xCoord(p3)-0.3:5.1/2
	p5=-xCoord(p1):yCoord(p1)
	p6=-xCoord(p2):yCoord(p2)
	p7=-xCoord(p3):yCoord(p3)
	p8=-xCoord(p4):yCoord(p4)
	path = axlPathStart( list( p5))
	axlPathLine(path SilkWidth p1) axlPathArcAngle(path SilkWidth p2 nil 100)
	axlPathLine(path SilkWidth p3) axlPathArcAngle(path SilkWidth p4 nil 60)
	axlPathLine(path SilkWidth p8) axlPathArcAngle(path SilkWidth p7 nil 60)
	axlPathLine(path SilkWidth p6) axlPathArcAngle(path SilkWidth p5 nil 100)
	axlDBCreatePath(path)
	;polarity mark
	_Triangle(cx+1.27/2:-3.5 1 90)
	)

;ref & val
	_CreateRefValue(pName)

	_SaveDesign(pName)
	);foreach
	);lock

