;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Crystal/Crystal
;Desc:
;Vendor:
;Count:1
;CVG64:bitmap field, not implemented yet.
;Datasheet:

	Courtyard=0.3 Toe=0.5 Heel=0.2 Side=0.1
	pName="FX-532A" pA=5.0 pAt=0.2 pB=3.2 pBt=0.2 pW=1.4 pWt=0.2 pS=3.0 pSt=0.2 pH=1.0

	PadX=(pA-pS)/2+Toe+Heel PadY=pW+pWt+Side*2

	_PrepareNewSym(pName)

;pin
	PadN=_PadSMFillet(PadX PadY)
	_CreatePin(PadN -(pA/2+Toe-PadX/2):0 "1")
	_CreatePin(PadN (pA/2+Toe-PadX/2):0 "2")
	
;bound
	_Layer(lPkgGeoPlaceT) _BoundHeight(_ShapeRectangle(pA+Toe*2+Courtyard*2 pB+Courtyard*2) pH)

;silkscreen & assembly
	for(i 1 2 if(i==1	_Layer(lPkgGeoSilkT) _Layer(lPkgGeoAsmT)) _Rectangle(pA pB 0:0 0.2))

;ref & val
	_CreateRefValue(pName 0:0)
	_CrossCenter()

	_SaveDesign(pName)
