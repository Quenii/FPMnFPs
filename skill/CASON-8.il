;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:CASON/cason
;Desc: ATMEL's DataFlash
;Vendor:ATMEL
;Count:1
;CVG64:bitmap field, not implemented yet.
;Datasheet:

	pName  ="CASON127P800X600X100-8"
	pPin   =8
	pAmin  =7.9
	pAmax  =8.1
		pAvg  =(pAmin+pAmax)/2.0
	pTmin   =0.67;0.92
	pTmax   =0.67;1.02
	pWmin   =.41
	pWmax   =.41
	pB      =6
	pH      =1
	Pitch   =1.27

;calc
	_Protrusion_calc(LeadlessCastellated)
	Side=0.05 Heel=0.1
	pX   =pTmax+Heel+Toe
	pY   =pWmax+Side*2
	pC   =pAvg-0.2+2*Toe-pX
	pX1   =1.02+Heel+Toe
	pC1   =pAvg-0.2+2*Toe-pX1

	_PrepareNewSym(pName)
;pin 1
	PadN1=_PadSMFillet(1.02+Heel+Toe pY);
	PadN2=_PadSMFillet(pX pY);
	_CreatePin(PadN1 -pC1/2:(pPin/2-1)*Pitch/2 "1")
;_PinArray(PadN Col Row PitchX/Y (P1=0:0 bRight bUp bRowFirst bPin1 bPinNum P1Offset=0 PAngle=0 TAngle=0)
	_PinArray(PadN2 1 pPin/2 1 Pitch -pC/2:(pPin/2-1)*Pitch/2 t nil t nil)
	_PinArray(PadN2 1 pPin/2 1 Pitch pC/2:-(pPin/2-1)*Pitch/2 t t t t t pPin/2)

;bound
	_Layer(lPkgGeoPlaceT) _BoundHeight(_ShapeRectangle(pC+pX+Courtyard*2 pB+Courtyard*2) pH)
	_Layer(lPkgGeoDfaT) _BoundHeight(_ShapeRectangle(pAmax pB) pH "SON")

;silkscreen
	for(asm 0 1 if(asm==1 _Layer(lPkgGeoAsmT) _Layer(lPkgGeoSilkT));silkscreen ;assembly
		_Rectangle(pAvg pB)
		if(asm==0 _Dot(-pAvg/2-SilkWidth-0.25:(pPin/2-1)*Pitch/2+pY/2+SilkGap+0.25 0.5)
		_Dot(-pAvg/2+SilkWidth+0.25:pB/2-0.25-SilkWidth 0.5)))

	_CrossCenter()
	_CreateRefValue(pName 0:-pB/2-tSilkHeight/2-SilkWidth)

	_SaveDesign(pName)
	_MakeDevice(pName)

