;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Inductor/PowerInductor
;Desc:Power Inductor
;Vendor:SUMIDA
;Count:1
;CVG64:bitmap field, not implemented yet.
;Datasheet:

	Courtyard=0.5 Heel=0.3 Toe=0.4 Side=0.2
	pName="SUMIDA-CDRH125" 
	pA=12.3 pB=12.3 pH=6.0

	pL=11.8
	pW=5.0
	pT=(11.8-7.6)/2
	PadX=pT+Heel+Toe PadY=pW+Side
	Pitch=pL+Toe*2-PadX

	_PrepareNewSym(pName)

;pin
	PadN=_PadSMFillet(PadX PadY)
	_CreatePin(PadN -Pitch/2:0 "1")
	_CreatePin(PadN Pitch/2:0 "2")
	
;bound
	_Layer(lPkgGeoPlaceT) ;ÇÐ»»µ½PlaceTop²ã
	_BoundHeight(_ShapeRectangle(pA+Courtyard*2 pB+Courtyard*2) pH)

;silkscreen & assembly
	for(i 1 2
	if(i==1	_Layer(lPkgGeoSilkT) _Layer(lPkgGeoAsmT))
		_Rectangle(pA pB 0:0 0.8)
		_Circle(pA/2-0.8)
	)

;ref & val
	_CreateRefValue(pName 0:0)
	_CrossCenter()

	_SaveDesign(pName)

