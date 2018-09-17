;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Connector/DDR
;Desc:
;Vendor:YAMAICHI
;Count:2
;CVG64:bitmap field, not implemented yet.
;Datasheet:

Courtyard=1.0
Pitch=2.0
pB=17.00;body width

;_PadTH_NP(0 pHole pPadTop pPadInner pPadBot pThermal pSolderMask pAssembly pAnti pKeepout)
;PadNpName=_PadTH_NP('(0 1.02 0.2 0.2 0.2 1.5 1.02 1.02 1.5 1.5))

for(ls2 0 1 ;locking screw?
	if(ls2==0 pA=153.7 pA=171.7)

	sprintf(pName,"YAMAICHI-IC595")
	if(ls2==0 pName=strcat(pName "-1") pName=strcat(pName "-2"))
	_PrepareNewSym(pName)

	if(ls2==1 then ;has lock screw?
		PadN=_PadTH('(0 0 3.2 4.4 4.4 7.0 4.9 4.4 4.9 0.5))
		_CreatePinMechanical(PadN 162.7/2:0)
		_CreatePinMechanical(PadN -162.7/2:0)
	)

	_PadTH('(0 0.5 0.8 1.35 1.35 1.35 1.6 1.3 1.6 0.4) t)
	PadN=_PadTH('(0 0.5 0.8 1.35 1.35 1.35 1.6 1.3 1.6 0.4))
	PadNs=strcat(PadN "S")
;pin
	pnstart=0
	x0=-123.0/2
	for(row 1 4
		case(row 
			(1 x=x0 y=-8.0/2 pnstart=1)
			(2 x=x0+1.0 y=-4.8/2 pnstart=2)
			(3 x=x0 y=4.8/2 pnstart=121)
			(4 x=x0+1.0 y=8.0/2 pnstart=122)
		)
		for(col 1 32 ;numbered-pins
			sprintf(pin_name,"%d",pnstart+(col-1)*2)
			if((col==1 && row==1) then _CreatePin(PadNs x+(col-1)*2.0:y pin_name)
			else _CreatePin(PadN x+(col-1)*2.0:y pin_name))
		);row
	);bank
	for(row 1 4
		case(row 
			(1 x=x0+34*2.0 y=-8.0/2 pnstart=65)
			(2 x=x0+34*2.0+1.0 y=-4.8/2 pnstart=66)
			(3 x=x0+34*2.0 y=4.8/2 pnstart=185)
			(4 x=x0+34*2.0+1.0 y=8.0/2 pnstart=186)
		)
		for(col 1 28 ;numbered-pins
			sprintf(pin_name,"%d",pnstart+(col-1)*2)
			_CreatePin(PadN x+(col-1)*2.0:y pin_name)
		);row
	);bank

;bound
	_Layer(lPkgGeoPlaceT)
	_BoundHeight(_ShapeRectangle(pA+2*Courtyard pB+2*Courtyard) 34.1)

;silkscreen & assembly
	for(i 1 2
		if(i==1	_Layer(lPkgGeoSilkT) _Layer(lPkgGeoAsmT))
		_Rectangle(pA pB)
		if(ls2==1 then
			_Line(list(-153.7/2:pB/2 -153.7/2:-pB/2))
			_Line(list(153.7/2:pB/2 153.7/2:-pB/2))
		)
	)
;ref & val
	_CreateRefValue(pName) ;default (0:0), i.e. _CreateRefValue(pName)
	_CrossCenter() ;pick-place marker (0:0)

	_SaveDesign(pName)
);ls2

