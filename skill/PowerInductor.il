;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Inductor/PowerInductor
;Desc:
;Vendor:
;Count:1
;CVG64:bitmap field, not implemented yet.
;Datasheet:

	Courtyard=0.5 Heel=0.2 Toe=0.3 Side=0.2
;	pName="INDCP730X730-350" pLmin=7.3 pLmax=7.3 pTmin=1.2 pTmax=1.2 pWmin=2.0 pWmax=2.0 pA=7.3 pB=7.3 pH=3.5
	pName="INDCP600X600-330" pLmin=5.9 pLmax=6.9 pTmin=0.9 pTmax=0.9 pWmin=2.7 pWmax=3.3 pA=6.0 pB=6.0 pH=3.3

	pL=(pLmin+pLmax)/2
	pW=(pWmin+pWmax)/2
	pT=(pTmin+pTmax)/2
	if(Toe<=pLmax-pL Toe=pLmax-pL)
	if(Side<pWmax-pW Side=pWmax-pW)
	PadX=pT+Heel+Toe PadY=pW+Side
	Pitch=pLmax+Toe*2-Heel*2-PadX

	_PrepareNewSym(pName)

;pin
	PadN=_PadSMFillet(PadX PadY)
	_CreatePin(PadN -Pitch/2:0 "1")
	_CreatePin(PadN Pitch/2:0 "2")
	
;bound
	_Layer(lPkgGeoPlaceT) ;ÇÐ»»µ½PlaceTop²ã
	_BoundHeight(_ShapeRectangle(pLmax+Courtyard*2 pB+Courtyard*2) pH)

;silkscreen & assembly
	for(i 1 2
	if(i==1	_Layer(lPkgGeoSilkT) _Layer(lPkgGeoAsmT))
		_Rectangle(pA pB 0:0 0.3)
		_Circle(pA/2-0.8)
	)

;ref & val
	_CreateRefValue(pName 0:0)
	_CrossCenter()

	_SaveDesign(pName)

