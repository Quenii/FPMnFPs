;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
	Courtyard=0.5 Toe=0.4 Side=0.1 Pitch=2.85
	pName="SFECV107" pT=1.2 pA=6.9 pB=2.9 pH=1.5

	PadX=pT+Side*2 PadY=pB+Toe*2

	_PrepareNewSym(pName)

;pin
	PadName=_PadSMFillet(PadX PadY)
	_CreatePin(PadName -Pitch:0 "3")
	_CreatePin(PadName 0:0 "2")
	_CreatePin(PadName Pitch:0 "1")
	
;bound
	_Layer(lPkgGeoPlaceT)
	_BoundHeight(_ShapeRectangle(pA+Courtyard*2 pB+Courtyard*2) pH)

;silkscreen & assembly
	for(i 1 2
	if(i==1	_Layer(lPkgGeoSilkT) _Layer(lPkgGeoAsmT))
		_Rectangle(pA pB)
		if(i==2 then 
		cnt=fix(pT/SilkWidth)
		for(j -1 1 
		for(k 0 cnt+1
		_Line(list(j*Pitch-pT/2+k*SilkWidth:pB/2 j*Pitch-pT/2+k*SilkWidth:-pB/2))
		)))
	)

;ref & val
	_CreateRefValue(pName 0:0)
	_CrossCenter()

	_SaveDesign(pName)

