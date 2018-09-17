;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Crystal/Crystal
;Desc:generic HC49US smd
;Vendor:Richard L.
;Count:1
;CVG64:bitmap field, not implemented yet.
;Datasheet:

	Courtyard=0.5
	PGap=3.9
	pX=11.05 pY=4.8
	PadX=5.0 PadY=2.0
	Pitch=PGap+PadX
	pXmax=PadX+Pitch

	LeadX=(12.7-4.88)/2
	LeadY=0.5
	LeadGap=4.88

	pName="HC49US"
	_PrepareNewSym(pName)

;pin
	oldFilletR=FilletR;backup FilletR
	FilletR=0.5 PadN=_PadSMFillet(PadX PadY)
	_CreatePin(PadN -Pitch/2:0 "1")
	_CreatePin(PadN Pitch/2:0 "2")
	FilletR=oldFilletR;restore FilletR
	
;bound
	_Layer(lPkgGeoPlaceT)
	_BoundHeight(_ShapeRectangle(LeadGap+LeadX*2+Courtyard*2 pY+2*Courtyard) 4.2)
	_Layer(lPkgGeoDfaT) 
	_BoundHeight(_ShapeRectangle(LeadGap+LeadX*2 pY) 4.2 "HC49US")

;silkscreen & assembly
	for(i 1 2
	if(i==1	_Layer(lPkgGeoSilkT) _Layer(lPkgGeoAsmT))
		_Rectangle(pX pY 0:0 0.5)
		if(i==2 then
			_Line(list(-LeadGap/2:0 -LeadGap/2-LeadX:0) LeadY)
			_Line(list(LeadGap/2:0 LeadGap/2+LeadX:0) LeadY))
	)

;ref & val
	_CreateRefValue(pName 0:0)
	_CrossCenter()

	_SaveDesign(pName)
	_MakeDevice(pName 2)

